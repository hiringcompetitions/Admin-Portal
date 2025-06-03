// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hiring_competitions_admin_portal/backend/providers/custom_auth_provider.dart';
import 'package:hiring_competitions_admin_portal/backend/providers/firestore_provider.dart';
import 'package:hiring_competitions_admin_portal/constants/custom_colors.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
void initState() {
  super.initState();

  Future.delayed(Duration.zero, () async {
    final authProvider = Provider.of<CustomAuthProvider>(context, listen: false);
    await authProvider.checkLogin();

    if (authProvider.user == null) {
      context.go('/login');
      return;
    }

    final status = authProvider.adminStatus;
    if (status == 'Approved' || status == 'Admin') {
      context.go('/home');
    } else {
      context.go('/login');
    }
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors().background,
      body: Center(
        child: Text(
          "Hiring Competitions",
          style: GoogleFonts.poppins(
            fontSize: 34,
            fontWeight: FontWeight.w600,
            color: CustomColors().primaryText,
          ),
        ),
      ),
    );
  }
}
