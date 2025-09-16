import 'dart:io';

import 'package:smart_ahwa_manager/models/drink.dart';
import 'package:smart_ahwa_manager/services/order_manager.dart';
import 'package:smart_ahwa_manager/services/order_repo.dart';
import 'package:smart_ahwa_manager/services/reports/report.dart';

void main() {
  // Setup repository and manager
  final repo = InMemoryOrderRepository();
  final manager = OrderManager(repo);

  print('=== Welcome to Smart Ahwa Manager ☕ ===');

  while (true) {
    print('\nChoose an option:');
    print('1) Add new order');
    print('2) Complete an order');
    print('3) Edit an order');
    print('4) View pending orders');
    print('5) View all orders');
    print('6) Generate reports');
    print('0) Exit');

    stdout.write('Enter choice: ');
    final choice = stdin.readLineSync();

    switch (choice) {
      case '1':
        _addOrder(manager);
        break;
      case '2':
        _completeOrder(manager);
        break;
      case '3':
        _editOrder(manager);
        break;
      case '4':
        _viewPending(manager);
        break;
      case '5':
        _viewAll(manager);
        break;
      case '6':
        _generateReports(manager);
        break;
      case '0':
        print('Exiting... Bye ya rais 👋');
        return;
      default:
        print('Invalid choice, try again.');
    }
  }
}

void _addOrder(OrderManager manager) {
  stdout.write('Enter customer name: ');
  final name = stdin.readLineSync() ?? '';

  print('Choose drink: 1) Shai  2) Turkish Coffee  3) Hibiscus Tea');
  final drinkChoice = stdin.readLineSync();
  Drink drink;
  switch (drinkChoice) {
    case '1':
      drink = Shai();
      break;
    case '2':
      drink = TurkishCoffee();
      break;
    case '3':
      drink = HibiscusTea();
      break;
    default:
      print('Invalid drink, defaulting to Shai');
      drink = Shai();
  }

  stdout.write('Any special instructions? ');
  final notes = stdin.readLineSync() ?? '';

  manager.placeOrder(name, drink, notes);
  print('✅ Order added for $name (${drink.name})');
}

void _completeOrder(OrderManager manager) {
  _viewPending(manager);
  stdout.write('Enter order index to complete: ');
  final idx = int.tryParse(stdin.readLineSync() ?? '') ?? -1;
  if (idx >= 0 && idx < manager.allOrders.length) {
    manager.completeOrder(idx);
    print('✅ Order $idx marked as completed.');
  } else {
    print('⚠️ Invalid index.');
  }
}

void _editOrder(OrderManager manager) {
  _viewAll(manager);
  stdout.write('Enter order index to edit: ');
  final idx = int.tryParse(stdin.readLineSync() ?? '') ?? -1;

  if (idx < 0 || idx >= manager.allOrders.length) {
    print('⚠️ Invalid index.');
    return;
  }

  final order = manager.allOrders[idx];

  stdout.write(
    'New customer name (leave empty to keep "${order.customerName}"): ',
  );
  final newName = stdin.readLineSync();
  final name = (newName != null && newName.isNotEmpty)
      ? newName
      : order.customerName;

  print(
    'Choose new drink (or Enter to keep "${order.drink.name}"): 1) Shai  2) Turkish Coffee  3) Hibiscus Tea',
  );
  final drinkChoice = stdin.readLineSync();
  Drink drink = order.drink;
  if (drinkChoice == '1')
    drink = Shai();
  else if (drinkChoice == '2')
    drink = TurkishCoffee();
  else if (drinkChoice == '3')
    drink = HibiscusTea();

  stdout.write(
    'New instructions (leave empty to keep "${order.instructions}"): ',
  );
  final newNotes = stdin.readLineSync();
  final notes = (newNotes != null && newNotes.isNotEmpty)
      ? newNotes
      : order.instructions;

  manager.updateOrder(idx, name, drink, notes);
  print('✏️ Order $idx updated successfully.');
}

void _viewPending(OrderManager manager) {
  print('--- Pending Orders ---');
  final pending = manager.pendingOrders;
  if (pending.isEmpty) {
    print('No pending orders.');
  } else {
    for (var i = 0; i < pending.length; i++) {
      final o = pending[i];
      print('$i) ${o.customerName} | ${o.drink.name} | ${o.instructions}');
    }
  }
}

void _viewAll(OrderManager manager) {
  print('--- All Orders ---');
  final orders = manager.allOrders;
  if (orders.isEmpty) {
    print('No orders yet.');
  } else {
    for (var i = 0; i < orders.length; i++) {
      final o = orders[i];
      print(
        '$i) ${o.customerName} | ${o.drink.name} | ${o.instructions} | Completed: ${o.isCompleted}',
      );
    }
  }
}

void _generateReports(OrderManager manager) {
  final reports = [TotalOrdersReport(), TopSellingReport()];
  print('\n--- Reports ---');
  for (var r in reports) {
    print('>> ${r.title()}');
    print(r.generate(manager.allOrders));
  }
}
