import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:slide_digital_clock/slide_digital_clock.dart';

class DigiClock extends StatelessWidget {
  const DigiClock({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DigitalClock(
            showSecondsDigit: false,
            hourMinuteDigitTextStyle:
                GoogleFonts.gemunuLibre(fontSize: 60, color: Colors.white),
            colon: const Text(":",
                style: TextStyle(color: Colors.white, fontSize: 55)),
            secondDigitTextStyle: GoogleFonts.gemunuLibre(fontSize: 60, color: Colors.white)
          )
        ],
      ),
    );
  }
}
