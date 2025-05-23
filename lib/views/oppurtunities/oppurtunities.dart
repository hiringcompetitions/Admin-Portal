import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hiring_competitions_admin_portal/constants/custom_colors.dart';
import 'package:hiring_competitions_admin_portal/views/oppurtunities/add_opportunity_card.dart';

class Oppurtunities extends StatefulWidget {
  const Oppurtunities({super.key});

  @override
  State<Oppurtunities> createState() => _OppurtunitiesState();
}

class _OppurtunitiesState extends State<Oppurtunities> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors().background,
      body: Padding(
        padding: const EdgeInsets.only(top: 20.0, left: 28, right: 28),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Opportunities",
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: CustomColors().primaryText,
                      )),

                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () {
                        showDialog(context: context, builder: (context) => AlertDialog(
                          content: AddOpportunityCard(),
                        ));
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        decoration: BoxDecoration(
                          color: CustomColors().primary,
                          borderRadius: BorderRadius.circular(12)
                        ),
                        child: Row(
                          spacing: 12,
                          children: [
                            Icon(Icons.add, color: Colors.white,),
                            Text("Add Opportunity", style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.w500
                            ),),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
