import 'package:flutter/cupertino.dart';
import 'package:zupay_task/screens/homepage.dart';
import 'package:zupay_task/screens/singleProd.dart';

Map<String, Widget Function(BuildContext)> routeTable = {
  ScreenRef.home: (context) => homePage(),
  ScreenRef.singleProduct: (context) => singleProduct()
};

class ScreenRef {
  static String home = '/';
  static String singleProduct = 'singleProd';
}
