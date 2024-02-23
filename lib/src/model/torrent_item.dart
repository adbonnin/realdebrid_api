part of '../../realdebrid_api.dart';

class TorrentItem {
  const TorrentItem({
    required this.id,
    required this.filename,
    required this.originalFilename,
    required this.hash,
    required this.bytes,
    this.originalBytes,
    required this.host,
    required this.split,
    required this.progress,
    required this.status,
    required this.added,
    this.files,
    required this.links,
    this.ended,
    this.speed,
    this.seeders,
  });

  final String id;
  final String filename;
  final String? originalFilename;
  final String hash;
  final int bytes;
  final int? originalBytes;
  final String host;
  final int split;
  final double progress;
  final TorrentStatus status;
  final String added;
  final List<InnerTorrentFile>? files;
  final List<String> links;
  final String? ended;
  final int? speed;
  final int? seeders;

  static List<TorrentItem> fromJsonList(List<dynamic> json) {
    return json //
        .map((e) => TorrentItem.fromJson(e))
        .toList();
  }

  factory TorrentItem.fromJson(Map<String, Object?> json) {
    return TorrentItem(
      id: json[r'id'] as String,
      filename: json[r'filename'] as String,
      originalFilename: json[r'original_filename'] as String?,
      hash: json[r'hash'] as String,
      bytes: json[r'bytes'] as int,
      originalBytes: json[r'original_bytes'] as int?,
      host: json[r'host'] as String,
      split: json[r'split'] as int,
      progress: (json[r'progress'] as num).toDouble(),
      status: TorrentStatus.fromJson(json[r'status'] as String),
      added: json[r'added'] as String,
      files: json[r'files'] == null ? null : InnerTorrentFile.fromJsonList(json[r'files'] as List<dynamic>),
      links: (json[r'links'] as List<dynamic>).map((e) => e as String).toList(),
      ended: json[r'ended'] as String?,
      speed: json[r'speed'] as int?,
      seeders: json[r'seeders'] as int?,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    if (other is! TorrentItem) {
      return false;
    }

    return runtimeType == other.runtimeType &&
        id == other.id &&
        filename == other.filename &&
        originalFilename == other.originalFilename &&
        hash == other.hash &&
        bytes == other.bytes &&
        originalBytes == other.originalBytes &&
        host == other.host &&
        split == other.split &&
        progress == other.progress &&
        status == other.status &&
        added == other.added &&
        files == other.files &&
        links == other.links &&
        ended == other.ended &&
        speed == other.speed &&
        seeders == other.seeders;
  }

  @override
  int get hashCode {
    return id.hashCode ^ //
        filename.hashCode ^
        originalFilename.hashCode ^
        hash.hashCode ^
        bytes.hashCode ^
        originalBytes.hashCode ^
        host.hashCode ^
        split.hashCode ^
        progress.hashCode ^
        status.hashCode ^
        added.hashCode ^
        files.hashCode ^
        links.hashCode ^
        ended.hashCode ^
        speed.hashCode ^
        seeders.hashCode;
  }
}
