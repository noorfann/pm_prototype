import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pm_prototype/presentation/criteria/criteria_screen.dart';
import 'package:pm_prototype/presentation/dashboard/dashboard_screen.dart';
import 'package:pm_prototype/presentation/employee/employee_form_screen.dart';
import 'package:pm_prototype/presentation/employee/employee_screen.dart';
import 'package:pm_prototype/presentation/projects/projects_screen.dart';

// GoRouter configuration
final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();
final router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  routes: [
    ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (BuildContext context, GoRouterState state, Widget child) {
          return DashboardScreen(
            child: child,
          );
        },
        routes: [
          GoRoute(
            path: '/',
            parentNavigatorKey: _shellNavigatorKey,
            builder: (context, state) => const ProjectsScreen(),
          ),
          GoRoute(
              path: '/employee',
              parentNavigatorKey: _shellNavigatorKey,
              builder: (context, state) => const EmployeeScreen(),
              routes: [
                GoRoute(
                  path: 'form',
                  parentNavigatorKey: _shellNavigatorKey,
                  builder: (context, state) => const EmployeeFormScreen(),
                ),
              ]),
          GoRoute(
              path: '/criteria',
              parentNavigatorKey: _shellNavigatorKey,
              builder: (context, state) => const CriteriaScreen(),
              routes: []),
        ]),
  ],
);
