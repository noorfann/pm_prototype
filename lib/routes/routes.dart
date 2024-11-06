import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pm_prototype/presentation/dashboard/dashboard_screen.dart';
import 'package:pm_prototype/presentation/master_data/criteria/criteria_form_screen.dart';
import 'package:pm_prototype/presentation/master_data/criteria/criteria_screen.dart';
import 'package:pm_prototype/presentation/master_data/employee/employee_form_screen.dart';
import 'package:pm_prototype/presentation/master_data/employee/employee_screen.dart';
import 'package:pm_prototype/presentation/master_data/projects/project_form_screen.dart';
import 'package:pm_prototype/presentation/master_data/projects/project_screen.dart';
import 'package:pm_prototype/presentation/master_data/projects/projects_dashboard_screen.dart';
import 'package:pm_prototype/presentation/master_data/role/role_form_screen.dart';
import 'package:pm_prototype/presentation/master_data/role/role_screen.dart';
import 'package:pm_prototype/presentation/profile_matching/assessment/assessment_form_screen.dart';
import 'package:pm_prototype/presentation/profile_matching/assessment/assessment_screen.dart';

// GoRouter configuration
final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

// routes const
const rootScreen = '/';

const roleScreen = '/role';
const roleFormScreen = '/role/form';

const employeeScreen = '/employee';
const employeeFormScreen = '/employee/form';

const criteriaScreen = '/criteria';
const criteriaFormScreen = '/criteria/form';

const projectsScreen = '/projects';
const projectsFormScreen = '/projects/form';

const assessmentScreen = '/assessment';
const assessmentFormScreen = '/assessment/form';

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
            path: rootScreen,
            parentNavigatorKey: _shellNavigatorKey,
            builder: (context, state) => const ProjectsDashboardScreen(),
          ),
          GoRoute(
              path: roleScreen,
              parentNavigatorKey: _shellNavigatorKey,
              builder: (context, state) => const RoleScreen(),
              routes: [
                GoRoute(
                  path: 'form',
                  parentNavigatorKey: _shellNavigatorKey,
                  builder: (context, state) {
                    if (state.extra != null) {
                      final params = state.extra as List;
                      final isEdit = params[0];
                      final role = params[1];
                      return RoleFormScreen(
                        isEdit: isEdit,
                        role: role,
                      );
                    } else {
                      return const RoleFormScreen();
                    }
                  },
                ),
              ]),
          GoRoute(
              path: employeeScreen,
              parentNavigatorKey: _shellNavigatorKey,
              builder: (context, state) => const EmployeeScreen(),
              routes: [
                GoRoute(
                  path: 'form',
                  parentNavigatorKey: _shellNavigatorKey,
                  builder: (context, state) {
                    if (state.extra != null) {
                      final params = state.extra as List;
                      final isEdit = params[0];
                      final employee = params[1];
                      return EmployeeFormScreen(
                        isEdit: isEdit,
                        employee: employee,
                      );
                    } else {
                      return const EmployeeFormScreen();
                    }
                  },
                ),
              ]),
          GoRoute(
              path: criteriaScreen,
              parentNavigatorKey: _shellNavigatorKey,
              builder: (context, state) => const CriteriaScreen(),
              routes: [
                GoRoute(
                  path: 'form',
                  parentNavigatorKey: _shellNavigatorKey,
                  builder: (context, state) {
                    if (state.extra != null) {
                      final params = state.extra as List;
                      final isEdit = params[0];
                      final employee = params[1];
                      return CriteriaFormScreen(
                        isEdit: isEdit,
                        criteria: employee,
                      );
                    } else {
                      return const CriteriaFormScreen();
                    }
                  },
                ),
              ]),
          GoRoute(
              path: projectsScreen,
              parentNavigatorKey: _shellNavigatorKey,
              builder: (context, state) => const ProjectScreen(),
              routes: [
                GoRoute(
                  path: 'form',
                  parentNavigatorKey: _shellNavigatorKey,
                  builder: (context, state) {
                    if (state.extra != null) {
                      final params = state.extra as List;
                      final isEdit = params[0];
                      final project = params[1];
                      return ProjectFormScreen(
                        isEdit: isEdit,
                        project: project,
                      );
                    } else {
                      return const ProjectFormScreen();
                    }
                  },
                ),
              ]),
          GoRoute(
              path: assessmentScreen,
              parentNavigatorKey: _shellNavigatorKey,
              builder: (context, state) => const AssessmentScreen(),
              routes: [
                GoRoute(
                  path: 'form',
                  parentNavigatorKey: _shellNavigatorKey,
                  builder: (context, state) {
                    if (state.extra != null) {
                      final params = state.extra as List;
                      final isEdit = params[0];
                      final assesment = params[1];
                      return AssessmentFormScreen(
                        isEdit: isEdit,
                        employee: assesment,
                      );
                    } else {
                      return const AssessmentFormScreen();
                    }
                  },
                ),
              ]),
        ]),
  ],
);
