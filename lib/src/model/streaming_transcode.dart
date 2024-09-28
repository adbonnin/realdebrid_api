part of '../../realdebrid_api.dart';

class StreamingMediaInfos {
  const StreamingMediaInfos({
    required this.filename,
    required this.hoster,
    required this.link,
    required this.type,
    required this.season,
    required this.episode,
    required this.year,
    required this.duration,
    required this.bitrate,
    required this.size,
    required this.details,
    required this.posterPath,
    required this.audioImage,
    required this.backdropPath,
  });

  final String filename;
  final String hoster;
  final String link;
  final String type;
  final String season;
  final String episode;
  final String year;
  final double duration;
  final int bitrate;
  final int size;

  final List<StreamingTranscodeDetails> details;
  final String posterPath;
  final String audioImage;
  final String backdropPath;

  static StreamingMediaInfos fromJson(Map<String, dynamic> json) {
    return StreamingMediaInfos(
      filename: json[r'filename'] as String,
      hoster: json[r'hoster'] as String,
      link: json[r'link'] as String,
      type: json[r'type'] as String,
      season: json[r'season'] as String,
      episode: json[r'episode'] as String,
      year: json[r'year'] as String,
      duration: json[r'duration'] as double,
      bitrate: json[r'bitrate'] as int,
      size: json[r'size'] as int,
      details: [],
      // details: StreamingTranscodeDetails.fromJson(json[r'details'] as Map<String, dynamic>),
      posterPath: json[r'poster_path'] as String,
      audioImage: json[r'audio_image'] as String,
      backdropPath: json[r'backdrop_path'] as String,
    );
  }
}
