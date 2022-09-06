import 'package:restaurant_app/core/data/models/detail/category.dart';
import 'package:restaurant_app/core/data/models/detail/customer_review.dart';
import 'package:restaurant_app/core/data/models/detail/menu.dart';
import 'package:restaurant_app/core/domain/entities/detail.dart';
import 'package:restaurant_app/core/domain/entities/restaurant.dart';

const testRestaurant = Restaurant(
  id: "rqdv5juczeskfw1e867",
  city: "Medan",
  name: "Melting Pot",
  rate: 4.2,
  desc:
      "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. ...",
  pictId: "14",
);

final testRestaurantList = [testRestaurant];

const testDetail = Detail(
    id: "rqdv5juczeskfw1e867",
    name: "Melting Pot",
    desc:
        "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. ...",
    pictId: "14",
    rate: 4.2,
    city: "Medan",
    menu: Menu(
        drinks: [Category(name: "Es krim")],
        foods: [Category(name: "Paket rosemary")]),
    address: "Jln. Pandeglang no 19",
    categories: [
      Category(name: "Italia")
    ],
    customerReviews: [
      CustomerReview(
        name: "Ahmad",
        date: "13 November 2019",
        review: "Tidak rekomendasi untuk pelajar!",
      )
    ]);
