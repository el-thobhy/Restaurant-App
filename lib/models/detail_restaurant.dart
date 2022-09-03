import 'package:equatable/equatable.dart';

class DetailRestaurant extends Equatable {
  final bool error;
  final String message;
  final Detail? restaurant;

  const DetailRestaurant(
      {required this.error, required this.message, required this.restaurant});

  factory DetailRestaurant.fromJson(Map<String, dynamic> json) =>
      DetailRestaurant(
          error: json['error'],
          message: json['message'],
          restaurant: Detail.fromJson(json['restaurant']));

  factory DetailRestaurant.fromNoJson() => const DetailRestaurant(
      error: true,
      message: "No Internet Connection\nPlease Check your Internet Connection",
      restaurant: null);

  @override
  List<Object> get props => [error, message, restaurant!];
}

class Detail extends Equatable {
  final String id;
  final String name;
  final String desc;
  final String city;
  final String address;
  final String pictId;
  final List<Category> categories;
  final Menu menu;
  final double rate;
  final List<CustomerReview> customerReviews;

  const Detail(
      {required this.id,
      required this.name,
      required this.desc,
      required this.pictId,
      required this.rate,
      required this.city,
      required this.menu,
      required this.address,
      required this.categories,
      required this.customerReviews});

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
      id: json['id'],
      name: json['name'],
      desc: json['description'],
      pictId: json['pictureId'],
      rate: json['rating'].toDouble(),
      city: json['city'],
      menu: Menu.fromJson(json['menus']),
      address: json['address'],
      categories: List<Category>.from(
          json['categories'].map((e) => Category.fromJson(e))),
      customerReviews: List<CustomerReview>.from(
          json['customerReviews'].map((e) => CustomerReview.fromJson(e))));

  @override
  List<Object> get props => [
        id,
        name,
        desc,
        pictId,
        rate,
        city,
        menu,
        address,
        categories,
        customerReviews
      ];
}

class CustomerReview {
  final String name;
  final String date;
  final String review;

  CustomerReview(
      {required this.name, required this.date, required this.review});

  factory CustomerReview.fromJson(Map<String, dynamic> json) => CustomerReview(
      name: json['name'], date: json['date'], review: json['review']);
}

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

class Category {
  final String name;

  Category({required this.name});

  factory Category.fromJson(Map<String, dynamic> json) =>
      Category(name: json['name']);
}
