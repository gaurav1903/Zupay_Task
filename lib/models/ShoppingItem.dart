import 'package:flutter/material.dart';

class SingleItem {
  final int id, count;
  final String title, description, category, imageUrl;
  final double price, rate;
  SingleItem(
      {required this.title,
      required this.rate,
      required this.imageUrl,
      required this.category,
      required this.description,
      required this.count,
      required this.id,
      required this.price});
}
