import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organizer/application/bloc/auth_bloc.dart';
import 'package:organizer/utils/enums/view_status.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final AuthBloc authBloc;
  SignInBloc({required this.authBloc}) : super(SignInState.initial()) {
    on<SignInSubmitted>(_onFormSubmitted);
  }

  Future<void> _onFormSubmitted(
    SignInSubmitted event,
    Emitter<SignInState> emit,
  ) async {
    emit(state.copyWith(status: ViewStatus.loading));
    // TODO: Implement API call here

    await Future.delayed(Duration(seconds: 2));

    emit(state.copyWith(status: ViewStatus.success));

    authBloc.add(AuthTokenAdded("Dummy token"));
  }
}
