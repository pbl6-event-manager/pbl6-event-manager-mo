import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:organizer/application/bloc/auth_bloc.dart';
import 'package:organizer/domain/repositories/auth_repository.dart';
import 'package:organizer/domain/repositories/event_repository.dart';
import 'package:organizer/domain/repositories/order_repository.dart';
import 'package:organizer/network/config/dio_config.dart';
import 'package:organizer/network/datasources/auth_datasource.dart';
import 'package:organizer/network/datasources/event_datasource.dart';
import 'package:organizer/network/datasources/order_datasource.dart';
import 'package:organizer/network/repositories/auth_repository_network_impl.dart';
import 'package:organizer/network/repositories/event_repository_implementation.dart';
import 'package:organizer/network/repositories/order_repository_implementation.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Service locator setup for dependency injection
class ServiceLocator {
  static final GetIt _getIt = GetIt.instance;

  /// Initialize all dependencies
  static Future<void> setupDependencies() async {
    // Register FlutterSecureStorage
    _getIt.registerLazySingleton<FlutterSecureStorage>(
      () => const FlutterSecureStorage(
        aOptions: AndroidOptions(encryptedSharedPreferences: true),
        iOptions: IOSOptions(
          accessibility: KeychainAccessibility.first_unlock_this_device,
        ),
      ),
    );

    _getIt.registerSingletonAsync<SharedPreferences>(
      () => SharedPreferences.getInstance(),
    );

    _getIt.registerLazySingleton<Dio>(
      () => DioConfig.getConfiguredDio(
        onUnauthenticated: () =>
            _getIt<AuthBloc>().add(const AuthTokenRemoved()),
        secureStorage: _getIt<FlutterSecureStorage>(),
      ),
    );

    // Register data sources
    _getIt.registerLazySingleton<AuthDatasource>(
      () => AuthDatasource(_getIt<Dio>()),
    );
    _getIt.registerLazySingleton<EventDatasource>(
      () => EventDatasource(_getIt<Dio>()),
    );
    _getIt.registerLazySingleton<OrderDatasource>(
      () => OrderDatasource(_getIt<Dio>()),
    );

    _getIt.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryNetworkImpl(datasource: _getIt<AuthDatasource>()),
    );
    _getIt.registerLazySingleton<EventRepository>(
      () => EventRepositoryImplementation(
        eventDatasource: _getIt<EventDatasource>(),
      ),
    );
    _getIt.registerLazySingleton<OrderRepository>(
      () => OrderRepositoryImplementation(
        orderDatasource: _getIt<OrderDatasource>(),
      ),
    );

    await _getIt.allReady();
  }
}
