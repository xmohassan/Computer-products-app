// ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_const_literals_to_create_immutables

import 'package:computer_products_app/model/products.dart';
import 'package:computer_products_app/pages/checkOut.dart';
import 'package:computer_products_app/pages/detailsScreen.dart';
import 'package:computer_products_app/pages/profilePage.dart';
import 'package:computer_products_app/provider/cart.dart';
import 'package:computer_products_app/shared/appBar.dart';
import 'package:computer_products_app/shared/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    final user = FirebaseAuth.instance.currentUser!;
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
                      trailing: IconButton(
                        padding: EdgeInsets.only(bottom: 0, left: 5),
                        color: bTNgreen,
                        onPressed: () {
                          cart.add(items[index]);
                        },
                        icon: Icon(
                          Icons.add_circle,
                        ),
                      ),
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
                      image: AssetImage("assets/image/profile.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  accountName: Text("Mohamed Hassan",
                      style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                      )),
                  accountEmail: Text("itsmohassan@gmail.com"),
                  currentAccountPictureSize: Size.square(85),
                  currentAccountPicture: CircleAvatar(
                    radius: 60,
                    backgroundImage: AssetImage("assets/image/cover.webp"),
                  ),
                ),
                ListTile(
                    title: Text("Profile"),
                    leading: Icon(Icons.person),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProfilePage()));
                    }),
                ListTile(
                    title: Text(
                      "Home",
                    ),
                    leading: Icon(
                      Icons.home,
                    ),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Home()));
                    }),
                ListTile(
                    title: Text("My products"),
                    leading: Icon(Icons.add_shopping_cart),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => CheckOut()));
                    }),
                ListTile(
                    title: Text("About"),
                    leading: Icon(Icons.help_center),
                    onTap: () {}),
                ListTile(
                    title: Text("Logout"),
                    leading: Icon(Icons.exit_to_app),
                    onTap: () async {
                      await FirebaseAuth.instance.signOut();
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
        title: Text("Home", style: TextStyle(color: Colors.white)),
        actions: [
          ProductsAndPrice(),
        ],
      ),
    );
  }
}
