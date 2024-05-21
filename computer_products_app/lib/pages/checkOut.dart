// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:computer_products_app/provider/cart.dart';
import 'package:computer_products_app/shared/appBar.dart';
import 'package:computer_products_app/shared/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckOut extends StatelessWidget {
  const CheckOut({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: bTNBlue,
        title: Text("Check out"),
        actions: [
          ProductsAndPrice(),
        ],
      ),
      body: Column(
        children: [
          SingleChildScrollView(
            child: SizedBox(
              height: 500,
              child: ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: cart.itemCount,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: ListTile(
                      title: Text(cart.selectedProducts[index].name),
                      subtitle: Text(
                          "${cart.selectedProducts[index].price} - ${cart.selectedProducts[index].location}"),
                      leading: CircleAvatar(
                        backgroundImage:
                            AssetImage(cart.selectedProducts[index].imagePath),
                      ),
                      trailing: IconButton(
                          onPressed: () {
                            cart.remove(cart.selectedProducts[index]);
                          },
                          icon: Icon(Icons.remove)),
                    ),
                  );
                },
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(bTNBlue),
              padding: MaterialStateProperty.all(EdgeInsets.all(12)),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8))),
            ),
            child: Text(
              "Pay \$ ${cart.price}",
              style: TextStyle(fontSize: 19),
            ),
          ),
        ],
      ),
    );
  }
}
