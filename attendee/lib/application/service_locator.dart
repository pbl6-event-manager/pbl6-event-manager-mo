import "package:flutter_secure_storage/flutter_secure_storage.dart";
import "package:get_it/get_it.dart";

/// Service locator setup for dependency injection
class ServiceLocator {
  static final GetIt _getIt = GetIt.instance;

  /// Initialize all dependencies
  static void setupDependencies() async {
    // Register FlutterSecureStorage
    _getIt.registerLazySingleton<FlutterSecureStorage>(
      () => const FlutterSecureStorage(
        aOptions: AndroidOptions(encryptedSharedPreferences: true),
        iOptions: IOSOptions(
          accessibility: KeychainAccessibility.first_unlock_this_device,
        ),
      ),
    );
  }
}
