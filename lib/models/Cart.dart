import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zupay_task/models/ShoppingItem.dart';

enum Sizes { XS, S, M, L, XL, XXL }

enum Col { Black, Blue, Red, Yellow, Purple, Green }

class Cart with ChangeNotifier {
  Map<String, List<dynamic>> cart = {};
  int bill = 0;
  // Colors colors=Colors.Black)
  void addItem(
      {required SingleItem item,
      int quantity = 1,
      Sizes size = Sizes.M,
      Col colors = Col.Black}) {
    cart[item.id.toString()] = [item, quantity, size, colors];
    notifyListeners();
  }

  void calculateBill() {
    cart.forEach((key, value) {
      bill = value[1] * int.parse((value[0] as SingleItem).price);
    });
    notifyListeners();
  }
}
