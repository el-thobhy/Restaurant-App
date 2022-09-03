import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/ui/wrapper.dart';

import 'bloc/detail_bloc.dart';
import 'bloc/page_bloc.dart';
import 'bloc/restaurant_bloc.dart';
import 'bloc/search_bloc.dart';

void main() {
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
          create: (_) => RestaurantBloc()..add(GetRestaurant()),
        ),
        BlocProvider(create: (_) => DetailBloc()),
        BlocProvider(create: (_) => SearchBloc())
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Wrapper(),
      ),
    );
  }
}
