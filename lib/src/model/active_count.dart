part of '../../realdebrid_api.dart';

class ActiveCount {
  const ActiveCount({
    required this.nb,
    required this.limit,
  });

  final int nb;
  final int limit;

  static ActiveCount fromJson(Map<String, dynamic> json) {
    return ActiveCount(
      nb: json[r'nb'] as int,
      limit: json[r'limit'] as int,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    if (other is! ActiveCount) {
      return false;
    }

    return runtimeType == other.runtimeType && //
        nb == other.nb &&
        limit == other.limit;
  }

  @override
  int get hashCode {
    return nb.hashCode ^ //
        limit.hashCode;
  }
}
