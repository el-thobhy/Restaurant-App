import 'package:restaurant_app/core/common/constants.dart';
import 'package:restaurant_app/core/common/exception.dart';
import 'package:restaurant_app/core/data/datasources/db/database_helper.dart';
import 'package:restaurant_app/core/data/models/list/restaurant_table.dart';

abstract class RestauranLocalDataSource {
  Future<String> insertFavorite(RestaurantTable restaurantTable);
  Future<String> removeFavorite(RestaurantTable restaurantTable);
  Future<RestaurantTable?> getRestaurantById(String id);
  Future<List<RestaurantTable>> getRestaurantFavorite();
}

class RestaurantLocalDataSourceImpl implements RestauranLocalDataSource {
  final DatabaseHelper helper;

  RestaurantLocalDataSourceImpl({required this.helper});

  @override
  Future<String> insertFavorite(RestaurantTable restaurantTable) async {
    try {
      await helper.insertRestaurantList(restaurantTable);
      return bookmarkAddSourceMessage;
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeFavorite(RestaurantTable restaurantTable) async {
    try {
      await helper.removeRestaurantList(restaurantTable);
      return bookmarkRemoveMessage;
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<RestaurantTable?> getRestaurantById(String id) async {
    final result = await helper.getRestaurantId(id);
    if (result != null) {
      return RestaurantTable.fromMap(result);
    } else {
      return null;
    }
  }

  @override
  Future<List<RestaurantTable>> getRestaurantFavorite() async {
    final result = await helper.getRestaurantBookmark();
    return result.map((data) => RestaurantTable.fromMap(data)).toList();
  }
}
