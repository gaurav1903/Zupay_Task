import 'package:flutter/material.dart';
import 'package:zupay_task/models/Cart.dart';
import 'package:zupay_task/models/ShoppingItem.dart';
import 'package:zupay_task/models/allitems.dart';
import 'dart:developer';
import 'package:provider/provider.dart';
import 'dart:math';
import 'package:zupay_task/constants/routesTable.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AllShoppingItems>(
            create: (context) => AllShoppingItems()),
        ChangeNotifierProvider<Cart>(
          create: (context) => Cart(),
        )
      ],
      child: homePage(),
    );
  }
}

class homePage extends StatefulWidget {
  const homePage({Key? key}) : super(key: key);

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  late final Future gettingdata;
  @override
  void initState() {
    gettingdata =
        Provider.of<AllShoppingItems>(context, listen: false).getdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double hfactor = MediaQuery.of(context).size.height / 716;
    double wfactor = MediaQuery.of(context).size.width / 375;
    return Scaffold(
      bottomNavigationBar: BottomBar(hfactor: hfactor, wfactor: wfactor),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(hfactor * 152),
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFFF3F4F6), Color(0x00F3F4F6)])),
          child: Padding(
            padding: EdgeInsets.only(
                top: hfactor * 64,
                left: hfactor * 24,
                right: wfactor * 24,
                bottom: wfactor * 19),
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
      body: RefreshIndicator(
        onRefresh: () async {
          await Provider.of<AllShoppingItems>(context, listen: false).getdata();
        },
        child: FutureBuilder(
            future: gettingdata,
            builder: (context, snap) {
              if (snap.connectionState != ConnectionState.done)
                return Center(child: CircularProgressIndicator());
              else {
                // log(AllShoppingItems.items.length.toString() + "   home page");
                return GridView.builder(
                  padding: EdgeInsets.all(20),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 13 * hfactor,
                      crossAxisSpacing: 13 * wfactor,
                      childAspectRatio: (wfactor * 165) / (290 * hfactor)),
                  itemBuilder: (context, index) {
                    return GridTile(
                        child: ShoppingProd(
                            Provider.of<AllShoppingItems>(context)
                                .items[index]));
                  },
                  itemCount:
                      Provider.of<AllShoppingItems>(context).items.length,
                );
              }
            }),
      ),
    );
  }
}

class BottomBar extends StatelessWidget {
  const BottomBar({
    Key? key,
    required this.hfactor,
    required this.wfactor,
  }) : super(key: key);

  final double hfactor;
  final double wfactor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 35),
      height: 96 * hfactor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(12),
            height: 48 * hfactor,
            width: 108 * wfactor,
            decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(20)),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  "assets/icons/BottomHome.png",
                  height: 20,
                ),
                SizedBox(
                  width: 20,
                ),
                Text("Home")
              ],
            ),
          ),
          SizedBox(width: 100),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(ScreenRef.cartScreen);
            },
            child: Center(
              child: Image.asset("assets/icons/ShoppingBag.jpg"),
            ),
          ),
        ],
      ),
    );
  }
}

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
      // color: Colors.blue,
      height: 310 * hfactor,
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
                Text(widget.s.title
                    .substring(0, min(widget.s.title.length, 30))),
                Text(widget.s.category),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(widget.s.price),
                    GestureDetector(
                      onTap: () {
                        Provider.of<Cart>(context).addItem(item: widget.s);
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Successfully added to cart"),
                          duration: Duration(seconds: 2),
                        ));
                      },
                      child: Image.asset(
                        "assets/icons/ShoppingBag.jpg",
                        height: 20,
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
