extension ObjectExtension on Object {
  /// Return optional value of [T]
  ///
  /// Equivalent of
  /// ```
  /// final T? castObject = T is object ? T as object : null
  /// ```
  T? tryCast<T>() => this is T ? this as T : null;
}
