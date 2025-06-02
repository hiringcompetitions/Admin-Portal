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
      try {
        final authProvider = Provider.of<CustomAuthProvider>(context, listen: false);
        final firestoreProvider = Provider.of<FirestoreProvider>(context, listen: false);

        await authProvider.checkLogin();
        await Future.delayed(const Duration(seconds: 1)); // for smooth transition

        // If user not logged in
        if (authProvider.user == null) {
          context.go('/login');
          return;
        }

        // Fetch admin status from Firestore
        final doc = await firestoreProvider.getAdminStatus(authProvider.user!.uid);

        if (doc != null && doc.data() != null) {
          final data = doc.data() as Map<String, dynamic>;
          final status = data['status'] ?? 'Pending';

          if (status == 'Approved' || status == 'Admin') {
            context.go('/home');
          } else {
            context.go('/login');
          }
        } else {
          context.go('/login');
        }
      } catch (e) {
        // fallback route if any unexpected error
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
