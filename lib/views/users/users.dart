import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hiring_competitions_admin_portal/backend/providers/category_provider.dart';
import 'package:hiring_competitions_admin_portal/constants/custom_colors.dart';
import 'package:hiring_competitions_admin_portal/views/oppurtunities/add_opportunity_card.dart';
import 'package:provider/provider.dart';

class Users extends StatefulWidget {
  const Users({super.key});

  @override
  State<Users> createState() => _UsersState();
}

class _UsersState extends State<Users> {
  final batches = ['2021-2025', '2022-2026', '2023-2027', '2024-2028'];
  final branches = [
    'CSE',
    'AIML',
    'AIDS',
    'CSBS',
    'IT',
    'ECE',
    'EEE',
    'MECH',
    'CIVIL'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors().background,
      body: Padding(
        padding: const EdgeInsets.only(top: 19.0, left: 28, right: 28),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Users",
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: CustomColors().primaryText,
                      )),
                  Row(
                    spacing: 12,
                    children: [
                      // Choose batch

                      Consumer<DropdownProvider>(
                        builder: (context, dropdownProvider, _) {
                          return SizedBox(
                            width: 200,
                            child: DropdownButtonFormField<String>(
                              value: dropdownProvider.selectedBatch,
                              decoration: InputDecoration(
                                isDense: true,
                                hintText: "Select Batch",
                                hintStyle: GoogleFonts.poppins(
                                    color: CustomColors().primaryText,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 14),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                              ),
                              icon: Icon(Icons.keyboard_arrow_down_outlined),
                              dropdownColor: Colors.white,
                              items: batches.map((item) {
                                return DropdownMenuItem(
                                  value: item,
                                  child: Text(item,
                                      style: GoogleFonts.poppins(fontSize: 14)),
                                );
                              }).toList(),
                              onChanged: (value) {
                                if (value != null) {
                                  dropdownProvider.setBatch(value);
                                }
                              },
                            ),
                          );
                        },
                      ),

                      // Choose Branch

                      Consumer<DropdownProvider>(
                        builder: (context, dropdownProvider, _) {
                          return SizedBox(
                            width: 200,
                            child: DropdownButtonFormField<String>(
                              value: dropdownProvider.selectedranch,
                              decoration: InputDecoration(
                                isDense: true,
                                hintText: "Select Branch",
                                hintStyle: GoogleFonts.poppins(
                                    color: CustomColors().primaryText,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 14),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                              ),
                              icon: Icon(Icons.keyboard_arrow_down_outlined),
                              dropdownColor: Colors.white,
                              items: branches.map((item) {
                                return DropdownMenuItem(
                                  value: item,
                                  child: Text(item,
                                      style: GoogleFonts.poppins(fontSize: 14)),
                                );
                              }).toList(),
                              onChanged: (value) {
                                if (value != null) {
                                  dropdownProvider.setBranch(value);
                                }
                              },
                            ),
                          );
                        },
                      ),

                      // Download Data

                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: () {
                            // Download Data
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 8, horizontal: 16),
                            decoration: BoxDecoration(
                                color: CustomColors().primary,
                                borderRadius: BorderRadius.circular(12)),
                            child: Row(
                              spacing: 12,
                              children: [
                                Icon(
                                  Icons.file_download,
                                  color: Colors.white,
                                ),
                                Text(
                                  "Download Data",
                                  style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),

              DataTable(
                columns: const [
                  DataColumn(label: Text('Name')),
                  DataColumn(label: Text('Age')),
                ],
                rows: const [
                  DataRow(cells: [
                    DataCell(Text('Ganesh')),
                    DataCell(Text('21')),
                  ]),
                  DataRow(cells: [
                    DataCell(Text('Sandeep')),
                    DataCell(Text('22')),
                  ]),
                ],
              )

            ],
          ),
        ),
      ),
    );
  }
}
