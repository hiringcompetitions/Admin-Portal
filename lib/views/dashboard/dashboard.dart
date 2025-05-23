import 'package:avatar_plus/avatar_plus.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_side_menu/flutter_side_menu.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hiring_competitions_admin_portal/constants/custom_colors.dart';
import 'package:hiring_competitions_admin_portal/views/dashboard/widgets/chart.dart';
import 'package:hiring_competitions_admin_portal/views/dashboard/widgets/data_card.dart';
import 'package:hiring_competitions_admin_portal/views/dashboard/widgets/top_picks_card.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
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

              Text("Dashboard",
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: CustomColors().primaryText,
                  )),
              SizedBox(
                height: 20,
              ),

              // Quick Stats

              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 20.0, horizontal: 28),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                          color: const Color.fromARGB(5, 0, 0, 0),
                          blurRadius: 60)
                    ]),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 20,
                  children: [
                    // Title

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Title

                        Text("Students Count",
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: CustomColors().primaryText,
                            )),

                        // Select Branch Dropdown

                        Container(
                          padding:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                          decoration: BoxDecoration(
                              color: CustomColors().background,
                              borderRadius: BorderRadius.circular(12)),
                          child: Row(
                            children: [
                              Text(
                                "Select Branch",
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: CustomColors().primaryText,
                                ),
                              ),
                              Icon(
                                Icons.keyboard_arrow_down_rounded,
                                color: CustomColors().primaryText,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),

                    // Data Containers

                    SizedBox(
                      height: 105,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          DataCard(
                            title: "Total Students",
                            count: 4680,
                            mainColor: Colors.red,
                            secondaryColor: Colors.red[100],
                            backgroundColor: Colors.red[50],
                          ),
                          DataCard(
                            title: "2024 - 2028",
                            count: 1160,
                            mainColor: Colors.purpleAccent,
                            secondaryColor:
                                const Color.fromARGB(153, 233, 128, 252),
                            backgroundColor:
                                const Color.fromARGB(44, 223, 64, 251),
                          ),
                          DataCard(
                            title: "2023 - 2027",
                            count: 1260,
                            mainColor: Colors.pink,
                            secondaryColor: Colors.pink[100],
                            backgroundColor: Colors.pink[50],
                          ),
                          DataCard(
                            title: "2022 - 2026",
                            count: 980,
                            mainColor: Colors.green,
                            secondaryColor: Colors.green[100],
                            backgroundColor: Colors.green[50],
                          ),
                          DataCard(
                            title: "2021 - 2025",
                            count: 860,
                            mainColor: Colors.blue,
                            secondaryColor: Colors.blue[100],
                            backgroundColor: Colors.blue[50],
                          ),
                        ],
                      ),
                    ),
                    Container(),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),

              // Graphs and Top Picks

              Row(
                spacing: 20,
                children: [

                  // Opportunities Graph

                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(
                        top: 30, bottom: 15, left: 26, right: 30),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Opportunities Trend",
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: CustomColors().primaryText,
                          )
                        ),
                        SizedBox(height: 40,),
                        SizedBox(
                          height: 330,
                          width: 700,
                            child: Chart(),
                        ),
                      ],
                    ),
                  ),

                  // Top Picks Card

                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(
                          top: 30, bottom: 15, left: 26, right: 30),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          // Heading

                          Text(
                            "Top Picks",
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: CustomColors().primaryText,
                            )
                          ),
                          SizedBox(height: 26,),

                          // Top Picks

                          SizedBox(
                            height: 342,
                            child: ListView.builder(
                              itemCount: 10,
                              itemBuilder: (context, index) {
                                return TopPicksCard();
                              },
                            )
                          ),
                        ],
                      )
                    )
                  ),
                ],
              ),
              SizedBox(height: 30,),
            ],
          ),
        ),
      ),
    );
  }
}
