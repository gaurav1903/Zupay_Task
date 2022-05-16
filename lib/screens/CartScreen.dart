import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zupay_task/models/Cart.dart';
import 'package:zupay_task/models/ShoppingItem.dart';

class CartScreenProvider extends StatelessWidget {
  const CartScreenProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Provider.of<Cart>(context),
      child: CartScreen(),
    );
  }
}

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<List<dynamic>> currentCart =
        Provider.of<Cart>(context).cart.values.toList();
    return Scaffold(
        appBar: AppBar(),
        body: ListView.builder(
          itemBuilder: (ctx, index) {
            return CartItem(currentCart[index]);
          },
          itemCount: currentCart.length,
        ));
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
    return Container(
        padding: EdgeInsets.all(25),
        child: Row(children: [
          Image.network((widget.cartItemData[0] as SingleItem).imageUrl),
          Column(
            children: [Row(), Row()],
          )
        ]));
  }
}
