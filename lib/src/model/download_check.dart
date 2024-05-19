part of '../../realdebrid_api.dart';

class ItemCheck {
  const ItemCheck({
    required this.host,
    required this.link,
    required this.filename,
    required this.fileSize,
    required this.supported,
  });

  final String host;
  final String link;
  final String filename;
  final int fileSize;
  final bool supported;

  factory ItemCheck.fromJson(Map<String, Object?> json) {
    return ItemCheck(
      host: json[r'host'] as String,
      link: json[r'link'] as String,
      filename: json[r'filename'] as String,
      fileSize: json[r'filesize'] as int,
      supported: json[r'supported'] as int != 0,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    if (other is! ItemCheck) {
      return false;
    }

    return runtimeType == other.runtimeType &&
        host == other.host &&
        link == other.link &&
        filename == other.filename &&
        fileSize == other.fileSize &&
        supported == other.supported;
  }

  @override
  int get hashCode {
    return host.hashCode ^ //
        link.hashCode ^
        filename.hashCode ^
        fileSize.hashCode ^
        supported.hashCode;
  }

  @override
  String toString() {
    return 'ItemCheck{'
        'host: $host, '
        'link: $link, '
        'filename: $filename, '
        'fileSize: $fileSize, '
        'supported: $supported'
        '}';
  }
}
