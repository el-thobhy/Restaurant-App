
import 'package:restaurant_app/core/data/models/detail/category.dart';

class Menu {
  final List<Category> foods;
  final List<Category> drinks;

  const Menu({required this.foods, required this.drinks});

  factory Menu.fromJson(Map<String, dynamic> json) => Menu(
      foods:
          List<Category>.from(json['foods'].map((a) => Category.fromJson(a))),
      drinks:
          List<Category>.from(json['drinks'].map((a) => Category.fromJson(a))));
}