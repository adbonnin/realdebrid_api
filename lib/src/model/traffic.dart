part of '../../realdebrid_api.dart';

class Traffic {
  const Traffic({
    required this.host,
    required this.left,
    required this.bytes,
    required this.links,
    required this.limit,
    required this.type,
    required this.extra,
    required this.reset,
  });

  final String host;
  final int left;
  final int bytes;
  final int links;
  final int limit;
  final TrafficType type;
  final int extra;
  final TrafficReset reset;

  static List<Traffic> fromJsonObject(Map<String, dynamic> json) {
    return json.entries //
        .map((etr) => Traffic.fromJson(etr.key, etr.value as Map<String, Object?>))
        .toList();
  }

  factory Traffic.fromJson(String host, Map<String, Object?> json) {
    return Traffic(
      host: host,
      left: json[r'left'] as int,
      bytes: json[r'bytes'] as int,
      links: json[r'links'] as int,
      limit: json[r'limit'] as int,
      type: TrafficType.fromJson(json[r'type'] as String),
      extra: json[r'extra'] as int,
      reset: TrafficReset.fromJson(json[r'reset'] as String),
    );
  }
}
