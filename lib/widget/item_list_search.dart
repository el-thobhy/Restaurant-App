import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurant_app/models/search_restaurant.dart';
import 'package:restaurant_app/services/api_services.dart';

class ItemListSearch extends StatelessWidget {
  final SearchResult search;
  final List<SearchResult> list;
  final Function onTap;

  const ItemListSearch(this.search, this.list, {Key? key, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Card(
        color: const Color(0xFF252525),
        margin: EdgeInsets.fromLTRB(16, 12, 16, (search == list.last) ? 12 : 0),
        elevation: 1,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15))),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.all(16),
                  height: 100,
                  width: 150,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                      image: DecorationImage(
                          image: NetworkImage(ApiServices.baseUrlImage +
                              'medium/' +
                              search.pictId),
                          fit: BoxFit.cover)),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        width: 100,
                        margin: const EdgeInsets.only(top: 16),
                        child: Text(
                          search.name,
                          style: GoogleFonts.poppins(
                              fontSize: 14, color: Colors.white),
                        )),
                    Container(
                      margin: const EdgeInsets.only(bottom: 10, top: 10),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.pin_drop,
                            color: Colors.grey,
                          ),
                          Text(
                            search.city,
                            style: GoogleFonts.poppins(
                                fontSize: 14, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: List<Widget>.generate(
                              5,
                              (index) => Icon(
                                    (index < search.rate.round())
                                        ? Icons.star
                                        : Icons.star_outline,
                                    size: 16,
                                    color: Colors.amber,
                                  )) +
                          [
                            const SizedBox(width: 4),
                            Text(
                              search.rate.toString(),
                              style: GoogleFonts.poppins(
                                  fontSize: 14, color: Colors.white),
                            )
                          ],
                    )
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
