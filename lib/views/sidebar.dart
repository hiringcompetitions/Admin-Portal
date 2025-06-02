import 'package:avatar_plus/avatar_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hiring_competitions_admin_portal/backend/providers/custom_auth_provider.dart';
import 'package:hiring_competitions_admin_portal/backend/providers/firestore_provider.dart';
import 'package:hiring_competitions_admin_portal/constants/custom_colors.dart';
import 'package:hiring_competitions_admin_portal/constants/custom_error.dart';
import 'package:hiring_competitions_admin_portal/views/adminUsers/admin_users.dart';
import 'package:hiring_competitions_admin_portal/views/dashboard/dashboard.dart';
import 'package:hiring_competitions_admin_portal/views/opportunities/opportunities.dart';
import 'package:hiring_competitions_admin_portal/views/users/users.dart';
import 'package:provider/provider.dart';

class Sidebar extends StatefulWidget {
  const Sidebar({super.key});

  @override
  State<Sidebar> createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {

  int _selectedIndex = 0;

  String? status;

  List<Widget> pages = [
    Dashboard(),
    Opportunities(),
    Users(),
    AdminUsers(),
  ];

  Future<String?> getStatus() async {
    final firestorepProvider = Provider.of<FirestoreProvider>(context, listen: false);
    final authProvider = Provider.of<CustomAuthProvider>(context, listen: false);

    await authProvider.checkLogin();

    final uid = authProvider.user?.uid ?? 'none';

    final doc = await firestorepProvider.getAdminStatus(uid);

    if(doc != null) {
      final data = doc.data() as Map<String, dynamic>?;
      return data?['status'];
    }
    return null;
  }

  Future<void> logout() async {
    final provider = Provider.of<CustomAuthProvider>(context, listen: false);
    final res = await provider.logout();
    if(res == null) {
      context.go('/login');
    } else {
      CustomError("error").showToast(context, res);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () async {
      final res = await getStatus();
      if(mounted) {
        setState(() {
          status = res;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<CustomAuthProvider>(context);
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
                            NavElement("Opportunities", "list", 1),
                            NavElement("Users", "users", 2),
                            // NavElement("Reports", "reports", 3),
                            status == 'Admin' ? NavElement("Admin Users", "user", 3) : Container(),
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
                            child: AvatarPlus(authProvider.user?.displayName ?? 'User', trBackground: false,),
                          ),
                          Text(authProvider.user?.displayName ?? 'User', style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: CustomColors().secondaryText,
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
          logout();
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
