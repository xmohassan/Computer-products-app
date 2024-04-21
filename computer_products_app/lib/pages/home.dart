// ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_const_literals_to_create_immutables

import 'package:computer_products_app/model/products.dart';
import 'package:computer_products_app/pages/detailsScreen.dart';
import 'package:computer_products_app/pages/login.dart';
import 'package:computer_products_app/provider/cart.dart';
import 'package:computer_products_app/shared/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: bluee,
        child: Padding(
          padding: const EdgeInsets.only(top: 18, right: 18, left: 18),
          child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 2 / 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 15),
              itemCount: items.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailsScreen(
                          product: items[index],
                        ),
                      ),
                    );
                  },
                  child: GridTile(
                    child: Stack(
                      children: [
                        Positioned(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(55),
                            child: Image.asset(
                              items[index].imagePath,
                            ),
                          ),
                        ),
                      ],
                    ),
                    footer: GridTileBar(
                      trailing:
                          Consumer<Cart>(builder: ((context, cart, child) {
                        return IconButton(
                          padding: EdgeInsets.only(bottom: 0, left: 5),
                          color: bTNgreen,
                          onPressed: () {
                            cart.add(items[index]);
                          },
                          icon: Icon(
                            Icons.add_circle,
                          ),
                        );
                      })),
                      leading: Text(
                        "\$${items[index].price}",
                        style: TextStyle(color: bTNBlue, fontSize: 15),
                      ),
                      title: Text(""),
                    ),
                  ),
                );
              }),
        ),
      ),
      drawer: Drawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                UserAccountsDrawerHeader(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/image/cover.webp"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  accountName: Text("Mohamed Hassan",
                      style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                      )),
                  accountEmail: Text("mohamedhassan@gmail.com"),
                  currentAccountPictureSize: Size.square(85),
                  currentAccountPicture: CircleAvatar(
                    radius: 60,
                    backgroundImage: AssetImage("assets/image/profile.jpg"),
                  ),
                ),
                ListTile(
                    title: Text("Home"),
                    leading: Icon(Icons.home),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Home()));
                    }),
                ListTile(
                    title: Text("My products"),
                    leading: Icon(Icons.add_shopping_cart),
                    onTap: () {}),
                ListTile(
                    title: Text("About"),
                    leading: Icon(Icons.help_center),
                    onTap: () {}),
                ListTile(
                    title: Text("Logout"),
                    leading: Icon(Icons.exit_to_app),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Login()));
                    }),
              ],
            ),
            Container(
              color: bluee,
              alignment: Alignment.center,
              padding: EdgeInsets.all(16),
              child: Text("Developed by Mohamed Hassan © 2024"),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: bTNBlue,
        title: Text("Home"),
        actions: [
          Consumer<Cart>(builder: ((context, cart, child) {
            return Row(
              children: [
                Stack(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.add_shopping_cart_outlined),
                      style: ButtonStyle(
                          iconColor: MaterialStateProperty.all(Colors.white)),
                    ),
                    Positioned(
                      child: Container(
                          child: Text(
                            "${cart.itemCount}",
                            style: TextStyle(
                              color: bTNBlue,
                            ),
                          ),
                          padding: EdgeInsets.all(3.5),
                          decoration: BoxDecoration(
                              color: bTNgreen, shape: BoxShape.circle)),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 14),
                  child: Text(
                    "\$${cart.price}",
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            );
          })),
        ],
      ),
    );
  }
}
