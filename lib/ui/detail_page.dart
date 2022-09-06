import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurant_app/core/common/constants.dart';
import 'package:restaurant_app/core/common/state_enum.dart';
import 'package:restaurant_app/core/domain/entities/detail.dart';
import 'package:restaurant_app/ui/bloc/detail/detail_bloc.dart';
import 'package:restaurant_app/widget/no_internet.dart';

class PageDetail extends StatefulWidget {
  static const routeName = '/detail-page';
  final String idRestaurant;

  const PageDetail({Key? key, required this.idRestaurant}) : super(key: key);

  @override
  State<PageDetail> createState() => _PageDetailState();
}

class _PageDetailState extends State<PageDetail> {
  @override
  void initState() {
    Future.microtask(() {
      BlocProvider.of<DetailBloc>(context, listen: false)
          .add(OnDetailCalled(widget.idRestaurant));
      BlocProvider.of<DetailBloc>(context, listen: false)
          .add(FetchFavoriteStatus(widget.idRestaurant));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Detail'),
      ),
      body: Stack(
        children: [
          Container(
            color: Colors.black,
          ),
          SafeArea(
              child: Container(
            color: Colors.black,
          )),
          SafeArea(
              child: SingleChildScrollView(
            child: BlocConsumer<DetailBloc, DetailState>(
              listener: (context, state) async {
                if (state.favoriteMessage == bookmarkAddSourceMessage ||
                    state.favoriteMessage == bookmarkRemoveMessage) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                    state.favoriteMessage,
                    style:
                        GoogleFonts.poppins(fontSize: 16, color: Colors.white),
                  )));
                } else if (state.detailState == RequestState.error) {
                  NoInternetPage(
                    message: state.favoriteMessage,
                  );
                } else {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          content: Text(state.message),
                        );
                      });
                }
              },
              listenWhen: (previousState, currentState) =>
                  previousState.favoriteMessage !=
                      currentState.favoriteMessage &&
                  currentState.favoriteMessage != '',
              builder: (context, state) {
                if (state.detailState == RequestState.loaded) {
                  return SafeArea(
                      child: DetailContent(
                    detail: state.detail!,
                    isAddedToFavorite: state.isAddedTofavorite,
                  ));
                } else if (state.detailState == RequestState.error) {
                  return NoInternetPage(message: state.message);
                } else {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height * 0.75,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
              },
            ),
          ))
        ],
      ),
    );
  }
}

class DetailContent extends StatelessWidget {
  final bool isAddedToFavorite;
  final Detail detail;
  const DetailContent(
      {required this.detail, required this.isAddedToFavorite, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Hero(
              tag: detail.id,
              child: Container(
                width: double.infinity,
                height: 300,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                        image: NetworkImage(
                          '$baseUrl/images/medium/${detail.pictId}',
                        ),
                        fit: BoxFit.cover)),
              )),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 10),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        detail.name,
                        style: GoogleFonts.poppins(
                            fontSize: 24, color: Colors.white),
                      ),
                      IconButton(
                          onPressed: () async {
                            if (kDebugMode) {
                              print(isAddedToFavorite);
                            }
                            if (!isAddedToFavorite) {
                              BlocProvider.of<DetailBloc>(context,
                                      listen: false)
                                  .add(AddFavorite(detail));
                            } else {
                              BlocProvider.of<DetailBloc>(context,
                                      listen: false)
                                  .add(RemoveFavorite(detail));
                            }
                          },
                          icon: isAddedToFavorite
                              ? const Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                )
                              : const Icon(
                                  Icons.favorite_border_outlined,
                                  color: Colors.red,
                                ))
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.pin_drop,
                        color: Colors.red,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                        width: 100,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color(0xFF304FFE)),
                        child: Text(
                          detail.city,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                              fontSize: 14, color: Colors.white),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                        width: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color(0x19304FFE),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List<Widget>.generate(
                                  5,
                                  (index) => Icon(
                                        (index < detail.rate.round())
                                            ? Icons.star
                                            : Icons.star_outline,
                                        size: 16,
                                        color: Colors.amber,
                                      )) +
                              [
                                const SizedBox(width: 4),
                                Text(
                                  detail.rate.toString(),
                                  style: GoogleFonts.poppins(
                                      fontSize: 14, color: Colors.white),
                                )
                              ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    child: Text(
                      'Description',
                      style: GoogleFonts.poppins(
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    detail.desc,
                    style:
                        GoogleFonts.poppins(fontSize: 14, color: Colors.white),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    child: Text(
                      "Food",
                      style: GoogleFonts.poppins(
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 70,
                    width: double.infinity,
                    child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: detail.menu.foods
                            .map((e) => Container(
                                  margin: const EdgeInsets.only(right: 10),
                                  width: 130,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.white),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        e.name,
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.poppins(
                                            fontSize: 15, color: Colors.black),
                                        maxLines: 1,
                                      )
                                    ],
                                  ),
                                ))
                            .toList()),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    child: Text(
                      "Drinks",
                      style: GoogleFonts.poppins(
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 70,
                    width: double.infinity,
                    child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: detail.menu.drinks
                            .map((e) => Container(
                                margin: const EdgeInsets.only(right: 10),
                                width: 130,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      e.name,
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.poppins(fontSize: 15),
                                      maxLines: 1,
                                    )
                                  ],
                                )))
                            .toList()),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Review Customers',
                    style: GoogleFonts.poppins(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Column(
                    children: detail.customerReviews
                        .map((e) => Container(
                              padding: const EdgeInsets.all(16),
                              margin:
                                  const EdgeInsets.only(top: 16, bottom: 16),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  color: const Color(0xFF252525)),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        e.name,
                                        style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(e.date,
                                          style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            color: Colors.white,
                                          ))
                                    ],
                                  ),
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: Text(
                                      '"' + e.review + '"',
                                      style: GoogleFonts.poppins(
                                          fontSize: 12,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w200),
                                    ),
                                  )
                                ],
                              ),
                            ))
                        .toList(),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            )
          ],
        )
      ],
    );
  }
}
