import "package:attendee/application/app_router.dart";
import "package:attendee/application/bloc/auth_bloc.dart";
import "package:attendee/domain/repositories/auth_repository.dart";
import "package:attendee/domain/repositories/category_repository.dart";
import "package:attendee/domain/repositories/event_repository.dart";
import "package:attendee/domain/usecases/search_by_current_location_usecase.dart";
import "package:attendee/network/config/dio_config.dart";
import "package:attendee/network/datasources/auth_datasource.dart";
import "package:attendee/network/datasources/category_datasource.dart";
import "package:attendee/network/datasources/event_datasource.dart";
import "package:attendee/network/repositories/auth_repository_implementation.dart";
import "package:attendee/domain/repositories/location_repository.dart";
import "package:attendee/network/datasources/location_datasource.dart";
import "package:attendee/network/repositories/location_repository_implementation.dart";
import "package:attendee/network/constants/api_endpoint_constants.dart";
import "package:attendee/network/repositories/category_repository_implementation.dart";
import "package:attendee/network/repositories/event_repository_implementation.dart";
import "package:attendee/utils/constants/storage_keys_constants.dart";
import "package:dio/dio.dart";
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
    _getIt.registerLazySingleton<AuthBloc>(
      () => AuthBloc(),
      dispose: (bloc) => bloc.close(),
    );

    _getIt.registerLazySingleton<Dio>(
      () => DioConfig.getConfiguredDio(
        onUnauthenticated: () =>
            _getIt<AuthBloc>().add(const AuthTokenRemoved()),
        secureStorage: _getIt<FlutterSecureStorage>(),
        securedStorageAccessTokenKey: StorageKeysConstants.tokenKey,
      ),
    );

    _getIt.registerLazySingleton<AppRouter>(
      () => AppRouter(_getIt<AuthBloc>()),
    );

    // Datasources
    _getIt.registerLazySingleton<AuthDatasource>(
      () => AuthDatasource(_getIt<Dio>()),
    );

    _getIt.registerLazySingleton<EventDatasource>(
      () => EventDatasource(_getIt<Dio>()),
    );

    _getIt.registerLazySingleton<LocationDatasource>(
      () => LocationDatasource(
        _getIt<Dio>(),
        baseUrl: ApiEndpointConstants.locationBaseUrl,
      ),
    );

    _getIt.registerLazySingleton<CategoryDatasource>(
      () => CategoryDatasource(_getIt<Dio>()),
    );

    // Repositories
    _getIt.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImplementation(
        authDatasource: _getIt<AuthDatasource>(),
      ),
    );
    _getIt.registerLazySingleton<EventRepository>(
      () => EventRepositoryImplementation(
        eventDatasource: _getIt<EventDatasource>(),
      ),
    );

    _getIt.registerLazySingleton<LocationRepository>(
      () => LocationRepositoryImplementation(
        locationDatasource: _getIt<LocationDatasource>(),
      ),
    );
    // Usecases

    _getIt.registerLazySingleton<SearchByCurrentLocationUsecase>(
      () => SearchByCurrentLocationUsecaseImplementation(
        eventRemoteRepository: _getIt<EventRepository>(),
      ),
    );
    _getIt.registerLazySingleton<CategoryRepository>(
      () => CategoryRepositoryImplementation(
        categoryDatasource: _getIt<CategoryDatasource>(),
      ),
    );
  }
}
