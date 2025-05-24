// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hiring_competitions_admin_portal/backend/providers/custom_auth_provider.dart';
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
      final provider = Provider.of<CustomAuthProvider>(context, listen: false);
      await provider.checkLogin();

      await Future.delayed(Duration(seconds: 1));

      if (provider.user == null) {
        Navigator.pushReplacementNamed(context, '/login');
      } else {
        Navigator.pushReplacementNamed(context, '/home');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              "Hiring Competitions",
              style: GoogleFonts.poppins(
                  fontSize: 34,
                  color: CustomColors().primaryText,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
