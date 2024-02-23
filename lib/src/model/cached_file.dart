part of '../../realdebrid_api.dart';

class CachedFile {
  const CachedFile({
    required this.id,
    required this.fileName,
    required this.fileSize,
  });

  final int id;
  final String fileName;
  final int fileSize;

  factory CachedFile.fromJson(int id, Map<String, dynamic> json) {
    return CachedFile(
      id: id,
      fileName: json[r'filename'] as String,
      fileSize: json[r'filesize'] as int,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    if (other is! CachedFile) {
      return false;
    }

    return runtimeType == other.runtimeType && //
        id == other.id &&
        fileName == other.fileName &&
        fileSize == other.fileSize;
  }

  @override
  int get hashCode {
    return id.hashCode ^ //
        fileName.hashCode ^
        fileSize.hashCode;
  }
}
