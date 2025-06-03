import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hiring_competitions_admin_portal/backend/providers/firestore_provider.dart';
import 'package:hiring_competitions_admin_portal/constants/custom_colors.dart';
import 'package:hiring_competitions_admin_portal/constants/custom_error.dart';
import 'package:hiring_competitions_admin_portal/views/applicants/widgets/applicants_data.dart';
import 'package:hiring_competitions_admin_portal/views/opportunities/oppurtunity_card.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:provider/provider.dart';

class OppurtunitiesTable extends StatefulWidget {
  const OppurtunitiesTable({Key? key}) : super(key: key);

  @override
  OppurtunitiesTableState createState() => OppurtunitiesTableState();
}

class OppurtunitiesTableState extends State<OppurtunitiesTable> {
  PlutoGridStateManager? stateManager;

  void reloadState() {
    setState(() {
      // rebuild
    });
  }

  Future<dynamic> deleteConfirmation(
      BuildContext context, FirestoreProvider provider, String title) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: Colors.white,
              title: Text(
                "Are you sure about \ndeleting the Opportunity ?",
                style: GoogleFonts.poppins(
                    fontSize: 28,
                    fontWeight: FontWeight.w500,
                    color: CustomColors().primaryText),
              ),
              content: Text(
                "* This action is irriversible",
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: CustomColors().secondaryText,
                ),
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: CustomColors().primary,
                    ),
                    child: Text(
                      "Cancel",
                      style: GoogleFonts.poppins(
                          fontSize: 12, color: Colors.white),
                    )),
                TextButton(
                    onPressed: () async {
                      await provider.deleteOpportunity(title);
                      CustomError("success")
                          .showToast(context, "Opportunity Deleted");
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey.shade100,
                    ),
                    child: Text(
                      "Confirm",
                      style: GoogleFonts.poppins(
                          fontSize: 12, color: Colors.grey.shade500),
                    )),
              ],
            ));
  }

  List<PlutoRow> get visibleRows => stateManager?.refRows.toList() ?? [];

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FirestoreProvider>(context);
    final outercontext = context;

    final List<PlutoColumn> columns = <PlutoColumn>[
      PlutoColumn(
        title: 'Title',
        field: 'title',
        type: PlutoColumnType.text(),
        readOnly: true,
      ),
      PlutoColumn(
        title: 'Category',
        field: 'category',
        type: PlutoColumnType.text(),
        readOnly: true,
      ),
      PlutoColumn(
        title: 'Organization',
        field: 'company',
        type: PlutoColumnType.text(),
        readOnly: true,
      ),
      PlutoColumn(
        title: 'Eligibility',
        field: 'eligibility',
        type: PlutoColumnType.text(),
        readOnly: true,
      ),
      PlutoColumn(
        title: 'Duration',
        field: 'duration',
        type: PlutoColumnType.text(),
        readOnly: true,
      ),
      PlutoColumn(
        title: 'Last Date',
        field: 'lastDate',
        type: PlutoColumnType.text(),
        readOnly: true,
      ),
      PlutoColumn(
        title: 'Payout',
        field: 'payout',
        type: PlutoColumnType.text(),
        readOnly: true,
      ),
      PlutoColumn(
        title: 'Location',
        field: 'location',
        type: PlutoColumnType.text(),
        readOnly: true,
      ),
      PlutoColumn(
        title: 'Event Date',
        field: 'eventDate',
        type: PlutoColumnType.text(),
        readOnly: true,
      ),
      PlutoColumn(
        title: 'Url',
        field: 'url',
        type: PlutoColumnType.text(),
        readOnly: true,
      ),
      PlutoColumn(
        title: 'About',
        field: 'about',
        type: PlutoColumnType.text(),
        readOnly: true,
      ),
      PlutoColumn(
        title: 'Other Info',
        field: 'otherInfo',
        type: PlutoColumnType.text(),
        readOnly: true,
      ),
      PlutoColumn(
        title: 'Is Important',
        field: 'isImportant',
        type: PlutoColumnType.text(),
        readOnly: true,
      ),
      PlutoColumn(
        title: 'UID',
        field: 'uid',
        type: PlutoColumnType.text(),
        readOnly: true,
      ),
      PlutoColumn(
        title: 'Action',
        field: 'action',
        width: 250,
        type: PlutoColumnType.text(),
        renderer: (PlutoColumnRendererContext context) {
          final title = context.row.cells['title']?.value;
          final category = context.row.cells['category']?.value;
          final organization = context.row.cells['company']?.value;
          final eligibility = context.row.cells['eligibility']?.value;
          final duration = context.row.cells['duration']?.value;
          final lastDate = context.row.cells['lastDate']?.value;
          final payout = context.row.cells['payout']?.value;
          final location = context.row.cells['location']?.value;
          final eventDate = context.row.cells['eventDate']?.value;
          final url = context.row.cells['url']?.value;
          final about = context.row.cells['about']?.value;
          final otherInfo = context.row.cells['otherInfo']?.value;
          final isImportant = context.row.cells['isImportant']?.value;
          final uid = context.row.cells['uid']?.value;

          return Row(
            spacing: 10,
            children: [
              RowButton(
                  Icon(
                    Icons.edit,
                    size: 20,
                  ), () async {
                // Edit
                await showDialog(
                    context: outercontext,
                    builder: (context) => Dialog(
                          child: OpportunityCard(
                            title: title,
                            selectedCategory: category,
                            organizationName: organization,
                            eligibility: eligibility.split(','),
                            duration: duration,
                            lastDate: DateTime.parse(lastDate),
                            uid: uid,
                            payout: payout,
                            location: location,
                            eventDate: DateTime.parse(eventDate),
                            about: about,
                            otherInfo: otherInfo,
                            buttonText: "Update",
                            url: url,
                            isImportant: isImportant == "Yes" ? true : false,
                          ),
                        ));
              }, outercontext),
              RowButton(
                  Icon(
                    Icons.delete,
                    size: 20,
                  ), () async {
                // Delete the oppurtunity
                await deleteConfirmation(outercontext, provider, title);
                reloadState();
              }, outercontext),
              RowButton(
                  Icon(
                    Icons.groups_2,
                    size: 20,
                  ), () async {
                 final safeTitle = (title ?? '').trim().toLowerCase().replaceAll(RegExp(r'\s+'), '-');
                 final path = '/home/opportunities/${Uri.encodeComponent(safeTitle)}/applications';
                outercontext.go(
                  path,
                  extra: ApplicantsData(
                    title: title ?? '',
                    companyName: organization ?? '',
                    category: category ?? '',
                    eligibility: eligibility ?? '',
                    lastDate: lastDate ?? '',
                    status: lastDate ?? '',
                    uid: uid ?? '',
                    stream: provider.getApplicants(uid ?? ''),
                    selectedStream: provider.getSelectedCount(uid ?? ''),
                  ),
                );
              }, outercontext),
              RowButton(
                  Icon(
                    Icons.bar_chart_outlined,
                    size: 20,
                  ), () async {
                // Show Analytics
              }, outercontext),
            ],
          );
        },
      ),
    ];

    return StreamBuilder(
        stream: provider.getOpportunities(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Text("ERRROR");
          }

          final data = snapshot.data;

          if (data != null) {
            final rows = data.docs.map((doc) {
              return PlutoRow(cells: {
                'title': PlutoCell(value: doc['title']),
                'category': PlutoCell(value: doc['category']),
                'company': PlutoCell(value: doc['organization']),
                'eligibility': PlutoCell(value: doc['eligibility']),
                'duration': PlutoCell(value: doc['duration']),
                'lastDate': PlutoCell(
                  value: (doc['lastdate'] as Timestamp)
                      .toDate()
                      .toString()
                      .substring(0, 10),
                ),
                'payout': PlutoCell(value: doc['payout']),
                'location': PlutoCell(value: doc['location']),
                'eventDate': PlutoCell(
                    value: doc['eventDate'] != null
                        ? doc['eventDate'].toDate().toString().substring(0, 10)
                        : ''),
                'url': PlutoCell(value: doc['url']),
                'about': PlutoCell(value: doc['about']),
                'otherInfo': PlutoCell(value: doc['otherInfo']),
                'isImportant':
                    PlutoCell(value: doc['isTopPick'] ? "Yes" : "No"),
                'uid': PlutoCell(value: doc['uid']),
                'action': PlutoCell(value: '')
              });
            }).toList();

            return Container(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 50),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(50),
              ),
              child: PlutoGrid(
                columns: columns,
                rows: rows,
                onLoaded: (PlutoGridOnLoadedEvent event) {
                  stateManager = event.stateManager;
                  stateManager!.setShowColumnFilter(true);
                  stateManager!.setPageSize(10, notify: true);
                },
                configuration: PlutoGridConfiguration(
                  columnSize: PlutoGridColumnSizeConfig(
                    //autoSizeMode: PlutoAutoSizeMode.equal,
                    resizeMode: PlutoResizeMode.normal,
                  ),
                  style: PlutoGridStyleConfig(
                    defaultCellPadding:
                        EdgeInsets.symmetric(vertical: 12, horizontal: 28),
                    defaultColumnTitlePadding:
                        EdgeInsets.symmetric(vertical: 12, horizontal: 28),
                    gridBorderColor: Colors.white,
                    gridBackgroundColor: Colors.white,
                    rowColor: Colors.white,
                    activatedColor: CustomColors().background,
                    cellTextStyle: GoogleFonts.poppins(
                        fontSize: 14,
                        color: CustomColors().primaryText,
                        fontWeight: FontWeight.w500),
                    columnFilterHeight: 55,
                    defaultColumnFilterPadding:
                        EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                    columnTextStyle: GoogleFonts.poppins(
                        fontSize: 16,
                        color: CustomColors().primaryText,
                        fontWeight: FontWeight.w600),
                    columnHeight: 55,
                    rowHeight: 55,
                    borderColor: Colors.grey.shade300,
                    iconColor: const Color.fromARGB(255, 93, 93, 93),
                  ),
                ),
                createFooter: (stateManager) {
                  return PlutoPagination(stateManager);
                },
              ),
            );
          }

          return Container();
        });
  }

  Widget RowButton(Icon icon, GestureTapCallback onTap, BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          height: 50,
          width: 40,
          decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(150)),
          child: icon,
        ),
      ),
    );
  }
}
