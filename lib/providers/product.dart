import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavourite;
  void _setFavValue(bool newValue) {
    isFavourite = newValue;
    notifyListeners();
  }

  Product(
      {@required this.id,
      @required this.title,
      @required this.description,
      @required this.price,
      @required this.imageUrl,
      this.isFavourite = false});

  void toggleFavourite() async {
    final oldState = isFavourite;
    _setFavValue(!oldState);
    final url = Uri.parse(
        'https://flutter-run-ace74-default-rtdb.firebaseio.com/products/$id.json');

    try {
      final response = await http.patch(url,
          body: json.encode({
            'isFavorite': isFavourite,
          }));
      if (response.statusCode >= 400) {
        _setFavValue(oldState);
      }
    } catch (err) {
      _setFavValue(oldState);
    }
    notifyListeners();
  }
}
