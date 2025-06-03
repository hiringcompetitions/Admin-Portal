import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constants/custom_colors.dart';

class TopPicksCard extends StatelessWidget {
  final String title;
  final String companyName;
  final List<dynamic> eligibility;
  final Color color; 
  const TopPicksCard({
    required this.title,
    required this.companyName,
    required this.eligibility,
    required this.color,
    super.key
  });

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
                color: color, borderRadius: BorderRadius.circular(12)),
            child: Text(
              companyName.substring(0, 1).toUpperCase(),
              style: GoogleFonts.poppins(color: Colors.white, fontSize: 26),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 270,
                child: Text(
                  title,
                  style: GoogleFonts.poppins(
                      fontSize: 20,
                      color: CustomColors().primaryText,
                      fontWeight: FontWeight.w600),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                "$companyName | Eligibility : ${eligibility.join(', ')}",
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
