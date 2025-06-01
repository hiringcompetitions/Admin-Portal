import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hiring_competitions_admin_portal/backend/providers/firestore_provider.dart';
import 'package:hiring_competitions_admin_portal/constants/custom_colors.dart';
import 'package:hiring_competitions_admin_portal/constants/custom_error.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:provider/provider.dart';

class AdminUsersTable extends StatefulWidget {
  const AdminUsersTable({Key? key}) : super(key: key);

  @override
  AdminUsersTableState createState() => AdminUsersTableState();
}

class AdminUsersTableState extends State<AdminUsersTable> {
  PlutoGridStateManager? stateManager;

  void reloadState() {
    setState(() {
      // rebuild
    });
  }

  List<PlutoRow> get visibleRows => stateManager?.refRows.toList() ?? [];

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FirestoreProvider>(context);
    final outercontext = context;

    final List<PlutoColumn> columns = <PlutoColumn>[
      PlutoColumn(
        title: 'Name',
        field: 'name',
        type: PlutoColumnType.text(),
        readOnly: true,
      ),
      PlutoColumn(
        title: 'Email',
        field: 'email',
        type: PlutoColumnType.text(),
        readOnly: true,
      ),
      PlutoColumn(
        title: 'Status',
        field: 'pending',
        type: PlutoColumnType.text(),
        readOnly: true,
      ),
      PlutoColumn(
        title: 'Action',
        field: 'action',
        type: PlutoColumnType.text(),
        renderer: (PlutoColumnRendererContext context) {
          final status = context.row.cells['pending']?.value;
          final email = context.row.cells['email']?.value;

          return status == 'Pending'
          ? Row(
            spacing: 10,
            children: [
              RowButton(provider, email, "Approve", "Approved",Colors.green,const Color.fromARGB(255, 235, 255, 236), outercontext),
              RowButton(provider, email, "Reject", "Rejected",Colors.red,Colors.red.shade100, outercontext),
            ],
          ) : status == 'Approved' ? 
          Row(
            spacing: 10,
            children: [
              RowButton(provider, email, "Make Admin", "Admin",Colors.green,const Color.fromARGB(255, 235, 255, 236), outercontext),
              RowButton(provider, email, "Remove", "Removed",Colors.red,Colors.red.shade100, outercontext),
            ],
          ) : status == 'Admin' 
          ? Row(
            spacing: 10,
            children: [
              RowButton(provider, email, "Make User", "Approved",Colors.green,const Color.fromARGB(255, 235, 255, 236), outercontext),
              RowButton(provider, email, "Remove", "Removed",Colors.red,Colors.red.shade100, outercontext),
            ],
          ) : Row(children: [],);
        },
      ),
    ];

    return StreamBuilder(
        stream: provider.getAdminUsers(),
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
              final status = doc['status'];

              return PlutoRow(cells: {
                'name': PlutoCell(value: doc['name']),
                'email': PlutoCell(value: doc['email']),
                'action': PlutoCell(value: ''),
                'pending': PlutoCell(value: status),
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

  Widget RowButton(FirestoreProvider provider, String email, String title, String updateStatus, Color color, Color background, BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () async {
          final res = await provider.updateStatus(email, updateStatus);
          if (res != null) {
            CustomError("error").showToast(context, res);
          } else {
            var msg = '';
            switch(updateStatus) {
              case 'Approved' : msg = 'Request Accepted';
                                break;
              case 'Rejected' : msg = 'Rejected the Request';
                                break;
              case 'Admin' : msg = 'Successfully made the user as Admin';
                                break;
              case 'Removed' : msg = 'Successfully Removed the user';
                                break;
              default : msg = 'Execution Success';
            }
            CustomError("success").showToast(context, msg);
            reloadState();
          }
        },
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
          decoration: BoxDecoration(
              color: background,
              borderRadius: BorderRadius.circular(50)),
          child: Text(
            title,
            style: GoogleFonts.poppins(fontSize: 14, color: color),
          ),
        ),
      ),
    );
  }
}
