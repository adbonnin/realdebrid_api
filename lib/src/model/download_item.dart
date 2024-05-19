part of '../../realdebrid_api.dart';

class DownloadItem {
  const DownloadItem({
    required this.id,
    required this.filename,
    required this.mimeType,
    required this.fileSize,
    required this.link,
    required this.host,
    required this.hostIcon,
    required this.chunks,
    required this.crc,
    required this.download,
    required this.streamable,
    required this.generated,
    required this.type,
    required this.alternative,
  });

  final String id;
  final String filename;
  final String? mimeType;
  final int fileSize;
  final String link;
  final String host;
  final String? hostIcon;
  final int chunks;
  final bool crc;
  final String download;
  final bool streamable;
  final String? generated;
  final String? type;
  final List<DownloadAlternative>? alternative;

  factory DownloadItem.fromJson(Map<String, Object?> json) {
    return DownloadItem(
      id: json[r'id'] as String,
      filename: json[r'filename'] as String,
      mimeType: json[r'mimeType'] as String?,
      fileSize: json[r'filesize'] as int,
      link: json[r'link'] as String,
      host: json[r'host'] as String,
      hostIcon: json[r'host_icon'] as String?,
      chunks: json[r'chunks'] as int,
      crc: json[r'crc'] != null && json[r'crc'] != 0,
      download: json[r'download'] as String,
      streamable: json[r'streamable'] != null && json[r'streamable'] != 0,
      generated: json[r'generated'] as String?,
      type: json[r'type'] as String?,
      alternative: json[r'alternative'] == null ? null : DownloadAlternative.fromJsonList(json[r'alternative'] as List<dynamic>),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    if (other is! DownloadItem) {
      return false;
    }

    return runtimeType == other.runtimeType &&
        id == other.id &&
        filename == other.filename &&
        mimeType == other.mimeType &&
        fileSize == other.fileSize &&
        link == other.link &&
        host == other.host &&
        hostIcon == other.hostIcon &&
        chunks == other.chunks &&
        crc == other.crc &&
        download == other.download &&
        streamable == other.streamable &&
        generated == other.generated &&
        type == other.type &&
        alternative == other.alternative;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        filename.hashCode ^
        mimeType.hashCode ^
        fileSize.hashCode ^
        link.hashCode ^
        host.hashCode ^
        hostIcon.hashCode ^
        chunks.hashCode ^
        crc.hashCode ^
        download.hashCode ^
        streamable.hashCode ^
        generated.hashCode ^
        type.hashCode ^
        alternative.hashCode;
  }

  @override
  String toString() {
    return 'DownloadItem{'
        'id: $id, '
        'filename: $filename, '
        'mimeType: $mimeType, '
        'fileSize: $fileSize, '
        'link: $link, '
        'host: $host, '
        'hostIcon: $hostIcon, '
        'chunks: $chunks, '
        'crc: $crc, '
        'download: $download, '
        'streamable: $streamable, '
        'generated: $generated, '
        'type: $type, '
        'alternative: $alternative'
        '}';
  }
}
