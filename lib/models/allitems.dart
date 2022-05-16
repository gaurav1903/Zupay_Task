import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'ShoppingItem.dart';
import 'package:http/http.dart' as http;
import 'dart:developer';
import 'dart:convert';

class AllShoppingItems with ChangeNotifier {
  List<SingleItem> items = [];
  int limit = 0;

  Future<void> getdata() async {
    limit += 10;

    var data = await http
        .get(Uri.parse("https://fakestoreapi.com/products?limit=$limit"));

    List<dynamic> processedData = json.decode(data.body) as List<dynamic>;
    log(processedData.toString());
    log("rannnnnn");
    items = processedData.map((e) {
      return SingleItem(
          id: e['id'],
          title: e['title'],
          description: e['description'],
          imageUrl: e['image'],
          price: e['price'].toString(),
          category: e['category'],
          rate: e['rating']['rate'].toString(),
          count: e['rating']['count']);
    }).toList();
    notifyListeners();
    log("this ran here" + items.length.toString());
  }
}
