import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:hiring_competitions_admin_portal/views/adminUsers/admin_users.dart';
import 'package:hiring_competitions_admin_portal/views/auth/login.dart';
import 'package:hiring_competitions_admin_portal/views/auth/signup.dart';
import 'package:hiring_competitions_admin_portal/views/dashboard/dashboard.dart';
import 'package:hiring_competitions_admin_portal/views/opportunities/opportunities.dart';
import 'package:hiring_competitions_admin_portal/views/sidebar.dart';
import 'package:hiring_competitions_admin_portal/views/splash/splash_screen.dart';
import 'package:hiring_competitions_admin_portal/views/users/users.dart';

final GoRouter router = GoRouter(
  redirect: (context, state) {
    final isLoggedIn = FirebaseAuth.instance.currentUser != null;
    final currentPath = state.uri.toString().toLowerCase();

    if (!isLoggedIn &&
        currentPath != '/login' &&
        currentPath != '/signup' &&
        currentPath != '/') {
      return '/login';
    }

    if (isLoggedIn && (currentPath == '/login' || currentPath == '/signup')) {
      return '/home';
    }

    return null;
  },
  routes: [
    // Public routes
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => Login(),
    ),
    GoRoute(
      path: '/signup',
      builder: (context, state) => Signup(),
    ),

    // ShellRoute
    ShellRoute(
      builder: (context, state, child) => Sidebar(child: child),
      routes: [
        GoRoute(
          path: '/home',
          builder: (context, state) => Dashboard(),
          routes: [
            GoRoute(
              path: '/opportunities', 
              builder: (context, state) => Opportunities(),
            ),
            GoRoute(
              path: '/users', 
              builder: (context, state) => Users(),
            ),
            GoRoute(
              path: '/adminusers',
              builder: (context, state) => AdminUsers(),
            ),
          ],
        ),
      ],
    ),
  ],
);
