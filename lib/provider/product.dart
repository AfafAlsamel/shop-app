import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorit;

  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.imageUrl,
    @required this.price,
    this.isFavorit = false,
  });

  Future<void>  isFavoriteToggle(String authToken, String userId)  async{
    final beforeChange = isFavorit;
    isFavorit = !isFavorit;
    notifyListeners();

    final url = Uri.parse(
        'https://shop-app-b68ae-default-rtdb.firebaseio.com/userFavorite/$userId/$id.json?auth=$authToken');

        try{
    final responce = await http.put(
      url,
      body: json.encode(
         isFavorit,
      ),
    ); if(responce.statusCode >= 400){
       isFavorit =beforeChange;
      notifyListeners();

    }
    } catch(error){
      isFavorit =beforeChange;
      notifyListeners();
    }
  }
}
