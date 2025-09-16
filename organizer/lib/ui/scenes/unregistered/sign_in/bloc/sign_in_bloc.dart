import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organizer/utils/enums/view_status_enum.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc() : super(SignInState.initial()) {
    on<SignInSubmitted>(_onFormSubmitted);
  }

  Future<void> _onFormSubmitted(
    SignInSubmitted event,
    Emitter<SignInState> emit,
  ) async {
    emit(state.copyWith(status: ViewStatusEnum.loading));
    // TODO: Implement API call here

    await Future.delayed(Duration(seconds: 2));

    emit(state.copyWith(status: ViewStatusEnum.success));
  }
}
