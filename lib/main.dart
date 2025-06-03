import 'dart:async';
import 'dart:html' as html;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hiring_competitions_admin_portal/backend/app/go_router.dart';
import 'package:hiring_competitions_admin_portal/backend/providers/custom_auth_provider.dart';
import 'package:hiring_competitions_admin_portal/backend/providers/firestore_provider.dart';
import 'package:hiring_competitions_admin_portal/constants/theme.dart';
import 'package:hiring_competitions_admin_portal/firebase_options.dart';
import 'package:provider/provider.dart';


void main() {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    html.window.onPopState.listen((event) {
      html.window.history.pushState(null, '', html.window.location.href);
    });
     await FirebaseAuth.instance.setPersistence(Persistence.LOCAL);
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
        ChangeNotifierProvider(create: (_) => CustomAuthProvider(firestoreProvider: FirestoreProvider())),
        ChangeNotifierProvider(create: (_) => FirestoreProvider()), 
      ],
      child: MaterialApp.router(
        routerConfig: router,
        theme: getAppTheme(),
        debugShowCheckedModeBanner: false,
        title: 'Hiring Competitions',
      ),
    );
  }
}

