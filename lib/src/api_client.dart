import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:path/path.dart' as p;

class ApiClient {
  const ApiClient(this.baseUri, this.client);

  final Uri baseUri;
  final http.Client client;

  factory ApiClient.basicAuthentication({
    Uri? baseUri,
    required String apiToken,
    http.Client? client,
  }) {
    baseUri ??= Uri.parse('https://api.real-debrid.com/rest/1.0/');
    client ??= http.Client();
    return ApiClient(baseUri, BasicAuthenticationClient(client, apiToken: apiToken));
  }

  Future<T> send<T>(
    String method,
    String pathTemplate, {
    Map<String, String>? pathParameters,
    Map<String, String>? queryParameters,
    Map<String, String>? fieldParameters,
    Map<String, String>? headers,
    dynamic body,
  }) async {
    var path = pathTemplate;

    if (pathParameters != null) {
      for (final pathParameter in pathParameters.entries) {
        path = path.replaceAll('{${pathParameter.key}}', Uri.encodeComponent(pathParameter.value));
      }
    }

    assert(!path.contains('{'));

    if (path.startsWith('/')) {
      path = path.substring(1);
    }

    var uri = baseUri.replace(path: p.url.join(baseUri.path, path));

    if (queryParameters != null) {
      uri = uri.replace(
        queryParameters: {
          ...uri.queryParameters,
          ...queryParameters,
        },
      );
    }

    final http.BaseRequest request;

    if (fieldParameters != null) {
      request = http.MultipartRequest(method, uri) //
        ..fields.addAll(fieldParameters);
    } //
    else if (body is Uint8List) {
      request = http.Request(method, uri)
        ..headers['content-type'] = 'application/octet-stream'
        ..bodyBytes = body;
    } //
    else if (body != null) {
      request = http.Request(method, uri)
        ..headers['content-type'] = 'application/json'
        ..body = jsonEncode(body);
    } //
    else {
      request = http.Request(method, uri);
    }

    if (headers != null) {
      request.headers.addAll(headers);
    }

    final response = await http.Response.fromStream(await client.send(request));
    ApiException.checkResponse(response);

    final decoded = _decode(response);
    return decoded as T;
  }

  dynamic _decode(http.Response response) {
    final bytes = response.bodyBytes;

    if (bytes.isEmpty) {
      return null;
    }

    final responseBody = utf8.decode(bytes);
    return jsonDecode(responseBody);
  }

  void close() {
    client.close();
  }
}

class ApiException implements Exception {
  const ApiException(
    this.url,
    this.statusCode,
    this.reasonPhrase, {
    this.error,
    this.errorCode,
  });

  final Uri? url;
  final int statusCode;
  final String? reasonPhrase;
  final String? error;
  final int? errorCode;

  factory ApiException.fromResponse(http.Response response) {
    String? error;
    int? errorCode;

    if (response.body.isNotEmpty) {
      try {
        final decodedBody = jsonDecode(response.body);

        if (decodedBody is Map<String, dynamic>) {
          error = decodedBody['error'] as String?;
          errorCode = decodedBody['error_code'] as int?;
        }
      } //
      catch (e) {
        // Fail to parse as Json
      }

      error ??= response.body;
    }

    return ApiException(
      response.request?.url,
      response.statusCode,
      response.reasonPhrase,
      error: error,
      errorCode: errorCode,
    );
  }

  @override
  String toString() {
    return 'ApiException($statusCode, $reasonPhrase, '
        'url: $url, '
        'error: $error, '
        'errorCode: $errorCode)';
  }

  static void checkResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 400) {
      return;
    }

    throw ApiException.fromResponse(response);
  }
}

class BasicAuthenticationClient extends http.BaseClient {
  BasicAuthenticationClient(
    this.innerClient, {
    required this.apiToken,
  });

  final http.Client innerClient;
  final String apiToken;

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    request.headers['Authorization'] = 'Bearer $apiToken';
    return innerClient.send(request);
  }

  @override
  void close() {
    innerClient.close();
    super.close();
  }
}
