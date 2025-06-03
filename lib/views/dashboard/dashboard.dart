import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hiring_competitions_admin_portal/backend/providers/firestore_provider.dart';
import 'package:hiring_competitions_admin_portal/constants/custom_colors.dart';
import 'package:hiring_competitions_admin_portal/constants/custom_error.dart';
import 'package:hiring_competitions_admin_portal/views/auth/widgets/custom_text_field.dart';
import 'package:hiring_competitions_admin_portal/views/dashboard/widgets/chart.dart';
import 'package:hiring_competitions_admin_portal/views/dashboard/widgets/data_card.dart';
import 'package:hiring_competitions_admin_portal/views/dashboard/widgets/top_picks_card.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class Dashboard extends StatefulWidget {
  TextEditingController _batchController = TextEditingController();
  Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  List<List<Color>> colors = [
    [Colors.purple, Colors.purple[100]!, Colors.purple[50]!],
    [Colors.orange, Colors.orange[100]!, Colors.orange[50]!],
    [Colors.green, Colors.green[100]!, Colors.green[50]!],
    [Colors.blue, Colors.blue[100]!, Colors.blue[50]!],
    [Colors.greenAccent],
    [Colors.pink],
  ];

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<FirestoreProvider>(context, listen: false);
    provider.updateOpportunityStatus();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FirestoreProvider>(context, listen: false);
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

                        // Container(
                        //   padding:
                        //       EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                        //   decoration: BoxDecoration(
                        //       color: CustomColors().background,
                        //       borderRadius: BorderRadius.circular(12)),
                        //   child: Row(
                        //     children: [
                        //       Text(
                        //         "Select Branch",
                        //         style: GoogleFonts.poppins(
                        //           fontSize: 14,
                        //           fontWeight: FontWeight.w500,
                        //           color: CustomColors().primaryText,
                        //         ),
                        //       ),
                        //       Icon(
                        //         Icons.keyboard_arrow_down_rounded,
                        //         color: CustomColors().primaryText,
                        //       )
                        //     ],
                        //   ),
                        // ),
                      ],
                    ),

                    // Data Containers

                    SizedBox(
                      height: 105,
                      child: StreamBuilder(
                        stream: provider.getBatches(),
                        builder: (context, batchSnapshot) {
                          List<Widget> cards = [];

                          // Add total students card
                          cards.add(
                            StreamBuilder(
                              stream: provider.getUsers(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return DataCard(
                                    title: "Total Students",
                                    count: 0,
                                    mainColor: Colors.red,
                                    secondaryColor: Colors.red[100],
                                    backgroundColor: Colors.red[50],
                                  );
                                }

                                return DataCard(
                                  title: "Total Students",
                                  count: snapshot.data?.docs.length ?? 0,
                                  mainColor: Colors.red,
                                  secondaryColor: Colors.red[100],
                                  backgroundColor: Colors.red[50],
                                );
                              },
                            ),
                          );

                          // Add batch cards
                          if (batchSnapshot.hasData) {
                            final docs = batchSnapshot.data!.docs;

                            for (int i = 0; i < docs.length; i++) {
                              final doc = docs[i];
                              final batch = doc["batch"];

                              cards.add(
                                StreamBuilder(
                                  stream: provider
                                      .getUsersByBatch(batch.toString()),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return DataCard(
                                        title: "$batch Batch",
                                        count: 0,
                                        mainColor: colors[i % 4][0],
                                        secondaryColor: colors[i % 4][1],
                                        backgroundColor: colors[i % 4][2],
                                      );
                                    }

                                    return DataCard(
                                      title: "$batch Batch",
                                      count: snapshot.data?.docs.length ?? 0,
                                      mainColor: colors[i % 4][0],
                                      secondaryColor: colors[i % 4][1],
                                      backgroundColor: colors[i % 4][2],
                                    );
                                  },
                                ),
                              );
                            }
                          }

                          cards.add(
                            MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: GestureDetector(
                                onTap: () {
                                  showDialog(
                                    context: context, 
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Text("Add New Batch", style: GoogleFonts.poppins(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                          color: CustomColors().primaryText,
                                        )),
                                        content: CustomTextField(
                                          title: "Eg. 2026", 
                                          icon: Icon(Icons.school_outlined), 
                                          controller: widget._batchController
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            }, 
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.grey.shade200,
                                            ),
                                            child: Text("Cancel", style: GoogleFonts.poppins(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: CustomColors().primaryText,
                                            )),
                                          ),
                                          TextButton(
                                            onPressed: () async {
                                              int? batch = int.tryParse(widget._batchController.text);
                                              if(batch == null) {
                                                CustomError("error").showToast(context, "Invalid batch number");
                                                return;
                                              }
                                              final res = await provider.addNewBatch(batch);
                                              if(res == null) {
                                                CustomError("success").showToast(context, "Batch added successfully");
                                                Navigator.pop(context);
                                              } else {
                                                CustomError("error").showToast(context, res);
                                                Navigator.pop(context);
                                              }
                                            }, 
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: CustomColors().primary
                                            ),
                                            child: Text("Add", style: GoogleFonts.poppins(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.white,
                                            )),
                                          ),
                                        ],
                                      );
                                    }
                                  );
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  width: 155,
                                  decoration: BoxDecoration(
                                    color: CustomColors().background,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Column(
                                    spacing: 10,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("Add New Batch",
                                          style: GoogleFonts.poppins(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: CustomColors().primaryText,
                                          )),
                                      Icon(Icons.add_circle_outline_rounded,
                                          color: CustomColors().primaryText,
                                          size: 30),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          );

                          return ListView(
                            scrollDirection: Axis.horizontal,
                            children: cards,
                          );
                        },
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
                        Text("Opportunities Trend",
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: CustomColors().primaryText,
                            )),
                        SizedBox(
                          height: 40,
                        ),
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

                              Text("Top Picks",
                                  style: GoogleFonts.poppins(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: CustomColors().primaryText,
                                  )),
                              SizedBox(
                                height: 26,
                              ),

                              // Top Picks

                              StreamBuilder(
                                        stream: provider.getTopPicks(),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return TopPicksCard(
                                              title: "Loading...",
                                              companyName: "Loading...",
                                              eligibility: ["Loading..."],
                                              color: Colors.grey.shade200,
                                            );
                                          }

                                          if (!snapshot.hasData ||
                                              snapshot.data!.docs.isEmpty) {
                                            return TopPicksCard(
                                              title: "No Data",
                                              companyName: "",
                                              eligibility: [""],
                                              color: Colors.grey.shade300,
                                            );
                                          }

                                          final data = snapshot.data;

                                          return SizedBox(
                                              height: 342,
                                              child: ListView.builder(
                                                itemCount: data!.docs.length < 10 ? data.docs.length : 10,
                                                itemBuilder: (context, index) {
                                                  final data = snapshot.data!.docs[index];
                                                  return TopPicksCard(
                                                    title: data['title'],
                                                    companyName: data['organization'],
                                                    eligibility: data['eligibility'],
                                                    color: colors[index % 6][0],
                                                  );
                                                },
                                              )
                                          );
                                          },
                                      ),
                            ],
                          ))),
                ],
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
