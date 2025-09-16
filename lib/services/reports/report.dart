import 'package:smart_ahwa_manager/models/order.dart';

abstract class Report {
  String title();
  String generate(List<Order> orders);
}

// Top-selling report
class TopSellingReport implements Report {
  @override
  String title() => 'Top Selling Drinks';

  @override
  String generate(List<Order> orders) {
    final Map<String, int> counts = {};
    for (var o in orders) {
      final name = o.drink.name;
      counts[name] = (counts[name] ?? 0) + 1;
    }
    if (counts.isEmpty) return 'No orders yet.';
    final sorted = counts.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    final buffer = StringBuffer();
    for (var e in sorted) {
      buffer.writeln('${e.key}: ${e.value}');
    }
    return buffer.toString();
  }
}

// Total orders report
class TotalOrdersReport implements Report {
  @override
  String title() => 'Total Orders';

  @override
  String generate(List<Order> orders) {
    return 'Total orders: ${orders.length}';
  }
}
