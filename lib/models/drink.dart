abstract class Drink {
  String get name;
}

class Shai extends Drink {
  @override
  String get name => 'Shai';
}

class TurkishCoffee extends Drink {
  @override
  String get name => 'Turkish Coffee';
}

class HibiscusTea extends Drink {
  @override
  String get name => 'Hibiscus Tea';
}
