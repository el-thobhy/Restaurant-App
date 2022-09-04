import 'package:equatable/equatable.dart';
import 'package:restaurant_app/core/data/models/detail/category.dart';
import 'package:restaurant_app/core/data/models/detail/customer_review.dart';
import 'package:restaurant_app/core/data/models/detail/menu.dart';

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

  Detail toEntity() {
    return Detail(
        id: id,
        name: name,
        desc: desc,
        pictId: pictId,
        rate: rate,
        city: city,
        menu: menu,
        address: address,
        categories: categories,
        customerReviews: customerReviews);
  }

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
