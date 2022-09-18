import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_2022/providers/cart.dart';

class CartItems extends StatelessWidget {
  final String id;
  final String productId;
  final double price;
  final int quantity;
  final String title;

  CartItems( this.id, this.productId , this.price, this.quantity, this.title);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      background: Container(
        color: Colors.black87,
        alignment: Alignment.centerRight,
        padding:const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        child: Icon(Icons.delete, color: Theme.of(context).colorScheme.secondary,size: 40,),
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) {
        return showDialog(context: context, builder: (context) {
          return AlertDialog(
            title:const Text('Are You Sure?'),
            content:const Text('Do you want to remove the item from cart'),
            actions: [
              FlatButton(onPressed: (){
                Navigator.of(context).pop(false);
              }, child:const Text('No')),
              FlatButton(onPressed: (){
                Navigator.of(context).pop(true);
              }, child:const Text('Yes'))
            ],
          );
        });
      },
      // crossAxisEndOffset: 0.5,
      onDismissed: (direction) {
        Provider.of<Cart>(context, listen: false).removeItem(productId);
      },
      child: Card(
        color: Theme.of(context).accentColor,
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        child: Padding(
          padding:const EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.black,
              foregroundColor: Theme.of(context).accentColor,
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: FittedBox(child: Text("\$ $price")),
              ),
            ),
            title: Text(title),
            subtitle: Text('Total: \$${(price * quantity)}'),
            trailing: Text('$quantity x'),
          ),
        ),
      ),
    );
  }
}
