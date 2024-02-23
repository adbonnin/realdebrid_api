part of '../../realdebrid_api.dart';

class InnerTorrentFile {
  const InnerTorrentFile({
    required this.id,
    required this.path,
    required this.bytes,
    required this.selected,
  });

  final int id;
  final String path;
  final int bytes;
  final int selected;

  static List<InnerTorrentFile> fromJsonList(List<dynamic> json) {
    return json //
        .map((e) => InnerTorrentFile.fromJson(e))
        .toList();
  }

  factory InnerTorrentFile.fromJson(Map<String, Object?> json) {
    return InnerTorrentFile(
      id: json[r'id'] as int,
      path: json[r'path'] as String,
      bytes: json[r'bytes'] as int,
      selected: json[r'selected'] as int,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    if (other is! InnerTorrentFile) {
      return false;
    }

    return runtimeType == other.runtimeType &&
        id == other.id &&
        path == other.path &&
        bytes == other.bytes &&
        selected == other.selected;
  }

  @override
  int get hashCode {
    return id.hashCode ^ //
        path.hashCode ^
        bytes.hashCode ^
        selected.hashCode;
  }
}
