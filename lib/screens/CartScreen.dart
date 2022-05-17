import 'package:flutter/cupertino.dart';
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
    double hfactor = MediaQuery.of(context).size.height / 716;
    double wfactor = MediaQuery.of(context).size.width / 375;
    SingleItem s = widget.cartItemData[0] as SingleItem;
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(25),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Image.network((widget.cartItemData[0] as SingleItem).imageUrl,
                height: 80 * hfactor, width: 80 * wfactor),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 113 * wfactor,
                        child: Text(
                          s.title.substring(0, min(25, s.title.length)) + "...",
                        ),
                      ),
                      Text("\$ " + s.price.toString())
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Size : "),
                      Text(widget.cartItemData[2].toString().substring(6)),
                      Text("Color"),
                      Container(
                        height: 14,
                        width: 14,
                        color: Colors.black,
                      ),
                      TinyBordered("-", widget.cartItemData),
                      Text(widget.cartItemData[1].toString()),
                      TinyBordered("+", widget.cartItemData),
                    ],
                  )
                ],
              ),
            )
          ]),
    );
  }
}

class TinyBordered extends StatefulWidget {
  String s = "";
  List<dynamic> cartItemData;
  TinyBordered(this.s, this.cartItemData);

  @override
  State<TinyBordered> createState() => _TinyBorderedState();
}

class _TinyBorderedState extends State<TinyBordered> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.s == "+")
          Provider.of<Cart>(context, listen: false).addItem(
              item: widget.cartItemData[0],
              quantity: widget.cartItemData[1] + 1);
        else {
          Provider.of<Cart>(context, listen: false).addItem(
              item: widget.cartItemData[0],
              quantity: widget.cartItemData[1] + 1);
        }
      },
      child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Color(0xFFAFBEC4),
            ),
          ),
          height: 24,
          width: 24,
          child: Center(child: Text(widget.s))),
    );
  }
}
