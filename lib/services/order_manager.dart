// Single Responsibility: manager handles business operations on orders only
import 'package:smart_ahwa_manager/models/drink.dart';
import 'package:smart_ahwa_manager/models/order.dart';
import 'package:smart_ahwa_manager/services/order_repo.dart';

class OrderManager {
  final OrderRepository _repo;

  OrderManager(this._repo);

  void placeOrder(String customerName, Drink drink, [String notes = '']) {
    final order = Order(customerName, drink, notes);
    _repo.addOrder(order);
  }

  void completeOrder(int index) {
    _repo.markOrderCompleted(index);
  }

  void updateOrder(int index, String newName, Drink newDrink, String newNotes) {
    if (index >= 0 && index < _repo.getAllOrders().length) {
      final order = _repo.getAllOrders()[index];
      order.update(newName, newDrink, newNotes);
    }
  }

  List<Order> get pendingOrders => _repo.getPendingOrders();
  List<Order> get allOrders => _repo.getAllOrders();
}
