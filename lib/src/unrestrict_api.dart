part of '../realdebrid_api.dart';

class UnrestrictApi {
  const UnrestrictApi(this._client);

  final ApiClient _client;

  Future<ItemCheck> getUnrestrictedCheck({
    required String link,
    String? password,
  }) async {
    return ItemCheck.fromJson(await _client.send('post', '/unrestrict/check', fieldParameters: {
      'link': link,
      if (password != null) 'password': password,
    }));
  }

  /// Check if a file is downloadable on the concerned hoster. This request is not requiring authentication.
  Future<DownloadItem> getUnrestrictedLink({
    required String link,
    String? password,
    bool? remote,
  }) async {
    return DownloadItem.fromJson(await _client.send(
      'post',
      '/unrestrict/link',
      fieldParameters: {
        'link': link,
        if (password != null) 'password': password,
        if (remote != null) 'remote': (remote ? '0' : '1'),
      },
    ));
  }

  /// Unrestrict a hoster folder link and get individual links, returns an empty array if no links found.
  Future<List<String>> getUnrestrictFolder({
    required String link,
  }) {
    return _client.send(
      'post',
      '/unrestrict/folder',
      fieldParameters: {
        'link': link,
      },
    );
  }

  /// Decrypt a container file (RSDF, CCF, CCF3, DLC)
  Future<List<String>> getUnrestrictContainerFile() {
    return _client.send(
      'put',
      '/unrestrict/containerFile',
    );
  }

  /// Decrypt a container file from a link.
  Future<List<String>> getUnnrestrictContainerLink({
    required String link,
  }) {
    return _client.send(
      'post',
      '/unrestrict/containerLink',
      fieldParameters: {
        'link': link,
      },
    );
  }
}
