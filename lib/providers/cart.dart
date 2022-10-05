import 'package:flutter/material.dart';

class CartItem {
  final String id;
  final String title;
  int quantity;
  final double price;
  CartItem(
      {@required this.id,
      @required this.title,
      @required this.quantity,
      @required this.price});
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get ItemCount {
    if (_items != null) {
      return _items.length;
    }
    return 0;
  }

  double get totalAmount {
    double total = 0.0;
    if (_items == null) return 0.0;
    _items.forEach((key, value) {
      total += value.price * value.quantity;
    });
    return total;
  }

  void addItem(String pid, double price, String title) {
    if (_items.containsKey(pid))
      _items.update(
          pid,
          (value) => CartItem(
              id: value.id,
              title: value.title,
              quantity: value.quantity + 1,
              price: value.price));
    else {
      _items.putIfAbsent(
          pid,
          () => CartItem(
              id: DateTime.now().toString(),
              title: title,
              quantity: 1,
              price: price));
    }
    notifyListeners();
  }

  void removeSingleItem(String pid) {
    if (!_items.containsKey(pid)) return;
    if (_items[pid].quantity > 1)
      _items.update(
          pid,
          (value) => CartItem(
              id: value.id,
              title: value.title,
              quantity: value.quantity - 1,
              price: value.price));
    else {
      _items.remove(pid);
    }
    notifyListeners();
  }

  void removeItem(String pid) {
    _items.remove(pid);
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}
