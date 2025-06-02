import 'dart:async';
import 'dart:html' as html;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hiring_competitions_admin_portal/backend/providers/custom_auth_provider.dart';
import 'package:hiring_competitions_admin_portal/backend/providers/firestore_provider.dart';
import 'package:hiring_competitions_admin_portal/constants/theme.dart';
import 'package:hiring_competitions_admin_portal/firebase_options.dart';
import 'package:hiring_competitions_admin_portal/views/applicants/applicants.dart';
import 'package:hiring_competitions_admin_portal/views/applicants/widgets/applicants_data.dart';
import 'package:hiring_competitions_admin_portal/views/auth/login.dart';
import 'package:hiring_competitions_admin_portal/views/auth/signup.dart';
import 'package:hiring_competitions_admin_portal/views/sidebar.dart';
import 'package:hiring_competitions_admin_portal/views/splash/splash_screen.dart';
import 'package:provider/provider.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => SplashScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => Login(),
    ),
    GoRoute(
      path: '/signup',
      builder: (context, state) => Signup(),
    ),
    GoRoute(
      path: '/home',
      redirect: (context, state) {
        final isLoggedIn = FirebaseAuth.instance.currentUser != null;
        return isLoggedIn ? null : '/login';
      },
      builder: (context, state) => Sidebar(),
      routes: [
        GoRoute(
          path: 'applicants', // Becomes /home/applicants
          builder: (context, state) {
            final data = state.extra as ApplicantsData;
            return Applicants(data: data);
          },
        ),
      ],
    ),
  ],
);

void main() {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    html.window.onPopState.listen((event) {
      html.window.history.pushState(null, '', html.window.location.href);
    });

    html.window.history.pushState(null, '', html.window.location.href);
    runApp(MyApp());
  }, (error, stack) {
    // Optional: log to Firebase Crashlytics or console
    print("Unhandled error: $error");
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CustomAuthProvider()),
        ChangeNotifierProvider(create: (_) => FirestoreProvider()), 
      ],
      child: MaterialApp.router(
        theme: getAppTheme(),
        debugShowCheckedModeBanner: false,
        title: 'Hiring Competitions',
        routerConfig: router,
      ),
    );
  }
}

