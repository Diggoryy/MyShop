import 'package:flutter/material.dart';
import 'cart_item_card.dart';
import 'cart_manager.dart';
import 'package:provider/provider.dart';
class CartScreen extends StatelessWidget {
 

  const CartScreen({super.key});
   static const routeName = '/cart';

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartManager>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Cart'),
      ),
      body: Column(
        children: [
          buildCartSummary(cart, context),
          const SizedBox(height: 10),
          Expanded(
            child: buildCartDetails(cart)
          ),
        ],
      ),
    );
  }
  Widget buildCartDetails(CartManager cart) {
    return ListView(
      children: cart.productEntries
      .map(
        (Entry) => CartItemCard(
          productId: Entry.key,
          cardItem: Entry.value,
          ),
      )
      .toList(),
    );
  }

  Widget buildCartSummary(CartManager cart, BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(15),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Total',
              style: TextStyle(fontSize: 20),
            ),
            const Spacer(),
            Chip(
              label: Text(
                '\$${cart.totalAmount.toStringAsFixed(2)}',
                style: TextStyle(
                  color: Theme.of(context).primaryTextTheme.headline6?.color,
                  ),
                ),
                backgroundColor: Theme.of(context).primaryColor,
              ),
              TextButton(
                onPressed: (){
                  print('An order has been added');
                },
                style: TextButton.styleFrom(
                  textStyle: TextStyle(color: Theme.of(context).primaryColor),
                ), 
                child: const Text('ORDER NOW'),
                )
          ],
        ),
      ),
    );
  }
}