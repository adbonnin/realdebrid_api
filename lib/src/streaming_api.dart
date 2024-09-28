part of '../realdebrid_api.dart';

class StreamingApi {
  const StreamingApi(this.client);

  final ApiClient client;

  Future<List<StreamingTranscodeDetails>> getStreamingTranscode({
    required String id,
  }) async {
    return (await client.send(
      'get',
      '/streaming/transcode/{id}',
    ));
  }

  Future<StreamingMediaInfos> getStreamingMediaInfo({
    required String id,
  }) async {
    return (await client.send(
      'get',
      '/streaming/mediaInfos/{id}',
    ));
  }
}