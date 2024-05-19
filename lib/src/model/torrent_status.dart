part of '../../realdebrid_api.dart';

enum TorrentStatus {
  magnetError,
  magnetConversion,
  waitingFilesSelection,
  queued,
  downloading,
  downloaded,
  error,
  virus,
  compressing,
  uploading,
  dead,
  $unknown;

  static TorrentStatus fromJson(String json) {
    return switch (json) {
      'magnet_error' => TorrentStatus.magnetError,
      'magnet_conversion' => TorrentStatus.magnetConversion,
      'waiting_files_selection' => TorrentStatus.waitingFilesSelection,
      'queued' => TorrentStatus.queued,
      'downloading' => TorrentStatus.downloading,
      'downloaded' => TorrentStatus.downloaded,
      'error' => TorrentStatus.error,
      'virus' => TorrentStatus.virus,
      'compressing' => TorrentStatus.compressing,
      'uploading' => TorrentStatus.uploading,
      'dead' => TorrentStatus.dead,
      _ => TorrentStatus.$unknown,
    };
  }
}
