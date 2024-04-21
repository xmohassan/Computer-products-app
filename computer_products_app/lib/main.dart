import 'package:computer_products_app/model/products.dart';
import 'package:computer_products_app/pages/detailsScreen.dart';
import 'package:computer_products_app/pages/home.dart';
import 'package:computer_products_app/pages/login.dart';
import 'package:computer_products_app/pages/register.dart';
import 'package:computer_products_app/pages/splash_screen.dart';
import 'package:computer_products_app/provider/cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) {
          return Cart();
        },
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData.light(useMaterial3: false),
          home: Home(),
        ));
  }
}
