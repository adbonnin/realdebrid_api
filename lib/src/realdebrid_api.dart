part of '../realdebrid_api.dart';

class RealDebridApi {
  RealDebridApi(this.client);

  final ApiClient client;

  late final time = TimeApi(client);
  late final user = UserApi(client);
  late final torrents = TorrentsApi(client);

  Future<void> disableAccessToken() async {
    return await client.send(
      'get',
      '/disable_access_token',
    );
  }
}
