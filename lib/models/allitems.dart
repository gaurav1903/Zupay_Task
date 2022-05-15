import 'ShoppingItem.dart';
import 'package:http/http.dart' as http;
import 'dart:developer';
import 'dart:convert';

class AllShoppingItems {
  static List<SingleItem> items = [];

  static Future<void> getdata() async {
    print("ran");
    var data =
        await http.get(Uri.parse('https://fakestoreapi.com/products?limit=10'));

    List<dynamic> processedData = json.decode(data.body) as List<dynamic>;
  }
}
