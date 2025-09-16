import 'package:smart_ahwa_manager/models/order.dart';

abstract class OrderRepository {
  void addOrder(Order order);
  void markOrderCompleted(int index);
  List<Order> getAllOrders();
  List<Order> getPendingOrders();
}

class InMemoryOrderRepository implements OrderRepository {
  final List<Order> _orders = [];

  @override
  void addOrder(Order order) {
    _orders.add(order);
  }

  @override
  void markOrderCompleted(int index) {
    if (index >= 0 && index < _orders.length) {
      _orders[index].markCompleted();
    }
  }

  @override
  List<Order> getAllOrders() => List.unmodifiable(_orders);

  @override
  List<Order> getPendingOrders() =>
      _orders.where((o) => !o.isCompleted).toList(growable: false);
}
