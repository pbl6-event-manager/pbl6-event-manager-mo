extension ExceptionExtension on Exception {
  /// Quickly get a message of an exception by ommitting "Exception: " phase

  String get message => toString().replaceAll('Exception: ', '');
}
