import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zupay_task/models/ShoppingItem.dart';
import 'dart:developer';

enum Sizes { XS, S, M, L, XL, XXL }

enum Col { Black, Blue, Red, Yellow, Purple, Green }

class Cart with ChangeNotifier {
  static Map<String, List<dynamic>> cart = {};
  static double bill = 0;
  // Colors colors=Colors.Black)
  void addItem(
      {required SingleItem item,
      int quantity = 1,
      Sizes size = Sizes.M,
      Col colors = Col.Black}) {
    log("add item " + quantity.toString());
    if (quantity == 0) {
      cart.remove(item.id.toString()); //TODO::DEBUG NOT WORKING
      log("removing");
      calculateBill();
      notifyListeners();
    } else {
      cart[item.id.toString()] = [item, quantity, size, colors];
      calculateBill();
      notifyListeners();
    }
  }

  Map<String, List<dynamic>> getCart() {
    return cart;
  }

  void calculateBill() {
    cart.forEach((key, value) {
      bill += value[1] * double.parse((value[0] as SingleItem).price);
    });
    notifyListeners();
    log("bill calculted" + bill.toString());
  }

  double getBill() {
    return bill;
  }
}
