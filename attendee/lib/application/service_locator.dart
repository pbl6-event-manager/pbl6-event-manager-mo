import 'package:attendee/application/app_router.dart';
import 'package:attendee/application/bloc/auth_bloc.dart';
import 'package:attendee/domain/repositories/auth_repository.dart';
import 'package:attendee/domain/repositories/category_repository.dart';
import 'package:attendee/domain/repositories/event_repository.dart';
import 'package:attendee/domain/repositories/order_repository.dart';
import 'package:attendee/domain/repositories/organizer_repository.dart';
import 'package:attendee/domain/repositories/ticket_repository.dart';
import 'package:attendee/domain/repositories/user_repository.dart';
import 'package:attendee/domain/usecases/copy_string_to_clipboard_usecase.dart';
import 'package:attendee/domain/usecases/search_by_current_location_usecase.dart';
import 'package:attendee/domain/usecases/validate_voucher_usecase.dart';
import 'package:attendee/network/config/dio_config.dart';
import 'package:attendee/network/datasources/auth_datasource.dart';
import 'package:attendee/network/datasources/category_datasource.dart';
import 'package:attendee/network/datasources/event_datasource.dart';
import 'package:attendee/network/datasources/order_datasource.dart';
import 'package:attendee/network/datasources/organizer_datasource.dart';
import 'package:attendee/network/datasources/ticket_datasource.dart';
import 'package:attendee/network/datasources/user_datasource.dart';
import 'package:attendee/network/repositories/auth_repository_implementation.dart';
import 'package:attendee/domain/repositories/location_repository.dart';
import 'package:attendee/network/datasources/location_datasource.dart';
import 'package:attendee/network/repositories/location_repository_implementation.dart';
import 'package:attendee/network/constants/api_endpoint_constants.dart';
import 'package:attendee/network/repositories/category_repository_implementation.dart';
import 'package:attendee/network/repositories/event_repository_implementation.dart';
import 'package:attendee/network/repositories/order_repository_implementation.dart';
import 'package:attendee/network/repositories/organizer_repository_implementation.dart';
import 'package:attendee/network/repositories/ticket_repository_implementation.dart';
import 'package:attendee/network/repositories/user_repository_implementation.dart';
import 'package:attendee/utils/constants/storage_keys_constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

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

    _getIt.registerSingleton<AuthBloc>(
      AuthBloc(),
      dispose: (bloc) => bloc.close(),
    );

    _getIt.registerLazySingleton<Dio>(
      () => DioConfig.getConfiguredDio(
        onUnauthenticated: () =>
            _getIt<AuthBloc>().add(const AuthTokenRemoved()),
        secureStorage: _getIt<FlutterSecureStorage>(),
        securedStorageAccessTokenKey: StorageKeysConstants.accessTokenKey,
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

    _getIt.registerLazySingleton<UserDatasource>(
      () => UserDatasource(_getIt<Dio>()),
    );

    _getIt.registerLazySingleton<OrganizerDatasource>(
      () => OrganizerDatasource(_getIt<Dio>()),
    );

    _getIt.registerLazySingleton<TicketDatasource>(
      () => TicketDatasource(_getIt<Dio>()),
    );

    _getIt.registerLazySingleton<OrderDatasource>(
      () => OrderDatasource(_getIt<Dio>()),
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
    _getIt.registerLazySingleton<CategoryRepository>(
      () => CategoryRepositoryImplementation(
        categoryDatasource: _getIt<CategoryDatasource>(),
      ),
    );

    _getIt.registerLazySingleton<UserRepository>(
      () => UserRepositoryImplementation(
        userDatasource: _getIt<UserDatasource>(),
      ),
    );

    _getIt.registerLazySingleton<OrganizerRepository>(
      () => OrganizerRepositoryImplementation(
        datasource: _getIt<OrganizerDatasource>(),
      ),
    );

    _getIt.registerLazySingleton<TicketRepository>(
      () => TicketRepositoryImplementation(
        datasource: _getIt<TicketDatasource>(),
      ),
    );

    _getIt.registerLazySingleton<OrderRepository>(
      () =>
          OrderRepositoryImplementation(datasource: _getIt<OrderDatasource>()),
    );

    // Usecases
    _getIt.registerLazySingleton<SearchByCurrentLocationUsecase>(
      () => SearchByCurrentLocationUsecaseImplementation(
        eventRemoteRepository: _getIt<EventRepository>(),
      ),
    );
    _getIt.registerLazySingleton<CopyStringToClipboardUsecase>(
      () => CopyStringToClipboardUsecaseImplementation(),
    );

    _getIt.registerLazySingleton<ValidateVoucherUsecase>(
      () => ValidateVoucherUsecaseImplementation(
        ticketRepository: _getIt<TicketRepository>(),
        userRepository: _getIt<UserRepository>(),
      ),
    );
  }
}
