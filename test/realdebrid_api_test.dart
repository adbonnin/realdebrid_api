import 'dart:convert';

import 'package:realdebrid_api/realdebrid_api.dart';
import 'package:test/test.dart';

void main() {
  group('User', () {
    test('should parse json', () async {
      final json = jsonDecode("""
      {
        "id": 415000,
        "username": "JohnDoe",
        "email": "john.doe@gmail.com",
        "points": 1200,
        "locale": "en",
        "avatar": "https://fcdn.real-debrid.com/images/forum/empty.png",
        "type": "premium",
        "premium": 15000000,
        "expiration": "2024-08-07T10:10:00.000Z"
      }
      """);

      // when:
      final user = User.fromJson(json);

      // then:
      final expectedUser = User(
        id: 415000,
        username: "JohnDoe",
        email: "john.doe@gmail.com",
        points: 1200,
        locale: "en",
        avatar: "https://fcdn.real-debrid.com/images/forum/empty.png",
        type: "premium",
        premium: 15000000,
        expiration: "2024-08-07T10:10:00.000Z",
      );

      expect(user, equals(expectedUser));
    });
  });
}
