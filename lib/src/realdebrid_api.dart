import 'package:realdebrid_api/src/api_client.dart';

class RealDebridApi {
  RealDebridApi(this.client);

  final ApiClient client;

  late final user = UserApi(client);
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
}
