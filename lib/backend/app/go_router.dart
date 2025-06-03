import 'package:go_router/go_router.dart';
import 'package:hiring_competitions_admin_portal/backend/providers/custom_auth_provider.dart';
import 'package:hiring_competitions_admin_portal/views/adminUsers/admin_users.dart';
import 'package:hiring_competitions_admin_portal/views/applicants/applicants.dart';
import 'package:hiring_competitions_admin_portal/views/applicants/widgets/applicants_data.dart';
import 'package:hiring_competitions_admin_portal/views/auth/login.dart';
import 'package:hiring_competitions_admin_portal/views/auth/signup.dart';
import 'package:hiring_competitions_admin_portal/views/dashboard/dashboard.dart';
import 'package:hiring_competitions_admin_portal/views/opportunities/opportunities.dart';
import 'package:hiring_competitions_admin_portal/views/sidebar.dart';
import 'package:hiring_competitions_admin_portal/views/splash/splash_screen.dart';
import 'package:hiring_competitions_admin_portal/views/users/users.dart';
import 'package:provider/provider.dart';

final GoRouter router = GoRouter(
  redirect: (context, state) {
  final authProvider = Provider.of<CustomAuthProvider>(context, listen: false);
  final user = authProvider.user;
  final adminStatus = authProvider.adminStatus;
  final isInitialized = authProvider.isInitialized;
  final currentPath = state.uri.toString().toLowerCase();

  if (!isInitialized) {
    // Still loading auth state, stay on splash screen
    if (currentPath != '/') return '/';
    return null;
  }

  if (user == null &&
      currentPath != '/login' &&
      currentPath != '/signup' &&
      currentPath != '/') {
    return '/login';
  }

  if (user != null) {
    if (adminStatus == 'Pending' || adminStatus == 'Rejected' || adminStatus == 'Removed') {
      return '/login'; // or some access denied page
    }

    if ((currentPath == '/login' || currentPath == '/signup' || currentPath == '/') &&
        (adminStatus == 'Approved' || adminStatus == 'Admin')) {
      return '/home';
    }
  }

  return null; // no redirect
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
                path: 'opportunities',
                builder: (context, state) => Opportunities(),
                routes: [
                   GoRoute(
              path: ':opportunityName/applications',
              name: 'applications',
              builder: (context, state) {
                
                final extraData = state.extra as ApplicantsData;
                return Applicants(
                  
                  data: extraData,
                );
              },
            ),
                ]),
            GoRoute(
              path: 'users',
              builder: (context, state) => Users(),
            ),
            GoRoute(
              path: 'adminusers',
              builder: (context, state) => AdminUsers(),
            ),
          ],
        ),
      ],
    ),

    //opputunities routes
  ],
);
