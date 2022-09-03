import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurant_app/bloc/page_bloc.dart';
import 'package:restaurant_app/bloc/restaurant_bloc.dart';
import 'package:restaurant_app/models/list_restaurant.dart';
import 'package:restaurant_app/widget/item_list_vertical.dart';
import 'package:restaurant_app/widget/no_internet.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  TextEditingController find = TextEditingController();

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
                            context
                                .read<PageBloc>()
                                .add(GoToSearchPage(query: find.text));
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
                    builder: (_, listState) {
                  if (listState is RestaurantLoaded) {
                    List<Restaurant> restaurantList = listState.restaurantList;
                    if (restaurantList.isEmpty) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [Text('Not Found')],
                      );
                    } else {
                      return Column(
                        children: restaurantList
                            .map((e) =>
                                ItemListVertical(e, restaurantList, onTap: () {
                                  context
                                      .read<PageBloc>()
                                      .add(GoToDetailPage(idRestaurant: e.id));
                                }))
                            .toList(),
                      );
                    }
                  } else if (listState is RestaurantError) {
                    if (kDebugMode) {
                      print("pesan" + listState.message);
                    }
                    return NoInternetPage(message: listState.message);
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
