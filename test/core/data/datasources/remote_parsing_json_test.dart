import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:restaurant_app/core/common/constants.dart';
import 'package:restaurant_app/core/common/exception.dart';
import 'package:restaurant_app/core/data/datasources/remote_data_source.dart';
import 'package:restaurant_app/core/data/models/list/restaurant_response.dart';

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
    final tRestoList = RestaurantResponse.fromJson(
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
      expect(result, equals(tRestoList));
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
}
