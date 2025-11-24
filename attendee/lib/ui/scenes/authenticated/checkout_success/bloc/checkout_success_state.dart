part of 'checkout_success_bloc.dart';

class CheckoutSuccessState extends Equatable {
  const CheckoutSuccessState({required this.status});
  const CheckoutSuccessState.initial() : this(status: ViewStatusEnum.initial);

  final ViewStatusEnum status;

  CheckoutSuccessState copyWith({ViewStatusEnum? status}) {
    return CheckoutSuccessState(status: status ?? this.status);
  }

  @override
  List<Object?> get props => [status];
}
