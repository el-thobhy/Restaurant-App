
import 'package:restaurant_app/core/data/models/detail/category.dart';

class Menu {
  List<Category> foods;
  List<Category> drinks;

  Menu({required this.foods, required this.drinks});

  factory Menu.fromJson(Map<String, dynamic> json) => Menu(
      foods:
          List<Category>.from(json['foods'].map((a) => Category.fromJson(a))),
      drinks:
          List<Category>.from(json['drinks'].map((a) => Category.fromJson(a))));
}