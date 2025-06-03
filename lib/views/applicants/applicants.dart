import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hiring_competitions_admin_portal/constants/custom_colors.dart';
import 'package:hiring_competitions_admin_portal/views/applicants/applicants_table.dart';
import 'package:hiring_competitions_admin_portal/views/applicants/widgets/applicants_data.dart';

class Applicants extends StatefulWidget {
  final ApplicantsData data;
  const Applicants({
    required this.data,
    super.key
  });

  @override
  State<Applicants> createState() => _ApplicantsState();
}

class _ApplicantsState extends State<Applicants> {

  final GlobalKey<ApplicantsTableState> key = GlobalKey<ApplicantsTableState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

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
                spacing: 16,
                children: [
                  GestureDetector(
                    onTap: () {
                      context.pop();
                    },
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: Container(
                        alignment: Alignment.center,
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(13, 0, 0, 0),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Icon(Icons.arrow_back_ios_new,
                            color: Colors.black87, size: 18),
                      ),
                    ),
                  ),
                  Text("Applicants",
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      )),
                ],
              ),
              SizedBox(height: 20),

              // Placeholder for applicants list
              Row(
                spacing: 16,
                children: [
                  Expanded(
                    child: Container(
                      height: 150,
                        padding: const EdgeInsets.symmetric(horizontal: 32.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          spacing: 16,
                          children: [
                            Container(
                              alignment: Alignment.center,
                              height: 80,
                              width: 80,
                              decoration: BoxDecoration(
                                color: CustomColors().primary,
                                borderRadius: BorderRadius.circular(18),
                              ),
                              child: Text(
                                widget.data.companyName[0].toUpperCase(),
                                style: GoogleFonts.anton(
                                  fontSize: 48,
                                  fontWeight: FontWeight.w100,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  child: Text(widget.data.title,
                                      style: GoogleFonts.poppins(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w600,
                                        color: CustomColors().primaryText,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                ),
                                Text(widget.data.companyName,
                                    style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: CustomColors().secondaryText,
                                    )),
                              ],
                            ),
                          ],
                        )),
                  ),
                  Expanded(
                    child: Container(
                      height: 150,
                      padding: const EdgeInsets.symmetric(horizontal: 32.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: 8,
                              children: [
                                Row(
                                  children: [
                                    Text("Eligibility :  ",
                                        style: GoogleFonts.poppins(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          color: CustomColors().secondaryText,
                                        )),
                                    Text(widget.data.eligibility.join(', '),
                                        style: GoogleFonts.poppins(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                          color: CustomColors().primaryText,
                                        )),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text("Category :  ",
                                        style: GoogleFonts.poppins(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          color: CustomColors().secondaryText,
                                        )),
                                    Text(widget.data.category,
                                        style: GoogleFonts.poppins(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                          color: CustomColors().primaryText,
                                        )),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text("Last Date :  ",
                                        style: GoogleFonts.poppins(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          color: CustomColors().secondaryText,
                                        )),
                                    Text(widget.data.lastDate,
                                        style: GoogleFonts.poppins(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                          color: CustomColors().primaryText,
                                        )),
                                  ],
                                ),
                              ],
                            ),
                    )
                  ),
                  Expanded(
                    child: Container(
                      height: 150,
                      padding: const EdgeInsets.symmetric(horizontal: 32.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: 8,
                              children: [
                                Row(
                                  children: [
                                    Text("Applicants :  ",
                                        style: GoogleFonts.poppins(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          color: CustomColors().secondaryText,
                                        )),
                                    StreamBuilder(
                                      stream: widget.data.stream, 
                                      builder: (context, snapshot) {
                                        if(snapshot.connectionState == ConnectionState.waiting) {
                                          return Text("0",
                                            style: GoogleFonts.poppins(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500,
                                              color: CustomColors().primaryText,
                                            ));
                                        }

                                        final data = snapshot.data;

                                        if(data != null) {
                                          final docs = data.docs;
                                          return Text("${docs.length}",
                                            style: GoogleFonts.poppins(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500,
                                              color: CustomColors().primaryText,
                                            ));
                                        }

                                        return Text("0",
                                            style: GoogleFonts.poppins(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500,
                                              color: CustomColors().primaryText,
                                            ));
                                      })
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text("Selected :  ",
                                        style: GoogleFonts.poppins(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          color: CustomColors().secondaryText,
                                        )),
                                    StreamBuilder(
                                      stream: widget.data.selectedStream, 
                                      builder: (context, snapshot) {
                                        if(snapshot.connectionState == ConnectionState.waiting) {
                                          return Text("0",
                                            style: GoogleFonts.poppins(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500,
                                              color: CustomColors().primaryText,
                                            ));
                                        }

                                        final data = snapshot.data;

                                        if(data != null) {
                                          final docs = data.docs;
                                          return Text("${docs.length}",
                                            style: GoogleFonts.poppins(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500,
                                              color: CustomColors().primaryText,
                                            ));
                                        }

                                        return Text("0",
                                            style: GoogleFonts.poppins(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500,
                                              color: CustomColors().primaryText,
                                            ));
                                      })
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text("Current Status :  ",
                                        style: GoogleFonts.poppins(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          color: CustomColors().secondaryText,
                                        )),
                                    Text(DateTime.parse(widget.data.lastDate).isBefore(DateTime.now()) ? "Closed" : "Active",
                                        style: GoogleFonts.poppins(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.green,
                                        )),
                                  ],
                                ),
                              ],
                            ),
                    )
                  ),
                ],
              ),
              SizedBox(height: 16),
              Container(
                height: MediaQuery.of(context).size.height - 280,
                child: ApplicantsTable(
                  key: key,
                  stream: widget.data.stream,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
