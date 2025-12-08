import 'package:attendee/domain/models/order.dart';
import 'package:attendee/domain/repositories/order_repository.dart';
import 'package:attendee/utils/helpers/result.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum OrdersStatus { initial, loading, success, failure }

class OrdersState {
  final OrdersStatus status;
  final List<Order> orders;
  final Object? error;

  const OrdersState({
    this.status = OrdersStatus.initial,
    this.orders = const [],
    this.error,
  });

  OrdersState copyWith({
    OrdersStatus? status,
    List<Order>? orders,
    Object? error,
  }) {
    return OrdersState(
      status: status ?? this.status,
      orders: orders ?? this.orders,
      error: error ?? this.error,
    );
  }
}

class OrdersCubit extends Cubit<OrdersState> {
  OrdersCubit({required OrderRepository orderRepository})
    : _orderRepository = orderRepository,
      super(const OrdersState());

  final OrderRepository _orderRepository;

  Future<void> fetchOrders() async {
    emit(state.copyWith(status: OrdersStatus.loading, error: null));

    final Result<List<Order>> result = await _orderRepository.getMyOrder();
    switch (result) {
      case Ok(value: final orders):
        emit(state.copyWith(status: OrdersStatus.success, orders: orders));
      case Error(error: final error):
        emit(state.copyWith(status: OrdersStatus.failure, error: error));
    }
  }
}
