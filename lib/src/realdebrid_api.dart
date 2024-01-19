import 'dart:typed_data';

import 'package:realdebrid_api/src/api_client.dart';
import 'package:realdebrid_api/src/foundation/collections.dart';

class RealDebridApi {
  RealDebridApi(this.client);

  final ApiClient client;

  late final user = UserApi(client);
  late final torrents = TorrentsApi(client);
}

class UserApi {
  UserApi(this.client);

  final ApiClient client;

  Future<User> getUser() async {
    return User.fromJson(await client.send(
      'get',
      '/user',
    ));
  }
}

class TorrentsApi {
  TorrentsApi(this._client);

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

    return TorrentItem.fromJsonList(await _client.send(
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

class ActiveCount {
  const ActiveCount({
    required this.nb,
    required this.limit,
  });

  final int nb;
  final int limit;

  static ActiveCount fromJson(Map<String, dynamic> json) {
    return ActiveCount(
      nb: json[r'nb'] as int,
      limit: json[r'limit'] as int,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    if (other is! ActiveCount) {
      return false;
    }

    return runtimeType == other.runtimeType && //
        nb == other.nb &&
        limit == other.limit;
  }

  @override
  int get hashCode {
    return nb.hashCode ^ //
        limit.hashCode;
  }
}

class AvailableHost {
  const AvailableHost({
    required this.host,
    required this.maxFileSize,
  });

  final String host;
  final int maxFileSize;

  static List<AvailableHost> fromJsonList(List<dynamic> json) {
    return json //
        .map((e) => AvailableHost.fromJson(e))
        .toList();
  }

  factory AvailableHost.fromJson(Map<String, Object?> json) {
    return AvailableHost(
      host: json[r'host'] as String,
      maxFileSize: json[r'max_file_size'] as int,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    if (other is! AvailableHost) {
      return false;
    }

    return runtimeType == other.runtimeType && //
        host == other.host &&
        maxFileSize == other.maxFileSize;
  }

  @override
  int get hashCode {
    return host.hashCode ^ //
        maxFileSize.hashCode;
  }
}

class CachedAlternative {
  const CachedAlternative({
    required this.host,
    required this.cachedFiles,
  });

  final String host;
  final List<CachedFile> cachedFiles;

  static List<CachedAlternative> fromJsonList(String host, List<dynamic> json) {
    return json //
        .map((e) => CachedAlternative.fromJson(host, e as Map<String, dynamic>))
        .toList();
  }

  factory CachedAlternative.fromJson(String host, Map<String, dynamic> json) {
    final cachedFiles = json.entries //
        .map((e) => CachedFile.fromJson(int.parse(e.key), e.value))
        .toList();

    return CachedAlternative(
      host: host,
      cachedFiles: cachedFiles,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    if (other is! CachedAlternative) {
      return false;
    }

    return runtimeType == other.runtimeType && //
        host == other.host &&
        listEquals(cachedFiles, other.cachedFiles);
  }

  @override
  int get hashCode {
    return host.hashCode ^ //
        cachedFiles.hashCode;
  }
}

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

class CachedTorrent {
  const CachedTorrent({
    required this.hash,
    required this.cachedAlternatives,
  });

  final String hash;
  final List<CachedAlternative> cachedAlternatives;

  static List<CachedTorrent> fromJsonMap(Map<String, dynamic> json) {
    return json.entries //
        .map((e) => CachedTorrent.fromJson(e.key, e.value))
        .toList();
  }

  factory CachedTorrent.fromJson(String hash, Map<String, dynamic> json) {
    final cachedAlternatives = json.entries //
        .map((e) => CachedAlternative.fromJsonList(e.key, e.value as List<dynamic>))
        .expand((e) => e)
        .toList();

    return CachedTorrent(
      hash: hash,
      cachedAlternatives: cachedAlternatives,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    if (other is! CachedTorrent) {
      return false;
    }

    return runtimeType == other.runtimeType && //
        hash == other.hash &&
        listEquals(cachedAlternatives, other.cachedAlternatives);
  }

  @override
  int get hashCode {
    return hash.hashCode ^ //
        cachedAlternatives.hashCode;
  }
}

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

class User {
  const User({
    required this.id,
    required this.username,
    required this.email,
    required this.points,
    required this.locale,
    required this.avatar,
    required this.type,
    required this.premium,
    required this.expiration,
  });

  final int id;
  final String username;
  final String email;
  final int points;
  final String locale;
  final String avatar;
  final String type;
  final int premium;
  final String expiration;

  factory User.fromJson(Map<String, Object?> json) {
    return User(
      id: json[r'id'] as int,
      username: json[r'username'] as String,
      email: json[r'email'] as String,
      points: json[r'points'] as int,
      locale: json[r'locale'] as String,
      avatar: json[r'avatar'] as String,
      type: json[r'type'] as String,
      premium: json[r'premium'] as int,
      expiration: json[r'expiration'] as String,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    if (other is! User) {
      return false;
    }

    return runtimeType == other.runtimeType &&
        id == other.id &&
        username == other.username &&
        email == other.email &&
        points == other.points &&
        locale == other.locale &&
        avatar == other.avatar &&
        type == other.type &&
        premium == other.premium &&
        expiration == other.expiration;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        username.hashCode ^
        email.hashCode ^
        points.hashCode ^
        locale.hashCode ^
        avatar.hashCode ^
        type.hashCode ^
        premium.hashCode ^
        expiration.hashCode;
  }

  @override
  String toString() {
    return 'User{'
        'id: $id, '
        'username: $username, '
        'email: $email, '
        'points: $points, '
        'locale: $locale, '
        'avatar: $avatar, '
        'type: $type, '
        'premium: $premium, '
        'expiration: $expiration'
        '}';
  }
}
