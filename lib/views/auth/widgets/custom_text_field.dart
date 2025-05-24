import 'package:flutter/material.dart';
import 'package:hiring_competitions_admin_portal/constants/custom_colors.dart';

class CustomTextField extends StatelessWidget {
  final String title;
  final Icon icon;
  final TextEditingController controller;
  const CustomTextField({
    required this.title,
    required this.icon,
    required this.controller,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      padding: EdgeInsets.only(left : 20),
      decoration: BoxDecoration(
        color: CustomColors().background,
        borderRadius: BorderRadius.circular(20)
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: title,
          icon: icon,
          border: InputBorder.none,
        ),
      ),
    );
  }
}