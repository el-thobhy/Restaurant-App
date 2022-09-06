import 'dart:io';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/core/common/http_client.dart';
import 'package:restaurant_app/core/common/notification_helper.dart';
import 'package:restaurant_app/core/common/utils.dart';
import 'package:restaurant_app/injection.dart' as di;
import 'package:restaurant_app/services/background_services.dart';
import 'package:restaurant_app/ui/bloc/detail/detail_bloc.dart';
import 'package:restaurant_app/ui/bloc/favorite/favorite_bloc.dart';
import 'package:restaurant_app/ui/bloc/list/restaurant_bloc.dart';
import 'package:restaurant_app/ui/bloc/schedule/schedule_cubit.dart';
import 'package:restaurant_app/ui/bloc/search/search_bloc.dart';
import 'package:restaurant_app/ui/detail_page.dart';
import 'package:restaurant_app/ui/favorite_page.dart';
import 'package:restaurant_app/ui/main_page.dart';
import 'package:restaurant_app/ui/search_page.dart';
import 'package:restaurant_app/ui/settings_page.dart';
import 'package:restaurant_app/ui/splash.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final NotificationHelper notificationHelper = NotificationHelper();
  final BackgroundService _service = BackgroundService();

  _service.initializeIsolate();

  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }
  await notificationHelper.initNotifications(flutterLocalNotificationsPlugin);

  await HttpClientInit.init();

  di.init();

  final storage = await HydratedStorage.build(
    storageDirectory: await getTemporaryDirectory(),
  );

  HydratedBlocOverrides.runZoned(
    () => runApp(const MyApp()),
    storage: storage,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider(
          create: (_) => di.locator<RestaurantBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<DetailBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<SearchBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<FavoriteBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<ScheduleCubit>(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const Splash(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case Splash.routeName:
              return MaterialPageRoute(
                builder: (_) => const Splash(),
              );
            case MainPage.routeName:
              return MaterialPageRoute(
                builder: (_) => const MainPage(),
              );
            case FavoritePage.routeName:
              return MaterialPageRoute(
                builder: (_) => const FavoritePage(),
              );
            case SearchPage.routeName:
              return MaterialPageRoute(
                builder: (_) => const SearchPage(),
              );
            case PageDetail.routeName:
              final id = settings.arguments as String;
              return MaterialPageRoute(
                builder: (_) => PageDetail(idRestaurant: id),
                settings: settings,
              );
            case SettingsPage.routeName:
              return MaterialPageRoute(
                builder: (_) => const SettingsPage(),
              );

            default:
              return MaterialPageRoute(
                builder: (_) {
                  return const Scaffold(
                    body: Center(
                      child: Text("page Not Found"),
                    ),
                  );
                },
              );
          }
        },
      ),
    );
  }
}
