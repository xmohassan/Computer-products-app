// ignore_for_file: sort_child_properties_last

import 'package:computer_products_app/pages/checkOut.dart';
import 'package:computer_products_app/provider/cart.dart';
import 'package:computer_products_app/shared/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductsAndPrice extends StatelessWidget {
  const ProductsAndPrice({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Row(
      children: [
        Stack(
          children: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CheckOut(),
                  ),
                );
              },
              icon: const Icon(Icons.add_shopping_cart_outlined),
              style: ButtonStyle(
                  iconColor: MaterialStateProperty.all(Colors.white)),
            ),
            Positioned(
              child: Container(
                  child: Text(
                    "${cart.itemCount}",
                    style: const TextStyle(
                      color: bTNBlue,
                    ),
                  ),
                  padding: const EdgeInsets.all(3.5),
                  decoration: const BoxDecoration(
                      color: bTNgreen, shape: BoxShape.circle)),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(right: 14),
          child: Text(
            "\$${cart.price}",
            style: const TextStyle(color: Colors.white),
          ),
        )
      ],
    );
  }
}
