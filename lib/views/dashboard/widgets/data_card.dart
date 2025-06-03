import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hiring_competitions_admin_portal/constants/custom_colors.dart';

class DataCard extends StatelessWidget {
  final Color mainColor;
  final Color? secondaryColor;
  final Color? backgroundColor;
  final String title;
  final int count;
  const DataCard({  
    required this.mainColor,
    required this.secondaryColor,
    required this.backgroundColor,
    required this.title,
    required this.count,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right : 8.0),
      child: Container(
          padding: EdgeInsets.symmetric(vertical: 20,),
          width: 229,
          decoration: BoxDecoration(
            color: backgroundColor, 
            borderRadius: BorderRadius.circular(10)
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              
              // Side Decor
              Container(
                height: 38,
                width: 4,
                decoration: BoxDecoration(
                    color: mainColor,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(5),
                        bottomRight: Radius.circular(5))),
              ),
      
              // Icon
      
              Container(
                decoration: BoxDecoration(
                    color: secondaryColor,
                    borderRadius: BorderRadius.circular(10)),
                padding: EdgeInsets.all(10),
                child: Icon(
                  Icons.group_outlined,
                  size: 24,
                  color: mainColor,
                ),
              ),
      
              // Stats
      
              Padding(
                padding: const EdgeInsets.only(right: 26.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  spacing: 5,
                  children: [
                    Row(
                      children: [
                        Text(
                          title,
                          style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: CustomColors().primaryText,
                              fontWeight: FontWeight.w400),
                        ),

                        Icon(Icons.more_vert_outlined, size: 18,),
                      ],
                    ),
                    Text(
                      count.toString(),
                      style: GoogleFonts.poppins(
                          fontSize: 28,
                          color: CustomColors().primaryText,
                          fontWeight: FontWeight.w600),
                    )
                  ],
                ),
              )
            ],
          )),
    );
  }
}
