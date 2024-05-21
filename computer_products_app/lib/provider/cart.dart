import 'package:computer_products_app/model/products.dart';
import 'package:flutter/material.dart';

class Cart with ChangeNotifier {
  int price = 0;

  List selectedProducts = [];

  add(Item product) {
    selectedProducts.add(product);
    price += product.price.round();
    notifyListeners();
  }

  remove(Item product) {
    selectedProducts.remove(product);
    price -= product.price.round();
    notifyListeners();
  }

  get itemCount {
    return selectedProducts.length;
  }
}
