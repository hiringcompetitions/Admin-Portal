import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hiring_competitions_admin_portal/backend/providers/offer_provider.dart';
import 'package:hiring_competitions_admin_portal/constants/custom_colors.dart';
import 'package:hiring_competitions_admin_portal/views/opportunities/add_opportunity_card.dart';
import 'package:provider/provider.dart';

class Users extends StatefulWidget {
  const Users({super.key});

  @override
  State<Users> createState() => _UsersState();
}

class _UsersState extends State<Users> {

  final items = ['Select','2021-2025', '2022-2026', '2023-2027', '2024-2028'];

  @override
  Widget build(BuildContext context) {
    final provider=Provider.of<OfferProvider>(context);
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
                  Row(
                    spacing: 12,
                    children: [

                      // Choose batch

                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: () {
                            // Download Data
                          },
                          child: Container(
                            padding:
                                EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12)),
                            child: Row(
                              spacing: 12,
                              children: [
                                Text(
                                  "Select Batch",
                                  style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      color: CustomColors().primaryText,
                                      fontWeight: FontWeight.w500),
                                ),
                                Icon(
                                  Icons.keyboard_arrow_down_outlined,
                                  color: CustomColors().primaryText,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                     SizedBox(
                          width: 250,
                          child: DropdownButtonFormField<String>(
                            value: provider.selectedCategory.isNotEmpty? provider.selectedCategory: null,
                            decoration: InputDecoration(
                              isDense: true,
                              hintText: "Select category",
                              filled: true,
                              fillColor: Colors.grey[100],
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 14),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide:
                                    BorderSide(color: Colors.grey.shade300),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide:
                                    BorderSide(color: Colors.grey.shade400),
                              ),
                            ),
                            icon: Icon(Icons.keyboard_arrow_down_outlined),
                            dropdownColor: Colors.white,
                            items: items.map((item) {
                              return DropdownMenuItem(
                                value: item,
                                child: Text(item,
                                    style: GoogleFonts.poppins(fontSize: 14)),
                              );
                            }).toList(),
                            onChanged: (value) {
                              if (value != null) {
                                provider.setCategory(value);
                              }
                            },
                          ),
                        ),
                      

                      // Choose Branch

                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: () {
                            // Download Data
                          },
                          child: Container(
                            padding:
                                EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12)),
                            child: Row(
                              spacing: 12,
                              children: [
                                Text(
                                  "Select Branch",
                                  style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      color: CustomColors().primaryText,
                                      fontWeight: FontWeight.w500),
                                ),
                                Icon(
                                  Icons.keyboard_arrow_down_outlined,
                                  color: CustomColors().primaryText,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      // Download Data

                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: () {
                            // Download Data
                          },
                          child: Container(
                            padding:
                                EdgeInsets.symmetric(vertical: 8, horizontal: 16),
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
            ],
          ),
        ),
      ),
    );
  }
}
