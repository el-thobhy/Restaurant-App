import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/core/domain/entities/restaurant.dart';
import 'package:restaurant_app/ui/bloc/list/restaurant_bloc.dart';
import 'package:restaurant_app/ui/bloc/list/restaurant_state.dart';
import 'package:restaurant_app/ui/detail_page.dart';
import 'package:restaurant_app/ui/search_page.dart';
import 'package:restaurant_app/widget/empty_state.dart';
import 'package:restaurant_app/widget/item_list_vertical.dart';
import 'package:restaurant_app/widget/error_state.dart';

class MainPage extends StatefulWidget {
  static const routeName = '/main-page';

  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  TextEditingController find = TextEditingController();

  @override
  void initState() {
    Future.microtask(() {
      BlocProvider.of<RestaurantBloc>(context).add(OnFetchGetRestaurant());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text('Restaurant'),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  SearchPage.routeName,
                );
              },
              icon: const Icon(Icons.search),
            )
          ]),
      body: Stack(
        children: [
          Container(
            color: Colors.black54,
          ),
          SafeArea(
              child: Container(
            color: Colors.black,
          )),
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: SafeArea(
                child: Column(
              children: [
                BlocBuilder<RestaurantBloc, RestaurantState>(
                    builder: (context, listState) {
                  if (listState is RestaurantError) {
                    return ErrorState(message: listState.message);
                  } else if (listState is RestaurantLoaded) {
                    List<Restaurant> listRestaurant = listState.restaurantList;
                    if (listRestaurant.isEmpty) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [Text('Not Found')],
                      );
                    } else {
                      return Column(
                        children: listRestaurant
                            .map((e) =>
                                ItemListVertical(e, listRestaurant, onTap: () {
                                  Navigator.pushNamed(
                                      context, PageDetail.routeName,
                                      arguments: e.id);
                                }))
                            .toList(),
                      );
                    }
                  } else if (listState is RestaurantLoading) {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height * 0.75,
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  } else {
                    return const EmptyState();
                  }
                }),
              ],
            )),
          )
        ],
      ),
    );
  }
}
