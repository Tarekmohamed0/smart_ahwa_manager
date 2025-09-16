import 'package:smart_ahwa_manager/models/drink.dart';

class Order {
  String _customerName;
  Drink _drink;
  String _instructions;
  bool _isCompleted = false;

  Order(this._customerName, this._drink, [this._instructions = '']);

  // Encapsulation with getters
  String get customerName => _customerName;
  Drink get drink => _drink;
  String get instructions => _instructions;
  bool get isCompleted => _isCompleted;

  void markCompleted() {
    _isCompleted = true;
  }

  void update(String name, Drink drink, String notes) {
    _customerName = name;
    _drink = drink;
    _instructions = notes;
  }

  @override
  String toString() {
    return 'Order(customer: $_customerName, drink: ${_drink.name}, notes: $_instructions, done: $_isCompleted)';
  }
}
