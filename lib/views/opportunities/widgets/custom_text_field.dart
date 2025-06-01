import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextBar extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final double width;
  CustomTextBar({
    required this.hintText,
    required this.controller,
    required this.width,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: width,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 12),
          hintText: hintText,
          hintStyle: GoogleFonts.poppins(
            fontSize: 16,
            color: Colors.grey.shade700,
            fontWeight: FontWeight.w500
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey.shade400,
              width: 2
            ),
            borderRadius: BorderRadius.circular(12)
          )
        ),
      ),
    );
  }
}