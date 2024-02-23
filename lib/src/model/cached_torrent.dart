part of '../../realdebrid_api.dart';

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
