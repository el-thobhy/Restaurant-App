import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurant_app/core/common/utils.dart';
import 'package:restaurant_app/core/domain/entities/restaurant.dart';
import 'package:restaurant_app/ui/bloc/favorite/favorite_bloc.dart';
import 'package:restaurant_app/ui/bloc/favorite/favorite_event.dart';
import 'package:restaurant_app/ui/bloc/favorite/favorite_state.dart';
import 'package:restaurant_app/ui/detail_page.dart';
import 'package:restaurant_app/widget/item_list_vertical.dart';
import 'package:restaurant_app/widget/no_internet.dart';

class FavoritePage extends StatefulWidget {
  static const routeName = '/favorite-page';

  const FavoritePage({Key? key}) : super(key: key);

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> with RouteAware {
  @override
  void initState() {
    context.read<FavoriteBloc>().add(OnFetchFavorite());
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    context.read<FavoriteBloc>().add(OnFetchFavorite());
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Restaurant'),
      ),
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
                BlocBuilder<FavoriteBloc, FavoriteState>(
                    builder: (context, listState) {
                  if (listState is FavoriteError) {
                    return NoInternetPage(message: listState.message);
                  } else if (listState is FavoriteLoaded) {
                    List<Restaurant> listRestaurant = listState.result;
                    if (listRestaurant.isEmpty) {
                      return SizedBox(
                          height: MediaQuery.of(context).size.height * 0.75,
                          child: Center(
                              child: Text(
                            'Empty',
                            style: GoogleFonts.poppins(
                                fontSize: 24, color: Colors.white),
                          )));
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
                  } else {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height * 0.75,
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
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
