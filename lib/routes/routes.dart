import 'package:go_router/go_router.dart';
import 'package:pm_prototype/presentation/dashboard/dashboard_screen.dart';
import 'package:pm_prototype/presentation/employee/employee_form_screen.dart';
import 'package:pm_prototype/presentation/employee/employee_screen.dart';

// GoRouter configuration
final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const DashboardScreen(),
    ),
    GoRoute(
        path: '/employee',
        builder: (context, state) => const EmployeeScreen(),
        routes: [
          GoRoute(
            path: 'form',
            builder: (context, state) => const EmployeeFormScreen(),
          ),
        ]),
  ],
);
