import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/core/common/utils.dart';
import 'package:restaurant_app/injection.dart' as di;
import 'package:restaurant_app/ui/detail_page.dart';
import 'package:restaurant_app/ui/favorite_page.dart';
import 'package:restaurant_app/ui/main_page.dart';
import 'package:restaurant_app/ui/search_page.dart';
import 'package:restaurant_app/ui/settings_page.dart';
import 'package:restaurant_app/ui/splash.dart';

import 'bloc/detail_bloc.dart';
import 'bloc/list/restaurant_bloc.dart';
import 'bloc/page_bloc.dart';
import 'bloc/search_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider(create: (_) => PageBloc()),
        BlocProvider(
          create: (_) => di.locator<RestaurantBloc>(),
        ),
        BlocProvider(create: (_) => DetailBloc()),
        BlocProvider(create: (_) => SearchBloc())
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: const Splash(),
          navigatorObservers: [routeObserver],
          onGenerateRoute: (RouteSettings settings) {
            switch (settings.name) {
              case Splash.routeName:
                return MaterialPageRoute(builder: (_) => const Splash());
              case MainPage.routeName:
                return MaterialPageRoute(builder: (_) => const MainPage());
              case FavoritePage.routeName:
                return MaterialPageRoute(builder: (_) => const FavoritePage());
              case SearchPage.routeName:
                return MaterialPageRoute(builder: (_) => const SearchPage());
              case PageDetail.routeName:
                final id = settings.arguments as String;
                return MaterialPageRoute(
                  builder: (_) => PageDetail(idRestaurant: id),
                  settings: settings,
                );
              case SettingsPage.routeName:
                return MaterialPageRoute(builder: (_) => const SettingsPage());

              default:
                return MaterialPageRoute(builder: (_) {
                  return const Scaffold(
                      body: Center(
                    child: Text("page Not Found"),
                  ));
                });
            }
          }),
    );
  }
}
