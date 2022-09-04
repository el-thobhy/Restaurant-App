import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NoInternetPage extends StatelessWidget {
  final String message;

  const NoInternetPage({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.75,
      child: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                message,
                style: GoogleFonts.poppins(fontSize: 20, color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ]),
      ),
    );
  }
}
