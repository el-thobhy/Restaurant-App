import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:restaurant_app/core/data/models/search/search_response.dart';
import 'package:restaurant_app/models/detail_restaurant.dart';

class ApiServices {
  static const String _baseUrl = "https://restaurant-api.dicoding.dev/";
  static const String baseUrlImage = "${_baseUrl}images/";

  Future<DetailRestaurant> getDetailRestaurant(String id) async {
    try {
      var response = await http.get(Uri.parse(_baseUrl + "detail/" + id));
      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        return DetailRestaurant.fromJson(data);
      } else {
        throw Exception(response.body);
      }
    } on SocketException {
      return DetailRestaurant.fromNoJson();
    }
  }

  Future<SearchResponse> searchRestaurant(String query) async {
    try {
      var response = await http.get(Uri.parse(_baseUrl + "search?q=" + query));
      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        return SearchResponse.fromJson(data);
      } else {
        throw Exception("gagal" + response.body);
      }
    } on SocketException {
      return SearchResponse.fromJsonNo();
    }
  }
}
