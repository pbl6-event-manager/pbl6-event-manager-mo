import "package:attendee/application/bloc/auth_bloc.dart";
import "package:attendee/domain/models/user.dart";
import "package:attendee/domain/repositories/user_repository.dart";
import "package:attendee/utils/enums/view_status_enum.dart";
import "package:attendee/utils/helpers/result.dart";
import "package:bloc/bloc.dart";
import "package:equatable/equatable.dart";

part "account_event.dart";
part "account_state.dart";

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final UserRepository _userRepository;
  final AuthBloc _authBloc;

  AccountBloc({
    required UserRepository userRepository,
    required AuthBloc authBloc,
  }) : _userRepository = userRepository,
       _authBloc = authBloc,
       super(const AccountState.initial()) {
    on<AccountLoad>(_onAccountLoad);
    on<AccountRefresh>(_onAccountReload);
    on<AccountLogout>(_onAccountLogout);
    on<AccountUpdateUserInfo>(_onAccountUpdateData);
  }

  Future<void> _onAccountLoad(
    AccountLoad event,
    Emitter<AccountState> emit,
  ) async {
    emit(state.copyWith(status: ViewStatusEnum.loading));
    await _fetchUserInfo(emit);
  }

  Future<void> _onAccountReload(
    AccountRefresh event,
    Emitter<AccountState> emit,
  ) async {
    emit(state.copyWith(status: ViewStatusEnum.loading));
    await _fetchUserInfo(emit);
  }

  Future<void> _fetchUserInfo(Emitter<AccountState> emit) async {
    final userResponse = await _userRepository.getUserInfo();

    switch (userResponse) {
      case Ok<User>():
        emit(
          state.copyWith(
            status: ViewStatusEnum.success,
            user: userResponse.value,
          ),
        );
      case Error<User>(error: final error):
        emit(
          state.copyWith(
            status: ViewStatusEnum.failure,
            errorMessage: error.toString(),
          ),
        );
    }
  }

  void _onAccountLogout(AccountLogout event, Emitter<AccountState> emit) {
    _authBloc.add(const AuthTokenRemoved());
  }

  Future<void> _onAccountUpdateData(
    AccountUpdateUserInfo event,
    Emitter<AccountState> emit,
  ) async {
    // If all field null  => returns
    if (event.userUpdateData.firstName == null &&
        event.userUpdateData.lastName == null &&
        event.userUpdateData.phoneNumber == null &&
        event.userUpdateData.profilePhoto == null) {
      return;
    }

    emit(state.copyWith(status: ViewStatusEnum.loading));

    final Result<User> userResponse = await _userRepository.editUserInfo(
      firstName: event.userUpdateData.firstName,
      lastName: event.userUpdateData.lastName,
      phoneNumber: event.userUpdateData.phoneNumber,
      avatarBinary: event.userUpdateData.profilePhoto,
    );

    switch (userResponse) {
      case Ok<User>():
        emit(
          state.copyWith(
            status: ViewStatusEnum.success,
            user: userResponse.value,
          ),
        );
      case Error<User>(error: final error):
        emit(
          state.copyWith(
            status: ViewStatusEnum.failure,
            errorMessage: error.toString(),
          ),
        );
    }
  }
}
