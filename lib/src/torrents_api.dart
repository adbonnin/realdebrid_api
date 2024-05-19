part of '../realdebrid_api.dart';

class TorrentsApi {
  const TorrentsApi(this._client);

  final ApiClient _client;

  /// Get user torrents list
  /// You can not use both offset and page at the same time, page is prioritzed in case it happens.
  Future<List<TorrentItem>> getTorrents({
    int? offset = 0,
    int? page = 1,
    int? limit = 10,
    bool activeFirst = false,
  }) async {
    final filter = activeFirst ? 'active' : null;

    return TorrentItem.fromJsonList.nullToEmpty(await _client.send(
      'get',
      '/torrents',
      queryParameters: {
        if (offset != null) 'offset': '$offset',
        if (page != null) 'page': '$page',
        if (limit != null) 'limit': '$limit',
        if (filter != null) 'filter': filter,
      },
    ));
  }

  /// Get all information on the asked torrent
  Future<TorrentItem> getTorrentInfo({
    required String id,
  }) async {
    return TorrentItem.fromJson(await _client.send(
      'get',
      '/torrents/info/{id}',
      pathParameters: {
        'id': id,
      },
    ));
  }

  /// Get list of instantly available file IDs by hoster, {hash} is the SHA1 of the torrent.
  Future<List<CachedTorrent>> getInstantAvailability(List<String> hashes) async {
    return CachedTorrent.fromJsonMap(await _client.send(
      'get',
      '/torrents/instantAvailability/{hash}',
      queryParameters: {
        'hash': hashes.join('/'),
      },
    ));
  }

  /// Get currently active torrents number and the current maximum limit
  Future<ActiveCount> getActiveCount() async {
    return ActiveCount.fromJson(await _client.send(
      'get',
      ' /torrents/activeCount',
    ));
  }

  /// Get available hosts to upload the torrent to.
  Future<List<AvailableHost>> getAvailableHosts() async {
    return AvailableHost.fromJsonList(await _client.send(
      'get',
      '/torrents/availableHosts',
    ));
  }

  /// Add a torrent file to download, return a 201 HTTP code.
  Future<UploadedTorrent> addTorrent({
    required Uint8List torrent,
    required String host,
  }) async {
    return UploadedTorrent.fromJson(await _client.send(
      'put',
      '/torrents/addTorrent',
      pathParameters: {
        'host': host,
      },
      body: torrent,
    ));
  }

  /// Add a magnet link to download, return a 201 HTTP code.
  Future<UploadedTorrent> addMagnet({
    required String magnet,
    required String host,
  }) async {
    return UploadedTorrent.fromJson(await _client.send(
      'post',
      '/torrents/addMagnet',
      pathParameters: {
        'magnet': magnet,
        'host': host,
      },
    ));
  }

  /// Select files of a torrent to start it, returns 204 HTTP code.
  Future<void> selectFiles({
    required String id,
    Iterable<String> files = const ['all'],
  }) {
    return _client.send(
      'post',
      '/torrents/selectFiles/{id}',
      pathParameters: {
        'id': id,
      },
      fieldParameters: {
        'files': files.join(','),
      },
    );
  }

  /// Delete a torrent from torrents list, returns 204 HTTP code
  Future<void> deleteTorrent({
    required String id,
  }) async {
    return _client.send(
      'delete',
      '/torrents/delete/{id}',
      pathParameters: {
        'id': id,
      },
    );
  }
}
