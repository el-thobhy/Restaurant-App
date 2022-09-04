import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurant_app/bloc/page_bloc.dart';
import 'package:restaurant_app/bloc/search_bloc.dart';
import 'package:restaurant_app/models/search_restaurant.dart';
import 'package:restaurant_app/ui/detail_page.dart';
import 'package:restaurant_app/widget/item_list_search.dart';
import 'package:restaurant_app/widget/no_internet.dart';

class SearchPage extends StatefulWidget {
  static const routeName = '/search-page';
  final String query;

  const SearchPage({Key? key, this.query = ""}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController cari = TextEditingController();

  @override
  void initState() {
    super.initState();
    cari.text = widget.query;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.read<PageBloc>().add(const GoToHomePage());
        return false;
      },
      child: BlocProvider(
        create: (_) =>
            SearchBloc()..add(SearchRestaurantName(query: widget.query)),
        child: Scaffold(
          body: Stack(
            children: [
              Container(
                color: Colors.black45,
              ),
              SafeArea(
                  child: Container(
                color: Colors.black,
              )),
              SafeArea(
                child: ListView(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                      margin: const EdgeInsets.only(left: 16),
                                      width: 30,
                                      padding: const EdgeInsets.all(3),
                                      decoration: BoxDecoration(
                                        color: Colors.black54,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: const Icon(Icons.arrow_back,
                                          color: Colors.white))),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                margin: const EdgeInsets.only(
                                    left: 16, top: 16, bottom: 16),
                                child: Text(
                                  'Search Result',
                                  style: GoogleFonts.poppins(
                                      fontSize: 20, color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                        BlocBuilder<SearchBloc, SearchState>(
                            builder: (context, restoListState) {
                          if (restoListState is SearchLoaded) {
                            List<SearchResult> restoList =
                                restoListState.result;
                            if (restoList.isEmpty) {
                              return SizedBox(
                                width: MediaQuery.of(context).size.height,
                                height: MediaQuery.of(context).size.height,
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Not Found',
                                        style: GoogleFonts.poppins(
                                            fontSize: 20, color: Colors.white),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            } else {
                              return Column(
                                children: restoList
                                    .map((e) => ItemListSearch(
                                          e,
                                          restoList,
                                          onTap: () {
                                            Navigator.pushNamed(
                                                context, PageDetail.routeName);
                                          },
                                        ))
                                    .toList(),
                              );
                            }
                          } else if (restoListState is SearchError) {
                            return NoInternetPage(
                              message: restoListState.message,
                            );
                          }
                          return SizedBox(
                            width: MediaQuery.of(context).size.height,
                            height: MediaQuery.of(context).size.height,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const CircularProgressIndicator(),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 16.0),
                                    child: Text(
                                      'Load Data',
                                      style: GoogleFonts.poppins(
                                          fontSize: 20, color: Colors.white),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        }),
                        const SizedBox(
                          height: 16,
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
