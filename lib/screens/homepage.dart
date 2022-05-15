import 'package:flutter/material.dart';
import 'package:zupay_task/models/ShoppingItem.dart';
import 'package:zupay_task/models/allitems.dart';
import 'dart:developer';

class homePage extends StatefulWidget {
  const homePage({Key? key}) : super(key: key);

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * 152 / 716),
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFFF3F4F6), Color(0x00F3F4F6)])),
          child: Padding(
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 64 / 716,
                left: MediaQuery.of(context).size.height * 24 / 716,
                right: MediaQuery.of(context).size.height * 24 / 716,
                bottom: MediaQuery.of(context).size.height * 19 / 716),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset("assets/icons/appbar_lines.jpg"),
                  Image.asset("assets/icons/appbar_search.jpg")
                ],
              ),
              Expanded(child: SizedBox()),
              Text(
                "New Arrivals",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
            ]),
          ),
        ),
      ),
      body: FutureBuilder(
          future: AllShoppingItems.getdata(),
          builder: (context, snap) {
            if (snap.connectionState != ConnectionState.done)
              return Center(child: CircularProgressIndicator());
            else {
              log(AllShoppingItems.items.length.toString());
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (context, index) {
                  return GridTile(child: Text("2"));
                },
                itemCount: AllShoppingItems.items.length,
              );
            }
          }),
    );
  }
}

// ShoppingProd(AllShoppingItems.items[index])
class ShoppingProd extends StatefulWidget {
  SingleItem s;
  ShoppingProd(this.s, {Key? key}) : super(key: key);
  @override
  _ShoppingProdState createState() => _ShoppingProdState();
}

class _ShoppingProdState extends State<ShoppingProd> {
  @override
  Widget build(BuildContext context) {
    double hfactor = MediaQuery.of(context).size.height / 716;
    double wfactor = MediaQuery.of(context).size.width / 375;
    return Container(
      color: Colors.blue,
      height: 270 * hfactor,
      width: 165 * wfactor,
      child: Column(
        children: [
          Image.network(
            widget.s.imageUrl,
            height: hfactor * 180,
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Text(widget.s.title),
                Text(widget.s.category),
                Row(
                  children: [Text(widget.s.price.toString())],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
