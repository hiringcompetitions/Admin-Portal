import 'dart:convert';
import 'dart:html' as html;

import 'package:csv/csv.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hiring_competitions_admin_portal/constants/custom_colors.dart';
import 'package:hiring_competitions_admin_portal/constants/custom_error.dart';
import 'package:hiring_competitions_admin_portal/views/adminUsers/widgets/admin_users_table.dart';
import 'package:hiring_competitions_admin_portal/views/users/users_table.dart';

class AdminUsers extends StatelessWidget {
  const AdminUsers({super.key});

  @override
  Widget build(BuildContext context) {

    final GlobalKey<AdminUsersTableState> usersTableKey = GlobalKey<AdminUsersTableState>(); 

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
                  Text("Admin Users",
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: CustomColors().primaryText,
                      )),
                  Row(
                    spacing: 12,
                    children: [

                      // Download Data

                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: () {
                            final filteredRows = usersTableKey.currentState?.visibleRows;

                            if(filteredRows == null || filteredRows.isEmpty) {
                              CustomError("error").showToast(context, "No Data to download");
                              return;
                            }

                            final headers = ['Roll No', 'Name', 'Branch', 'Batch', 'Email'];
                            final csvRows = [
                              headers,
                              ...filteredRows.map((row) => [
                                row.cells['rollno']?.value,
                                row.cells['name']?.value,
                                row.cells['branch']?.value,
                                row.cells['batch']?.value,
                                row.cells['email']?.value,
                              ])
                            ];

                            final csvString = ListToCsvConverter().convert(csvRows);

                            if(kIsWeb) {
                              final bytes = utf8.encode(csvString);
                              final blob = html.Blob([bytes]);
                              final url = html.Url.createObjectUrlFromBlob(blob);
                              final anchor = html.AnchorElement(href: url)
                              ..setAttribute("download", "users.csv")
                              ..click();
                              html.Url.revokeObjectUrl(url);
                            }
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

              SizedBox(
                height: 600,
                child: AdminUsersTable(key: usersTableKey,)),
            ],
          ),
        ),
      ),
    );
  }
}