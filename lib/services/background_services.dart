import 'dart:convert';
import 'dart:isolate';
import 'dart:math';
import 'dart:ui';
import 'package:http/http.dart' as http;
import 'package:restaurant_app/core/common/constants.dart';

import 'package:restaurant_app/core/common/notification_helper.dart';
import 'package:restaurant_app/core/data/models/list/restaurant_response.dart';
import 'package:restaurant_app/main.dart';

final ReceivePort port = ReceivePort();

class BackgroundService {
  static BackgroundService? _instance;
  static const String _isolateName = 'isolate';
  static SendPort? _uiSendPort;

  BackgroundService._internal() {
    _instance = this;
  }

  factory BackgroundService() => _instance ?? BackgroundService._internal();

  void initializeIsolate() {
    IsolateNameServer.registerPortWithName(
      port.sendPort,
      _isolateName,
    );
  }

  static Future<void> callback() async {
    final NotificationHelper _notificationHelper = NotificationHelper();

    var response = await http.get(Uri.parse('$baseUrl/list'));
    var result = RestaurantResponse.fromJson(json.decode(response.body));

    var randomIndex = Random().nextInt(result.restaurant.length);
    var randomRestaurant = result.restaurant[randomIndex];

    await _notificationHelper.showNotification(
      flutterLocalNotificationsPlugin,
      randomRestaurant,
    );

    _uiSendPort ??= IsolateNameServer.lookupPortByName(_isolateName);
    _uiSendPort?.send(null);
  }
}
