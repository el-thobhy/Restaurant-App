import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class EmptyState extends StatelessWidget {
  const EmptyState({Key? key}) : super(key: key);

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
              "Empty",
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 16.0,
              ),
            ),
            const SizedBox(
              height: 16.0,
            ),
            Lottie.asset(
              'assets/empty_state.json',
              height: 200,
              repeat: true,
            ),
          ],
        ),
      ),
    );
  }
}
