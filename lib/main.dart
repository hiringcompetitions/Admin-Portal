import 'package:flutter/material.dart';
import 'package:flutter_side_menu/flutter_side_menu.dart';
import 'package:hiring_competitions_admin_portal/backend/providers/category_provider.dart';
import 'package:hiring_competitions_admin_portal/constants/theme.dart';
import 'package:hiring_competitions_admin_portal/views/dashboard/dashboard.dart';
import 'package:hiring_competitions_admin_portal/views/sidebar.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DropdownProvider()),
      ],      
    child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: getAppTheme(),
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: Sidebar(),
    );
  }
}