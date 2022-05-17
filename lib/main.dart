import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'constants/routesTable.dart';
import 'screens/homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    return MaterialApp(
        title: 'Zupay_Shop',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textTheme: TextTheme(
              headline1: TextStyle(
                fontFamily: "Poppins",
                fontWeight: FontWeight.w600,
              ),
              subtitle1: TextStyle(
                fontFamily: "Poppins",
                fontWeight: FontWeight.w500,
              ),
              bodyText1: TextStyle(
                fontFamily: "Poppins",
                fontWeight: FontWeight.w400,
              )),
          primarySwatch: Colors.blue,
        ),
        routes: routeTable);
  }
}
