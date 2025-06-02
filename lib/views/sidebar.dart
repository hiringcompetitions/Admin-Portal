import 'package:avatar_plus/avatar_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hiring_competitions_admin_portal/backend/providers/custom_auth_provider.dart';
import 'package:hiring_competitions_admin_portal/backend/providers/firestore_provider.dart';
import 'package:hiring_competitions_admin_portal/constants/custom_colors.dart';
import 'package:hiring_competitions_admin_portal/constants/custom_error.dart';
import 'package:provider/provider.dart';

class Sidebar extends StatefulWidget {
  final Widget child;
  const Sidebar({required this.child, super.key});

  @override
  State<Sidebar> createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  int _selectedIndex = 0;
  // ignore: unused_field
  String _selectedRoute='';

  String? status;

  final List<String> pageRoute = [
    '/home',
    '/home/opportunities',
    '/home/users',
    '/home/adminusers',
  ];

  Future<String?> getStatus() async {
    final firestorepProvider =
        Provider.of<FirestoreProvider>(context, listen: false);
    final authProvider =
        Provider.of<CustomAuthProvider>(context, listen: false);
    await authProvider.checkLogin();
    final uid = authProvider.user?.uid ?? 'none';
    final doc = await firestorepProvider.getAdminStatus(uid);

    if (doc != null) {
      final data = doc.data() as Map<String, dynamic>?;
      return data?['status'];
    }
    return null;
  }

  Future<void> logout() async {
    final provider = Provider.of<CustomAuthProvider>(context, listen: false);
    final res = await provider.logout();
    if (res == null) {
      context.go('/');
    } else {
      CustomError("Error").showToast(context, res);
    }
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      final res = await getStatus();
      if (mounted) {
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
                  SizedBox(height: 4),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            NavElement("Dashboard", "dashboard", 0),
                            NavElement("Opportunities", "list", 1),
                            NavElement("Users", "users", 2),
                            if (status == 'Admin')
                              NavElement("Admin Users", "user", 3),
                          ],
                        ),
                        Column(
                          children: [
                            NavElement("Logout", "logout", -1, onTap: logout),
                            SizedBox(height: 40),
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
                          children: [
                            Text(
                              "Welcome",
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: CustomColors().secondaryText,
                              ),
                            ),
                            SizedBox(width: 10),
                            Image.asset(
                              "lib/assets/hi.png",
                              height: 20,
                            ),
                          ],
                        ),
                        // Account Info
                        Row(
                          children: [
                            Container(
                              height: 40,
                              width: 40,
                              decoration:
                                  BoxDecoration(shape: BoxShape.circle),
                              child: AvatarPlus(
                                authProvider.user?.displayName ?? 'User',
                                trBackground: false,
                              ),
                            ),
                            SizedBox(width: 10),
                            Text(
                              authProvider.user?.displayName ?? 'User',
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: CustomColors().secondaryText,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(child: widget.child),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget NavElement(String name, String image, int index, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: () {
        if (onTap != null) {
          onTap();
        } else if (index >= 0 && index < pageRoute.length) {
          final route = pageRoute[index];
          setState(() {
            _selectedRoute = route;
            _selectedIndex = index;
          });
          context.go(route);
        }
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          margin: EdgeInsets.only(top: 8),
          decoration: BoxDecoration(
            color: _selectedIndex == index
                ? CustomColors().primary
                : Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              SvgPicture.asset(
                "lib/assets/$image.svg",
                height: 20,
                colorFilter: ColorFilter.mode(
                  _selectedIndex == index
                      ? Colors.white
                      : CustomColors().secondaryText,
                  BlendMode.srcIn,
                ),
              ),
              SizedBox(width: 12),
              Text(
                name,
                style: GoogleFonts.commissioner(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: _selectedIndex == index
                      ? Colors.white
                      : CustomColors().secondaryText,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
