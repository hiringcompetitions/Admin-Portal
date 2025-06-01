// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
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
      final provider = Provider.of<CustomAuthProvider>(context, listen: false);
      final firestoreProvider = Provider.of<FirestoreProvider>(context, listen: false);
      await provider.checkLogin();
      await Future.delayed(Duration(seconds: 1));

      // if not logged in
      if(provider.user == null) {
        Navigator.pushReplacementNamed(context, '/login');
        return;
      }

      // check the status
      final doc = await firestoreProvider.getAdminStatus(provider.user!.uid);

      if(doc != null && doc.data() != null) {
        final data = doc.data() as Map<String, dynamic>;

        final status = data['status'] ?? 'Pending';

        if(status == "Approved" || status == "Admin") {
          Navigator.pushReplacementNamed(context, '/home');
        } else {
          Navigator.pushReplacementNamed(context, '/login');
        }
      } else {
        Navigator.pushReplacementNamed(context, '/login');
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
