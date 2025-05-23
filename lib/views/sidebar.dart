import 'package:avatar_plus/avatar_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hiring_competitions_admin_portal/constants/custom_colors.dart';
import 'package:hiring_competitions_admin_portal/views/dashboard/dashboard.dart';
import 'package:hiring_competitions_admin_portal/views/oppurtunities/oppurtunities.dart';

class Sidebar extends StatefulWidget {
  const Sidebar({super.key});

  @override
  State<Sidebar> createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {

  int _selectedIndex = 2;

  List<Widget> pages = [
    Dashboard(),
    Center(child: Text("Users"),),
    Oppurtunities(),
    Center(child: Text("Reports"),),
    Center(child: Text("Co-ordinators"),),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: 250,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24.0),
                    child: Row(
                      children: [
                        Text(
                          "Hiring ",
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            color: CustomColors().primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "Competitions",
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            color: CustomColors().primaryText,
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 4,),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          spacing: 10,
                          children: [
                            NavElement("Dashboard", "dashboard", 0),
                            NavElement("Users", "users", 1),
                            NavElement("Opportunities", "list", 2),
                            NavElement("Reports", "reports", 3),
                            NavElement("Co-ordinators", "user", 4),
                          ],
                        ),
                        Column(
                          children: [
                            NavElement("Logout", "logout", 5),
                            SizedBox(height: 40,),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
            height: MediaQuery.of(context).size.height,
            color: CustomColors().background,
            child: Column(
              children: [

                // Header
                Container(
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                  color: Colors.white,
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      // Welcome Text
                      Row(
                        spacing: 10,
                        children: [
                          Text("Welcome", style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: CustomColors().secondaryText
                          ),),
                          Image.asset("lib/assets/hi.png", height: 20,),
                        ],
                      ),

                      // Account Name
                      Row(
                        spacing: 10,
                        children: [
                          Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle
                            ),
                            child: AvatarPlus("sandeep"),
                          ),
                          Text("Ganesh Govala", style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: CustomColors().secondaryText
                          ),),
                        ],
                      )
                    ],
                  ),
                ),

                Expanded(
                  child: Container(
                    child: pages[_selectedIndex]),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget NavElement(String name, String image, int index) {
    return GestureDetector(
      onTap: () {
        if(index < 5) {
          setState(() {
            _selectedIndex = index;
          });
        } else {
          // Logout Logic
        }
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          decoration: BoxDecoration(
              color: _selectedIndex == index ? CustomColors().primary : Colors.white, 
              borderRadius: BorderRadius.circular(12)),
          child: Row(
            spacing: 12,
            children: [
              SvgPicture.asset("lib/assets/$image.svg",
                  height: 20,
                  colorFilter: ColorFilter.mode(
                      _selectedIndex == index ? Colors.white : CustomColors().secondaryText, BlendMode.srcIn)),
              Text(
                name,
                style: GoogleFonts.commissioner(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: _selectedIndex == index ? Colors.white : CustomColors().secondaryText,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
