part of '../../realdebrid_api.dart';

class AvailableHost {
  const AvailableHost({
    required this.host,
    required this.maxFileSize,
  });

  final String host;
  final int maxFileSize;

  static List<AvailableHost> fromJsonList(List<dynamic> json) {
    return json //
        .map((e) => AvailableHost.fromJson(e))
        .toList();
  }

  factory AvailableHost.fromJson(Map<String, Object?> json) {
    return AvailableHost(
      host: json[r'host'] as String,
      maxFileSize: json[r'max_file_size'] as int,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    if (other is! AvailableHost) {
      return false;
    }

    return runtimeType == other.runtimeType && //
        host == other.host &&
        maxFileSize == other.maxFileSize;
  }

  @override
  int get hashCode {
    return host.hashCode ^ //
        maxFileSize.hashCode;
  }
}
