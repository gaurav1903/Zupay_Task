import 'ShoppingItem.dart';
import 'package:http/http.dart' as http;
import 'dart:developer';
import 'dart:convert';

class AllShoppingItems {
  static List<SingleItem> items = [];

  static Future<void> getdata() async {
    // print("ran");
    var data =
        await http.get(Uri.parse('https://fakestoreapi.com/products?limit=5'));

    List<dynamic> processedData = json.decode(data.body) as List<dynamic>;
    log(processedData.toString());
    log("rannnnnn");
    items = processedData.map((e) {
      log(e['rating']['rate'].toString()); //todo:: bug in 5th ite

      return SingleItem(
          id: e['id'],
          title: e['title'],
          description: e['description'],
          imageUrl: e['image'],
          price: e['price'],
          category: e['category'],
          rate: e['rating']['rate'],
          count: e['rating']['count']);
    }).toList();
    log("thi ran here" + items.length.toString());
  }
}
