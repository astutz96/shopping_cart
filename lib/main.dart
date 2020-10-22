import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: 'Shopping App',
    home: ShoppingList(
      products: <Product>[
        Product(name: 'Eggs'),
        Product(name: 'Flour'),
        Product(name: 'Chocolate chips'),
      ],
    ),
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

class ShoppingList extends StatefulWidget{

  final List<Product> products;
  //For more info on Keys see https://api.flutter.dev/flutter/foundation/Key-class.html
  ShoppingList({Key key, this.products}) : super(key: key);

  //subclasses of State are typically named with leading underscores to indicate that they are private implementation details
  _ShoppingListState createState() => _ShoppingListState();
}

// When this widget’s parent rebuilds, the parent creates a new instance of ShoppingList,
// but the framework reuses the _ShoppingListState instance that is already in the tree rather than calling createState again.
class _ShoppingListState extends State<ShoppingList> {

  Set<Product> _shoppingCart = Set<Product>();

  void _handleCartChanged(Product product, bool inCart) {
    setState(() {
      if (!inCart)
        _shoppingCart.add(product);
      else
        _shoppingCart.remove(product);
    });
  }
  //you don’t need to write separate code for creating and updating child widgets.
  //Instead, you simply implement the build function, which handles both situations.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ShoppingList'),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 8.0),
        children: widget.products.map((Product product) {
          return ShoppingListItem(
            product: product,
            inCart: _shoppingCart.contains(product),
            onCartChanged: _handleCartChanged,
          );
        }).toList(),
      ),
    );
  }
}