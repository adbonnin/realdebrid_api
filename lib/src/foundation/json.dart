extension JsonListParseFunctionExtension<T, U> on List<T> Function(List<dynamic>) {
  List<T> nullToEmpty(List<dynamic>? list) {
    return list == null ? [] : call(list);
  }
}
