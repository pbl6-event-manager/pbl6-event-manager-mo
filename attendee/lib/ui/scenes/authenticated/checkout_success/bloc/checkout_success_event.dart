part of 'checkout_success_bloc.dart';

sealed class CheckoutSuccessEvent extends Equatable {
  const CheckoutSuccessEvent();

  @override
  List<Object?> get props => [];
}

final class CheckoutSuccessValidateRequested extends CheckoutSuccessEvent {
  const CheckoutSuccessValidateRequested();
}
