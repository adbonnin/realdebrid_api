part of '../../realdebrid_api.dart';

enum TrafficType {
  links,
  gigabytes,
  bytes,
  $unknown;

  static TrafficType fromJson(String json) {
    return switch (json) {
      'links' => links,
      'gigabytes' => gigabytes,
      'bytes' => bytes,
      _ => $unknown,
    };
  }
}
