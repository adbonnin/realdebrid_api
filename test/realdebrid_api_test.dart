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

  group('CachedFile', () {
    test('should parse json map', () async {
      // given:
      final json = jsonDecode("""
        {
          "hash1": {
            "host1": [
              {
                "1": {
                  "filename": "file1",
                  "filesize": 123
                },
                "2": {
                  "filename": "file2",
                  "filesize": 234
                }
              },
              {
                "3": {
                  "filename": "file3",
                  "filesize": 345
                }
              }
            ]
          },
          "hash2": {
            "host2": [
              {
                "4": {
                  "filename": "file4",
                  "filesize": 456
                },
                "5": {
                  "filename": "file5",
                  "filesize": 567
                }
              },
              {
                "6": {
                  "filename": "file6",
                  "filesize": 678
                }
              }
            ]
          }
        }
      """);

      // when:
      final cachedTorrents = CachedTorrent.fromJsonMap(json);

      // then:
      expect(
        cachedTorrents,
        [
          CachedTorrent(
            hash: 'hash1',
            cachedAlternatives: [
              CachedAlternative(
                host: 'host1',
                cachedFiles: [
                  CachedFile(
                    id: 1,
                    fileName: "file1",
                    fileSize: 123,
                  ),
                  CachedFile(
                    id: 2,
                    fileName: "file2",
                    fileSize: 234,
                  )
                ],
              ),
              CachedAlternative(
                host: 'host1',
                cachedFiles: [
                  CachedFile(
                    id: 3,
                    fileName: "file3",
                    fileSize: 345,
                  ),
                ],
              ),
            ],
          ),
          CachedTorrent(
            hash: 'hash2',
            cachedAlternatives: [
              CachedAlternative(
                host: 'host2',
                cachedFiles: [
                  CachedFile(
                    id: 4,
                    fileName: "file4",
                    fileSize: 456,
                  ),
                  CachedFile(
                    id: 5,
                    fileName: "file5",
                    fileSize: 567,
                  )
                ],
              ),
              CachedAlternative(
                host: "host2",
                cachedFiles: [
                  CachedFile(
                    id: 6,
                    fileName: "file6",
                    fileSize: 678,
                  ),
                ],
              )
            ],
          ),
        ],
      );
    });
  });
}
