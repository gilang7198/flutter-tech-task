import 'package:flutter/material.dart';
import 'package:tech_task/models/ingredient_model.dart';


class CartState with ChangeNotifier {

  int _count = 0;

  int get count => _count;


  final listIngredientSelected = List<IngredientCart>();



  void tambahItem(Ingredient item) {
    int indexProduk = -1;

    for (int i = 0; i < listIngredientSelected.length; i++) {
      if (item.title == listIngredientSelected[i].item.title) {
        indexProduk = i;
        break;
      }
    }
    if (indexProduk == -1) {
      listIngredientSelected.add(IngredientCart(item: item, jumlah: 1));
      _count = listIngredientSelected.length;
    }else{
      listIngredientSelected.add(IngredientCart(item: item, jumlah: 1));
      _count = listIngredientSelected.length;
    }
    print(listIngredientSelected);
    notifyListeners();

  }

}

class IngredientCart{
  final Ingredient item;
  int jumlah;

  IngredientCart({this.item, this.jumlah});

  @override
  String toString() {
    return "Title: " + item.title + ", Jumlah: " + jumlah.toString();
  }

}

