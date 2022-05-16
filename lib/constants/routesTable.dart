import 'package:flutter/cupertino.dart';
import 'package:zupay_task/screens/homepage.dart';
import 'package:zupay_task/screens/CartScreen.dart';

Map<String, Widget Function(BuildContext)> routeTable = {
  ScreenRef.home: (context) => Home(),
  ScreenRef.cartScreen: (context) => CartScreenProvider(),
};

class ScreenRef {
  static String home = '/';
  static String cartScreen = 'cartScreen';
}
