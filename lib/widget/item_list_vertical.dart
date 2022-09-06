import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurant_app/core/common/constants.dart';
import 'package:restaurant_app/core/domain/entities/restaurant.dart';

class ItemListVertical extends StatelessWidget {
  final Restaurant resto;
  final List<Restaurant> restaurant;
  final Function onTap;

  const ItemListVertical(this.resto, this.restaurant,
      {Key? key, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Card(
        color: const Color(0xFF252525),
        margin: EdgeInsets.fromLTRB(
            16, 12, 16, (resto == restaurant.last) ? 12 : 0),
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
                          image: NetworkImage('$baseUrl/images/medium/${resto.pictId}'),
                          fit: BoxFit.cover)),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        width: 100,
                        margin: const EdgeInsets.only(top: 16),
                        child: Text(
                          resto.name,
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
                            resto.city,
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
                                    (index < resto.rate.round())
                                        ? Icons.star
                                        : Icons.star_outline,
                                    size: 16,
                                    color: Colors.amber,
                                  )) +
                          [
                            const SizedBox(width: 4),
                            Text(
                              resto.rate.toString(),
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
