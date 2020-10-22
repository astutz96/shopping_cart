import 'package:flutter/material.dart';
import 'dart:developer';

void main() {
  runApp(MaterialApp(
    title: 'Shopping App',
    home: Text('Shopping Cart'),
  ));
}

class Product {
  const Product({this.name});
  final String name;
}

typedef void CardChangedCallBack(Product product, bool inCart);

class ShoppingListItem extends StatelessWidget {

  final Product product;
  final bool inCart;
  final CardChangedCallBack onCartChanged;

  ShoppingListItem({this.product, this.inCart, this.onCartChanged})
    : super(key: ObjectKey(product));

  Color _getColor(BuildContext context) {
    return inCart ? Colors.black54 : Theme.of(context).primaryColor;
  }

  TextStyle _getTextStyle(BuildContext context) {
    if (!inCart) return null;

    return TextStyle(
      color: Colors.black54,
      decoration: TextDecoration.lineThrough,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(product.name, style: _getTextStyle(context)),
      leading: CircleAvatar(
        backgroundColor: _getColor(context),
        child: Text(product.name[0]),
      ),
      onTap: (){
        onCartChanged(product, inCart);
      },
    );
  }
}

