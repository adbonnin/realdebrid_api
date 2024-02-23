part of '../realdebrid_api.dart';

class TimeApi {
  const TimeApi(this.client);

  final ApiClient client;

  Future<String> getTime() async {
    return (await client.send(
      'get',
      '/time',
    ));
  }

  Future<String> getIsoTime() async {
    return (await client.send(
      'get',
      '/time/iso',
    ));
  }
}
