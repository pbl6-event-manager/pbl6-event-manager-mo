import "package:retrofit/dio.dart";

/// Annotation to not use auth in certain API requests
class NoAuth extends TypedExtras {
  const NoAuth({this.noAuth = true});

  final bool noAuth;
}
