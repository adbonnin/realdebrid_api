part of '../../realdebrid_api.dart';

class CachedAlternative {
  const CachedAlternative({
    required this.host,
    required this.cachedFiles,
  });

  final String host;
  final List<CachedFile> cachedFiles;

  static List<CachedAlternative> fromJsonList(String host, List<dynamic> json) {
    return json //
        .map((e) => CachedAlternative.fromJson(host, e as Map<String, dynamic>))
        .toList();
  }

  factory CachedAlternative.fromJson(String host, Map<String, dynamic> json) {
    final cachedFiles = json.entries //
        .map((e) => CachedFile.fromJson(int.parse(e.key), e.value))
        .toList();

    return CachedAlternative(
      host: host,
      cachedFiles: cachedFiles,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    if (other is! CachedAlternative) {
      return false;
    }

    return runtimeType == other.runtimeType && //
        host == other.host &&
        listEquals(cachedFiles, other.cachedFiles);
  }

  @override
  int get hashCode {
    return host.hashCode ^ //
        cachedFiles.hashCode;
  }
}
