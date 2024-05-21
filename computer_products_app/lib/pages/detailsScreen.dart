// ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_const_literals_to_create_immutables, must_be_immutable

import 'package:computer_products_app/model/products.dart';
import 'package:computer_products_app/shared/appBar.dart';
import 'package:computer_products_app/shared/colors.dart';
import 'package:flutter/material.dart';

class DetailsScreen extends StatefulWidget {
  Item product;

  DetailsScreen({required this.product});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Column(
          children: [
            Image.asset(widget.product.imagePath),
            SizedBox(
              height: 11,
            ),
            Text("\$${widget.product.price}"),
            SizedBox(
              height: 16,
            ),
            Text(
              widget.product.name,
              style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  padding: EdgeInsets.all(4),
                  child: Text(
                    "New",
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: bink,
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                  ],
                ),
                SizedBox(
                  width: 35,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.edit_location,
                      color: appbarGreen,
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Text(
                      widget.product.location,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    )
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 16,
            ),
            SizedBox(
              width: double.infinity,
              child: Text(
                "About this item:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              widget.product.title,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(
              height: 16,
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: bTNBlue,
        title: Text("Details"),
        actions: [
          ProductsAndPrice(),
        ],
      ),
    );
  }
}
