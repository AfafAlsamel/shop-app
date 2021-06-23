import 'package:flutter/material.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorit;

  Product({
    @required this.id,
    @required @required this.title,
    @required this.description,
    @required this.imageUrl,
    @required this.price,
    this.isFavorit = false,
  });

  void isFavoriteToggle() {
    isFavorit = !isFavorit;

    notifyListeners();
  }
}
