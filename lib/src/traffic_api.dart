part of '../realdebrid_api.dart';

class TrafficApi {
  const TrafficApi(this._client);

  final ApiClient _client;

  /// Get traffic informations for limited hosters (limits, current usage, extra packages)
  Future<List<Traffic>> getTraffic() async {
    return Traffic.fromJsonObject(await _client.send(
      'get',
      '/traffic',
    ));
  }

  /// Get traffic details on each hoster used during a defined period
  Future<List<TrafficDetails>> getTrafficDetails({
    DateTime? start,
    DateTime? end,
  }) async {
    return TrafficDetails.fromJsonObject(await _client.send(
      'get',
      '/traffic/details',
      queryParameters: {
        if (start != null) 'start': start.formatYmd(),
        if (end != null) 'end': end.formatYmd(),
      },
    ));
  }
}
