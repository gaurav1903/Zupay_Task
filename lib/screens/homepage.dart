import 'package:flutter/material.dart';
import 'package:zupay_task/models/allitems.dart';

class homePage extends StatefulWidget {
  const homePage({Key? key}) : super(key: key);

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        'starting out',
      )),
      body: FutureBuilder(
          future: AllShoppingItems.getdata(),
          builder: (context, snap) {
            if (snap.connectionState != ConnectionState.done)
              return Center(child: CircularProgressIndicator());
            else
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (context, index) {
                  return GridTile(child: Text("1"));
                },
              );
          }),
    );
  }
}
