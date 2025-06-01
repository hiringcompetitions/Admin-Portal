import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hiring_competitions_admin_portal/constants/custom_colors.dart';
import 'package:hiring_competitions_admin_portal/views/opportunities/oppurtunity_card.dart';
import 'package:hiring_competitions_admin_portal/views/opportunities/widgets/oppurtunities_table.dart';

class Opportunities extends StatefulWidget {
  const Opportunities({super.key});

  @override
  State<Opportunities> createState() => _OpportunitiesState();
}

class _OpportunitiesState extends State<Opportunities> {

  final GlobalKey<OppurtunitiesTableState> key = GlobalKey<OppurtunitiesTableState>();

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
                      onTap: ()async {
                        await showDialog(
                          context: context,
                           builder: (context) => Dialog(
                          child: OpportunityCard(
                            title: null,
                            selectedCategory: null,
                            organizationName: null,
                            eligibility: [],
                            duration: null,
                            lastDate: null,
                            payout: null,
                            location: null,
                            eventDate: null,
                            about: null,
                            otherInfo: null,
                            buttonText: "Add Opportunity",
                            url: null,
                            isImportant: false,
                            uid: "",
                          ),
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

              SizedBox(
                height: 600,
                child: OppurtunitiesTable(key: key,)),
            ],
          ),
        ),
      ),
    );
  }
}
