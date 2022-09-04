import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurant_app/bloc/list/restaurant_bloc.dart';
import 'package:restaurant_app/bloc/list/restaurant_state.dart';
import 'package:restaurant_app/core/domain/entities/restaurant.dart';
import 'package:restaurant_app/ui/detail_page.dart';
import 'package:restaurant_app/ui/search_page.dart';
import 'package:restaurant_app/widget/item_list_vertical.dart';
import 'package:restaurant_app/widget/no_internet.dart';

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
      BlocProvider.of<RestaurantBloc>(context).add(const RestaurantEvent());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                Container(
                  margin: const EdgeInsets.only(right: 16, top: 16, left: 16),
                  child: Text(
                    "Restaurant",
                    style:
                        GoogleFonts.poppins(fontSize: 30, color: Colors.white),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 16, top: 6, bottom: 10),
                  child: Text(
                    'Recommendation Restaurant for you',
                    style:
                        GoogleFonts.poppins(fontSize: 14, color: Colors.white),
                  ),
                ),
                Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width - 16 - 16 - 100,
                      margin: const EdgeInsets.only(left: 16, bottom: 6),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: TextField(
                          controller: find,
                        ),
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white),
                    ),
                    Container(
                        width: 90,
                        height: 47,
                        margin: const EdgeInsets.only(right: 16, left: 10),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, SearchPage.routeName);
                          },
                          child: Text(
                            'Search',
                            style: GoogleFonts.poppins(
                              fontSize: 15,
                            ),
                          ),
                        )),
                  ],
                ),
                BlocBuilder<RestaurantBloc, RestaurantState>(
                    builder: (context, listState) {
                  if (listState is RestaurantLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (listState is RestaurantError) {
                    if (kDebugMode) {
                      print("pesan" + listState.message);
                    }
                    return NoInternetPage(message: listState.message);
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
                  }
                  return SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.height,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              'Loading',
                              style: GoogleFonts.poppins(
                                  fontSize: 20, color: Colors.white),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }),
              ],
            )),
          )
        ],
      ),
    );
  }
}
