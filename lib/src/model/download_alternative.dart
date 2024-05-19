part of '../../realdebrid_api.dart';

class DownloadAlternative {
  const DownloadAlternative({
    required this.id,
    required this.filename,
    required this.download,
    required this.mimeType,
    required this.quality,
  });

  final String id;
  final String filename;
  final String download;
  final String? mimeType;
  final String? quality;

  static List<DownloadAlternative> fromJsonList(List<dynamic> json) {
    return json //
        .map((e) => DownloadAlternative.fromJson(e))
        .toList();
  }

  factory DownloadAlternative.fromJson(Map<String, Object?> json) {
    return DownloadAlternative(
      id: json[r'id'] as String,
      filename: json[r'filename'] as String,
      download: json[r'download'] as String,
      mimeType: json[r'mimeType'] as String?,
      quality: json[r'quality'] as String?,
    );
  }
}
