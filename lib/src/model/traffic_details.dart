part of '../../realdebrid_api.dart';

class TrafficDetails {
  const TrafficDetails({
    required this.date,
    required this.bytesByHost,
    required this.totalBytes,
  });

  final DateTime date;
  final Map<String, int> bytesByHost;
  final int totalBytes;

  static List<TrafficDetails> fromJsonObject(Map<String, dynamic> json) {
    return [];
  }

  factory TrafficDetails.fromJson(DateTime date, Map<String, Object?> json) {
    return TrafficDetails(
      date: date,
      bytesByHost: {},
      totalBytes: 2,
    );
  }
}
