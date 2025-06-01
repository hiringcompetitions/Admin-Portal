import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';

class CustomMultiSelector extends StatefulWidget {
  final List<MultiSelectItem<String>> items;
  List<String> selectedtems;
  final onConfirm;
  CustomMultiSelector({
    required this.items,
    required this.selectedtems,
    required this.onConfirm,
    super.key
  });

  @override
  State<CustomMultiSelector> createState() => _CustomMultiSelectorState();
}

class _CustomMultiSelectorState extends State<CustomMultiSelector> {
  @override
  Widget build(BuildContext context) {

    String title = widget.selectedtems.isEmpty ? "Choose Eligibility" : widget.selectedtems.join(', ');

    return Container(
      height: 50,
      width: 320,
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Colors.grey.shade800,
        ),
        borderRadius: BorderRadius.circular(12)
      ),
      child: MultiSelectDialogField(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20)
        ),
        dialogWidth: 500,
        items: widget.items,
        title: Text("Eligibility"),
        buttonText: Text(title.length < 25 ? title : title.substring(0,25) + "...", style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Colors.grey.shade700,
                      fontWeight: FontWeight.w400
                    ),
                    maxLines: 1,),
        buttonIcon: Icon(Icons.keyboard_arrow_down_rounded),
        searchable: false,
        onConfirm: widget.onConfirm,
        listType: MultiSelectListType.CHIP,
        chipDisplay: MultiSelectChipDisplay.none(),
      ),
    );
  }
} 