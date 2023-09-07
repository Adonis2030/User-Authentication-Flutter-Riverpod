import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Indicator extends StatelessWidget {
  const Indicator({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Container(
          width: 280,
          padding: const EdgeInsets.symmetric(vertical: 35),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                text,
                style: GoogleFonts.roboto(
                    fontSize: 17, fontWeight: FontWeight.w400),
              ),
              const SizedBox(
                height: 20,
              ),
              Image.asset(
                'assets/images/loader1.gif',
                width: 30,
                height: 30,
              ),
            ],
          )),
    );
  }
}
