part of '../../realdebrid_api.dart';

enum TorrentStatus {
  downloading,
  uploading,
  downloaded,
  magnetConversion,
  error,
  $unknown;

  factory TorrentStatus.fromJson(String json) {
    return switch (json) {
      "downloading" => TorrentStatus.downloading,
      "uploading" => TorrentStatus.uploading,
      "downloaded" => TorrentStatus.downloaded,
      "magnet_conversion" => TorrentStatus.magnetConversion,
      "error" => TorrentStatus.error,
      _ => TorrentStatus.$unknown
    };
  }
}
