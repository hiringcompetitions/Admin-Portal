import 'package:flutter/material.dart';

class CustomDropdown extends StatefulWidget {
  final List<DropdownMenuItem> items;
  final onChanged;
  String? selectedValue;
  CustomDropdown({
    required this.items,
    required this.selectedValue,
    required this.onChanged,
    super.key
  });

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 320,
      padding: EdgeInsets.symmetric(horizontal: 10),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: Colors.grey.shade700,
          ),
          borderRadius: BorderRadius.circular(12)),
      child: DropdownButton(
        dropdownColor: Colors.white,
        items: widget.items,
        hint: Text("Select Category"),
        icon: Icon(
          Icons.keyboard_arrow_down_outlined,
          size: 18,
        ),
        value: widget.selectedValue,
        onChanged: widget.onChanged,
        isExpanded: true,
        underline: Container(),
      ),
    );
  }
}
