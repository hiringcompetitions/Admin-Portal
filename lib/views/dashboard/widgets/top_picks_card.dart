import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constants/custom_colors.dart';

class TopPicksCard extends StatelessWidget {
  const TopPicksCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        spacing: 16,
        children: [
          Container(
            alignment: Alignment.center,
            height: 50,
            width: 50,
            decoration: BoxDecoration(
                color: Colors.purple, borderRadius: BorderRadius.circular(12)),
            child: Text(
              "G",
              style: GoogleFonts.poppins(color: Colors.white, fontSize: 26),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Generative AI Hackathon",
                style: GoogleFonts.poppins(
                    fontSize: 20,
                    color: CustomColors().primaryText,
                    fontWeight: FontWeight.w600),
              ),
              Text(
                "Google | Eligibility : 24, 25, 26",
                style: GoogleFonts.poppins(
                    fontSize: 14, color: CustomColors().secondaryText),
              )
            ],
          )
        ],
      ),
    );
  }
}
