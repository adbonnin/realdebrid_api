part of '../../realdebrid_api.dart';

enum TrafficReset {
  daily,
  weekly,
  monthly,
  $unknown;

  static TrafficReset fromJson(String json) {
    return switch (json) {
      'daily' => daily,
      'weekly' => weekly,
      'monthly' => monthly,
      _ => $unknown,
    };
  }
}
