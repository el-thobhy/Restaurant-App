import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:restaurant_app/core/common/constants.dart';
import 'package:restaurant_app/core/common/exception.dart';
import 'package:restaurant_app/core/data/models/list/restaurant_model.dart';
import 'package:restaurant_app/core/data/models/list/restaurant_response.dart';

abstract class RestaurantRemoteDataSource {
  Future<List<RestaurantModel>> getRestaurant();
}

class RestaurantRemoteDataSourceImpl implements RestaurantRemoteDataSource {
  @override
  Future<List<RestaurantModel>> getRestaurant() async {
    var response = await http.get(Uri.parse('$baseUrl/list'));

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      return RestaurantResponse.fromJson(data).restaurant;
    } else {
      throw ServerException();
    }
  }
}
