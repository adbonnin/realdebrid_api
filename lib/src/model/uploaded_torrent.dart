part of '../../realdebrid_api.dart';

class UploadedTorrent {
  const UploadedTorrent({
    required this.id,
    required this.uri,
  });

  final String id;
  final String uri;

  factory UploadedTorrent.fromJson(Map<String, Object?> json) {
    return UploadedTorrent(
      id: json[r'id'] as String,
      uri: json[r'uri'] as String,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    if (other is! UploadedTorrent) {
      return false;
    }

    return runtimeType == other.runtimeType && //
        id == other.id &&
        uri == other.uri;
  }

  @override
  int get hashCode {
    return id.hashCode ^ //
        uri.hashCode;
  }
}
