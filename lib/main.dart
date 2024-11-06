import 'package:flutter/material.dart';
import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pm_prototype/cubit/assessment/assessment_cubit.dart';
import 'package:pm_prototype/cubit/criteria/criteria_cubit.dart';
import 'package:pm_prototype/cubit/employee/employee_cubit.dart';
import 'package:pm_prototype/cubit/menu/menu_cubit.dart';
import 'package:pm_prototype/cubit/project/project_cubit.dart';
import 'package:pm_prototype/cubit/role/role_cubit.dart';
import 'package:pm_prototype/injection.dart';

import 'routes/routes.dart';
import 'package:pm_prototype/injection.dart' as di;

void main() async {
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // menu cubit
        BlocProvider(
          create: (_) => di.locator<MenuCubit>(),
        ),
        // employee cubit
        BlocProvider(
          create: (_) => di.locator<EmployeeCubit>(),
        ),
        // role cubit
        BlocProvider(
          create: (_) => di.locator<RoleCubit>(),
        ),
        // criteria cubit
        BlocProvider(
          create: (_) => di.locator<CriteriaCubit>(),
        ),
        // project cubit
        BlocProvider(
          create: (_) => di.locator<ProjectCubit>(),
        ),
        // assessment cubit
        BlocProvider(
          create: (_) => di.locator<AssessmentCubit>(),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Flutter pm_prototype Panel',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: kLightColorScheme,
          scaffoldBackgroundColor: lightScaffoldBackgroundColor,
          dividerTheme: const DividerThemeData(
            color: notionLightBorder,
          ),
          // Add other theme configurations as needed
        ),
        darkTheme: ThemeData(
          useMaterial3: true,
          colorScheme: kDarkColorScheme,
          scaffoldBackgroundColor: darkScaffoldBackgroundColor,
          dividerTheme: const DividerThemeData(
            color: notionDarkBorder,
          ),
          // Add other theme configurations as needed
        ),
        routerConfig: router,
      ),
    );
  }
}
