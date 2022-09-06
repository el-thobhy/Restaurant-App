import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class ErrorState extends StatelessWidget {
  final String message;

  const ErrorState({
    Key? key,
    required this.message,
  }) : super(key: key);

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
            Lottie.asset(
              'assets/internet_error_state.json',
              height: 200,
            ),
          ],
        ),
      ),
    );
  }
}
