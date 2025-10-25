import "package:flutter/services.dart";

abstract class AppVersionUtils {
  static Future<String> get appVersion async {
    final bundle = rootBundle;
    final pubspec = await bundle.loadString("pubspec.yaml");
    return pubspec.split("version: ")[1].split("+")[0];
  }
}
