import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organizer/application/bloc/auth_bloc.dart';
import 'package:organizer/domain/auth_repository.dart';
import 'package:organizer/utils/constants/helpers/result.dart';
import 'package:organizer/utils/enums/view_status.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final AuthBloc _authBloc;
  final AuthRepository _repository;
  SignInBloc({required AuthBloc authBloc, required AuthRepository repository})
    : _repository = repository,
      _authBloc = authBloc,
      super(SignInState.initial()) {
    on<SignInSubmitted>(_onFormSubmitted);
  }

  Future<void> _onFormSubmitted(
    SignInSubmitted event,
    Emitter<SignInState> emit,
  ) async {
    emit(state.copyWith(status: ViewStatus.loading, errorMessage: null));

    final Result<String> signInResponse = await _repository.signIn(
      email: event.email,
      password: event.password,
    );

    switch (signInResponse) {
      case Ok<String>():
        emit(state.copyWith(status: ViewStatus.success));
        _authBloc.add(AuthTokenAdded(signInResponse.value));

      case Error<String>():
        emit(
          state.copyWith(
            status: ViewStatus.failure,
            errorMessage: signInResponse.toString(),
          ),
        );
    }
  }
}
