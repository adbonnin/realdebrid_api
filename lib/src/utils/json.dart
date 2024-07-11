extension JsonListParseFunctionExtension<T> on List<T> Function(List<dynamic>) {
  List<T> nullToEmpty(List<dynamic>? list) {
    return list == null ? [] : call(list);
  }
}

extension JsonMapParseFunctionExtension<K1, K2, V2> on Map<K2, V2> Function(Map<K1, dynamic>) {
  Map<K2, V2> nullToEmpty(Map<K1, dynamic>? map) {
    return map == null ? {} : call(map);
  }
}
