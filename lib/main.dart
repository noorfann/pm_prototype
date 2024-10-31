import 'package:flutter/material.dart';
import 'package:core/core.dart';

import 'routes/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
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
    );
  }
}
