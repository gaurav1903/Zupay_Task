import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zupay_task/models/Cart.dart';
import 'package:zupay_task/models/ShoppingItem.dart';
import 'dart:math';

class CartScreenProvider extends StatelessWidget {
  const CartScreenProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Cart>(
      create: (context) => Cart(),
      child: CartScreen(),
    );
  }
}

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<List<dynamic>> currentCart =
        Provider.of<Cart>(context).getCart().values.toList();
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return CartItem(currentCart[index]);
        },
        itemCount: currentCart.length,
      ),
    );
  }
}

class CartItem extends StatefulWidget {
  List<dynamic> cartItemData;
  CartItem(this.cartItemData);
//item,quantity,size,color
  @override
  _CartItemState createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  @override
  Widget build(BuildContext context) {
    SingleItem s = widget.cartItemData[0] as SingleItem;
    return Container(
      padding: EdgeInsets.all(25),
      child: Row(children: [
        Image.network((widget.cartItemData[0] as SingleItem).imageUrl),
        Column(
          children: [
            Row(
              children: [
                Text(
                  s.title.substring(0, min(30, s.title.length)),
                ),
                Text(s.price)
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Text("Size  " + widget.cartItemData[2].toString().substring(4)),
                Text("Color "),
                Container(
                  height: 14,
                  width: 14,
                  color: Colors.black,
                ),
                GestureDetector(
                  onTap: () {
                    Provider.of<Cart>(context)
                        .addItem(item: s, quantity: widget.cartItemData[1] + 1);
                  },
                  child: Container(
                    padding: EdgeInsets.all(5),
                    child: Text("+"),
                  ),
                ),
                Text(widget.cartItemData[1].toString()),
                GestureDetector(
                  onTap: () {
                    Provider.of<Cart>(context)
                        .addItem(item: s, quantity: widget.cartItemData[1] - 1);
                  },
                  child: Container(
                    padding: EdgeInsets.all(5),
                    child: Text("-"),
                  ),
                ),
              ],
            )
          ],
        )
      ]),
    );
  }
}
