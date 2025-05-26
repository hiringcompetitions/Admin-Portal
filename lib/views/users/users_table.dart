import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hiring_competitions_admin_portal/backend/providers/firestore_provider.dart';
import 'package:hiring_competitions_admin_portal/constants/custom_colors.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:provider/provider.dart';

class UsersTable extends StatefulWidget {
  const UsersTable({Key? key}) : super(key: key);

  @override
  UsersTableState createState() => UsersTableState();
}

class UsersTableState extends State<UsersTable> {

  PlutoGridStateManager? stateManager;
  
  List<PlutoRow> get visibleRows => stateManager?.refRows.toList() ?? [];

  final List<PlutoColumn> columns = <PlutoColumn>[
    PlutoColumn(
      title: 'Roll No',
      field: 'rollno',
      type: PlutoColumnType.text(),
      readOnly: true,
    ),
    PlutoColumn(
      title: 'Name',
      field: 'name',
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
      title: 'Batch',
      field: 'batch',
      type: PlutoColumnType.text(),
      readOnly: true,
    ),
    PlutoColumn(
      title: 'Email',
      field: 'email',
      type: PlutoColumnType.text(),
      readOnly: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FirestoreProvider>(context);

    return StreamBuilder(
        stream: provider.getUsers(),
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
                'rollno': PlutoCell(value: doc['rollNo']),
                'name': PlutoCell(value: doc['name']),
                'branch': PlutoCell(value: doc['branch']),
                'batch': PlutoCell(value: doc['passedOutYear']),
                'email': PlutoCell(value: doc['email']),
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
                    autoSizeMode: PlutoAutoSizeMode.equal,
                    resizeMode: PlutoResizeMode.normal,
                  ),
                  style: PlutoGridStyleConfig(
                    defaultCellPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 28),
                    defaultColumnTitlePadding: EdgeInsets.symmetric(vertical: 12, horizontal: 28),
                    gridBorderColor: Colors.white,
                    gridBackgroundColor: Colors.white,
                    rowColor: Colors.white,
                    activatedColor: CustomColors().background,
                    cellTextStyle: GoogleFonts.poppins(
                      fontSize: 14,
                      color: CustomColors().primaryText,
                      fontWeight: FontWeight.w500
                    ),
                    columnFilterHeight: 55,
                    defaultColumnFilterPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                    columnTextStyle: GoogleFonts.poppins(
                      fontSize: 16,
                      color: CustomColors().primaryText,
                      fontWeight: FontWeight.w600
                    ),
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
}
