import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zupay_task/models/ShoppingItem.dart';

enum Size { XS, S, M, L, XL, XXL }

enum Col { Black, Blue, Red, Yellow, Purple, Green }

class Cart with ChangeNotifier {
  Map<String, List<dynamic>> cart = {};
  // Colors colors=Colors.Black)
  void addItem(
      {required SingleItem item,
      int quantity = 1,
      Size size = Size.M,
      Col colors = Col.Black}) {
    cart[item.id.toString()] = [item, quantity, size, colors];
    notifyListeners();
  }
  // List<>
}
