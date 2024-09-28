part of '../../realdebrid_api.dart';

class StreamingTranscodeDetails {
  const StreamingTranscodeDetails({
    required this.format,
    required this.qualities,
  });

  final String format;
  final Map<String, String> qualities;
}
