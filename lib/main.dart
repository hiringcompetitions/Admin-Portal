import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_side_menu/flutter_side_menu.dart';
import 'package:hiring_competitions_admin_portal/backend/providers/category_provider.dart';

import 'package:hiring_competitions_admin_portal/backend/providers/custom_auth_provider.dart';
import 'package:hiring_competitions_admin_portal/backend/providers/firestore_provider.dart';
import 'package:hiring_competitions_admin_portal/constants/theme.dart';
import 'package:hiring_competitions_admin_portal/firebase_options.dart';
import 'package:hiring_competitions_admin_portal/views/auth/login.dart';
import 'package:hiring_competitions_admin_portal/views/auth/signup.dart';
import 'package:hiring_competitions_admin_portal/views/oppurtunities/add_opportunity_card.dart';
import 'package:hiring_competitions_admin_portal/views/oppurtunities/oppurtunities.dart';
import 'package:hiring_competitions_admin_portal/views/sidebar.dart';
import 'package:hiring_competitions_admin_portal/views/splash/splash_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DropdownProvider()),
        ChangeNotifierProvider(create: (_) => CustomAuthProvider()),
        ChangeNotifierProvider(create: (_) => FirestoreProvider()), 
      ],
      child: MaterialApp(
        theme: getAppTheme(),
        debugShowCheckedModeBanner: false,
        title: 'Hiring Competitions',
        initialRoute: '/',
        routes: {
          '/' : (context) => SplashScreen(),
          '/login' : (context) => Login(),
          '/signup' : (context) => Signup(),
          '/home' : (context) => Sidebar(),
        },
      ),
    );
  }
}