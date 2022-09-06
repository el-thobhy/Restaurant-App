import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:restaurant_app/core/common/constants.dart';
import 'package:restaurant_app/core/common/exception.dart';
import 'package:restaurant_app/core/data/datasources/remote_data_source.dart';
import 'package:restaurant_app/core/data/models/detail/detail_restaurant.dart';
import 'package:restaurant_app/core/data/models/list/restaurant_response.dart';
import 'package:restaurant_app/core/data/models/search/search_response.dart';

import '../../helper/read_json.dart';
import '../../helper/test_helper.dart';

void main() {
  late RestaurantRemoteDataSourceImpl remote;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    remote = RestaurantRemoteDataSourceImpl(mockHttpClient);
  });

  group('get Restaurant List', () {
    final resto = RestaurantResponse.fromJson(
            json.decode(readJson('dummy_data/restaurant_list.json')))
        .restaurant;

    test('should return list of Restaurant when the response code is 200',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$baseUrl/list'))).thenAnswer(
          (_) async =>
              http.Response(readJson('dummy_data/restaurant_list.json'), 200));
      // act
      final result = await remote.getRestaurant();
      // assert
      expect(result, equals(resto));
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$baseUrl/list')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = remote.getRestaurant();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get Detail', () {
    final detail =
        DetailResponse.fromJson(json.decode(readJson('dummy_data/detail.json')))
            .message;
    const id = "rqdv5juczeskfw1e867";

    test(
        'should return success message of Restaurant Detail when the response code is 200',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$baseUrl/detail/$id'))).thenAnswer(
          (_) async => http.Response(readJson('dummy_data/detail.json'), 200));
      // act
      final result = await remote.getDetail(id);
      // assert
      expect(result.message, equals(detail));
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$baseUrl/detail/$id')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = remote.getDetail(id);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get Search', () {
    final search =
        SearchResponse.fromJson(json.decode(readJson('dummy_data/search.json')))
            .result;
    const query = "mel";

    test(
        'should return result of Restaurant Search isNotEmpty when the response code is 200',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$baseUrl/search?q=$query')))
          .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/search.json'), 200));
      // act
      final result = await remote.getSearch(query);
      // assert
      expect(result.isNotEmpty, equals(search.isNotEmpty));
    });

    test("should throw Empty list when the query didn't match to any result",
        () async {
      final search = SearchResponse.fromJson(
              json.decode(readJson('dummy_data/empty_search.json'))).result;
      const query = "resda";
      // arrange
      when(mockHttpClient.get(Uri.parse('$baseUrl/search?q=$query')))
          .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/empty_search.json'), 200));
      // act
      final call = await remote.getSearch(query);
      // assert
      expect(call.isEmpty, equals(search.isEmpty));
    });
  });
}
