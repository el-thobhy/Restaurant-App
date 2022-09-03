import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/bloc/page_bloc.dart';
import 'package:restaurant_app/ui/detail_page.dart';
import 'package:restaurant_app/ui/home_page.dart';
import 'package:restaurant_app/ui/search_page.dart';
import 'package:restaurant_app/ui/splash.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<PageBloc>().add(GoToSplashScreen());
    return BlocBuilder<PageBloc, PageState>(
        builder: (_, pageState) => (pageState is OnSplashScreen)
            ? const Splash()
            : (pageState is OnDetailPage)
                ? PageDetail(idRestaurant: pageState.idRestaurant)
                : (pageState is OnSearchPage)
                    ? SearchPage(query: pageState.query)
                    : (pageState is OnHomePage)
                        ? const HomePage()
                        : const CircularProgressIndicator());
  }
}
