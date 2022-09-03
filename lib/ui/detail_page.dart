import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurant_app/bloc/detail_bloc.dart';
import 'package:restaurant_app/bloc/page_bloc.dart';
import 'package:restaurant_app/services/api_services.dart';
import 'package:restaurant_app/widget/no_internet.dart';

class PageDetail extends StatefulWidget {
  final String idRestaurant;

  const PageDetail({Key? key, required this.idRestaurant}) : super(key: key);

  @override
  State<PageDetail> createState() => _PageDetailState();
}

class _PageDetailState extends State<PageDetail> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.read<PageBloc>().add(const GoToHomePage());
        return false;
      },
      child: Scaffold(
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
              child: BlocProvider(
                create: (_) =>
                    DetailBloc()..add(GetDetail(id: widget.idRestaurant)),
                child: BlocBuilder<DetailBloc, DetailState>(
                  builder: (_, detailList) {
                    if (detailList is DetailLoaded) {
                      return Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 20, left: 16),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: GestureDetector(
                                  onTap: () {
                                    context
                                        .read<PageBloc>()
                                        .add(const GoToHomePage());
                                  },
                                  child: Container(
                                      height: 30,
                                      width: 30,
                                      padding: const EdgeInsets.all(3),
                                      decoration: BoxDecoration(
                                        color: Colors.black54,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: const Icon(Icons.arrow_back,
                                          color: Colors.white))),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Hero(
                                tag: detailList.detail.id,
                                child: Container(
                                  width: double.infinity,
                                  height: 300,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              ApiServices.baseUrlImage +
                                                  'medium/' +
                                                  detailList.detail.pictId),
                                          fit: BoxFit.cover)),
                                )),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(top: 10),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      detailList.detail.name,
                                      style: GoogleFonts.poppins(
                                          fontSize: 24, color: Colors.white),
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
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: const Color(0xFF304FFE)),
                                          child: Text(
                                            detailList.detail.city,
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.poppins(
                                                fontSize: 14,
                                                color: Colors.white),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Container(
                                          width: 120,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: const Color(0x19304FFE),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: List<Widget>.generate(
                                                    5,
                                                    (index) => Icon(
                                                          (index <
                                                                  detailList
                                                                      .detail
                                                                      .rate
                                                                      .round())
                                                              ? Icons.star
                                                              : Icons
                                                                  .star_outline,
                                                          size: 16,
                                                          color: Colors.amber,
                                                        )) +
                                                [
                                                  const SizedBox(width: 4),
                                                  Text(
                                                    detailList.detail.rate
                                                        .toString(),
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 14,
                                                        color: Colors.white),
                                                  )
                                                ],
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(height: 20),
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 6),
                                      child: Text(
                                        'Description',
                                        style: GoogleFonts.poppins(
                                            fontSize: 15,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Text(
                                      detailList.detail.desc,
                                      style: GoogleFonts.poppins(
                                          fontSize: 14, color: Colors.white),
                                    ),
                                    const SizedBox(height: 20),
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 6),
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
                                          children: detailList.detail.menu.foods
                                              .map((e) => Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            right: 10),
                                                    width: 130,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                        color: Colors.white),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          e.name,
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: GoogleFonts
                                                              .poppins(
                                                                  fontSize: 15,
                                                                  color: Colors
                                                                      .black),
                                                          maxLines: 1,
                                                        )
                                                      ],
                                                    ),
                                                  ))
                                              .toList()),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 6),
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
                                          children: detailList
                                              .detail.menu.drinks
                                              .map((e) => Container(
                                                  margin: const EdgeInsets.only(
                                                      right: 10),
                                                  width: 130,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      color: Colors.white),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        e.name,
                                                        textAlign:
                                                            TextAlign.center,
                                                        style:
                                                            GoogleFonts.poppins(
                                                                fontSize: 15),
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
                                      children: detailList
                                          .detail.customerReviews
                                          .map((e) => Container(
                                                padding:
                                                    const EdgeInsets.all(16),
                                                margin: const EdgeInsets.only(
                                                    top: 16, bottom: 16),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            16),
                                                    color: const Color(
                                                        0xFF252525)),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          e.name,
                                                          style: GoogleFonts
                                                              .poppins(
                                                                  fontSize: 12,
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                        ),
                                                        Text(e.date,
                                                            style: GoogleFonts
                                                                .poppins(
                                                              fontSize: 12,
                                                              color:
                                                                  Colors.white,
                                                            ))
                                                      ],
                                                    ),
                                                    Container(
                                                      margin: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 10),
                                                      child: Text(
                                                        '"' + e.review + '"',
                                                        style:
                                                            GoogleFonts.poppins(
                                                                fontSize: 12,
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w200),
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
                    } else if (detailList is DetailError) {
                      return NoInternetPage(
                        message: detailList.message,
                      );
                    }
                    if (kDebugMode) {
                      print("pesan" + detailList.toString());
                    }
                    return SizedBox(
                      height: MediaQuery.of(context).size.width,
                      width: MediaQuery.of(context).size.height,
                      child: Center(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                              Text(
                                "Load Detail",
                                style: GoogleFonts.poppins(
                                    color: Colors.white, fontSize: 20),
                              )
                            ]),
                      ),
                    );
                  },
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
