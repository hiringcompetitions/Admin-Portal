import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hiring_competitions_admin_portal/backend/providers/firestore_provider.dart';
import 'package:hiring_competitions_admin_portal/constants/custom_colors.dart';
import 'package:hiring_competitions_admin_portal/constants/custom_error.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:provider/provider.dart';

class ApplicantsTable extends StatefulWidget {
  final Stream stream;
  const ApplicantsTable({
    Key? key,
    required this.stream,
  }) : super(key: key);

  @override
  ApplicantsTableState createState() => ApplicantsTableState();
}

class ApplicantsTableState extends State<ApplicantsTable> {
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
    final outercontext = context;
    // ignore: unused_local_variable
    final provider = Provider.of<FirestoreProvider>(context, listen: false);

    final List<PlutoColumn> columns = <PlutoColumn>[
      PlutoColumn(
        title: 'Name',
        field: 'name',
        type: PlutoColumnType.text(),
        readOnly: true,
      ),
      PlutoColumn(
        title: 'Roll No',
        field: 'rollNo',
        type: PlutoColumnType.text(),
        readOnly: true,
      ),
      PlutoColumn(
        title: 'Branch',
        field: 'branch',
        type: PlutoColumnType.text(),
        readOnly: true,
      ),
      PlutoColumn(
        title: 'Passed Out Year',
        field: 'year',
        type: PlutoColumnType.text(),
        readOnly: true,
      ),
      PlutoColumn(
        title: 'Applied On',
        field: 'appliedOn',
        type: PlutoColumnType.text(),
        readOnly: true,
      ),
      PlutoColumn(
        title: 'Status',
        field: 'status',
        type: PlutoColumnType.text(),
        readOnly: true,
      ),
      PlutoColumn(
        title: 'Action',
        field: 'action',
        type: PlutoColumnType.text(),
        renderer: (PlutoColumnRendererContext context) {
          return Row(
            spacing: 10,
            children: [
              RowButton(
                  Icon(
                    Icons.notification_add_outlined,
                    size: 20,
                  ), () async {
              }, outercontext),
            ],
          );
        },
      ),
    ];

    return StreamBuilder(
        stream: widget.stream,
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
            final List<PlutoRow> rows = data.docs.map<PlutoRow>((doc) {
              return PlutoRow(
                cells: {
                  'name': PlutoCell(value: doc['name']),
                  'rollNo': PlutoCell(value: doc['rollNo']),
                  'branch': PlutoCell(value: doc['branch']),
                  'year': PlutoCell(value: doc['batch']),
                  'appliedOn': PlutoCell(value: doc['appliedOn'].toDate().toString()),
                  'status': PlutoCell(value: doc['status']),
                  'action': PlutoCell(value: ''),
                },
              );
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
                    autoSizeMode: PlutoAutoSizeMode.equal,
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
