part of '../realdebrid_api.dart';

class UserApi {
  const UserApi(this.client);

  final ApiClient client;

  Future<User> getUser() async {
    return User.fromJson(await client.send(
      'get',
      '/user',
    ));
  }
}
