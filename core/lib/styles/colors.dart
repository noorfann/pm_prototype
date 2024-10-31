// colors.dart
import 'package:flutter/material.dart';

// Base Colors
const notionPrimary = Color(0xFF2E2E48);
const notionWhite = Color(0xFFFFFFFF);
const notionBlack = Color(0xFF000000);

// Light Theme Colors
const notionLightBackground = Color(0xFFFFFFFF);
const notionLightSurface = Color(0xFFF7F7F7);
const notionLightText = Color(0xFF37352F);
const notionLightSecondaryText = Color(0xFF6B6B6B);
const notionLightBorder = Color(0xFFE6E6E6);
const notionLightHover = Color(0xFFEBEBEA);
const notionLightPrimaryContainer = Color(0xFFF1F1FF);
const notionLightError = Color(0xFFEB5757);

// Dark Theme Colors
const notionDarkBackground = Color(0xFF1F1F1F);
const notionDarkSurface = Color(0xFF2F2F2F);
const notionDarkText = Color(0xFFE6E6E6);
const notionDarkSecondaryText = Color(0xFFABABAB);
const notionDarkBorder = Color(0xFF404040);
const notionDarkHover = Color(0xFF363636);
const notionDarkPrimaryContainer = Color(0xFF2E2E48);
const notionDarkError = Color(0xFFFF6B6B);

// Light Theme Scheme
const kLightColorScheme = ColorScheme.light(
  primary: notionPrimary,
  onPrimary: notionWhite,
  primaryContainer: notionLightPrimaryContainer,
  onPrimaryContainer: notionPrimary,
  secondary: notionPrimary,
  onSecondary: notionWhite,
  secondaryContainer: notionLightPrimaryContainer,
  onSecondaryContainer: notionPrimary,
  tertiary: notionPrimary,
  onTertiary: notionWhite,
  tertiaryContainer: notionLightPrimaryContainer,
  onTertiaryContainer: notionPrimary,
  error: notionLightError,
  onError: notionWhite,
  errorContainer: notionLightError,
  onErrorContainer: notionWhite,
  surface: notionLightSurface,
  onSurface: notionLightText,
  onSurfaceVariant: notionLightSecondaryText,
  outline: notionLightBorder,
  brightness: Brightness.light,
);

// Dark Theme Scheme
const kDarkColorScheme = ColorScheme.dark(
  primary: notionPrimary,
  onPrimary: notionWhite,
  primaryContainer: notionDarkPrimaryContainer,
  onPrimaryContainer: notionWhite,
  secondary: notionPrimary,
  onSecondary: notionWhite,
  secondaryContainer: notionDarkPrimaryContainer,
  onSecondaryContainer: notionWhite,
  tertiary: notionPrimary,
  onTertiary: notionWhite,
  tertiaryContainer: notionDarkPrimaryContainer,
  onTertiaryContainer: notionWhite,
  error: notionDarkError,
  onError: notionWhite,
  errorContainer: notionDarkError,
  onErrorContainer: notionWhite,
  surface: notionDarkSurface,
  onSurface: notionDarkText,
  onSurfaceVariant: notionDarkSecondaryText,
  outline: notionDarkBorder,
  brightness: Brightness.dark,
);

// Additional custom colors for both themes
const primaryColor = notionPrimary;
const onPrimaryColor = notionWhite;

// Light theme specific
const lightScaffoldBackgroundColor = notionLightBackground;
const lightAccentCanvasColor = notionLightSurface;
final lightActionColor = notionPrimary.withOpacity(0.6);
final lightDivider = const Divider(color: notionLightBorder, height: 1);

// Dark theme specific
const darkScaffoldBackgroundColor = notionDarkBackground;
const darkAccentCanvasColor = notionDarkSurface;
final darkActionColor = notionPrimary.withOpacity(0.6);
final darkDivider = const Divider(color: notionDarkBorder, height: 1);

const white = Colors.white;
final actionColor = const Color(0xFF9E9EFF).withOpacity(0.6);
final divider = Divider(color: white.withOpacity(0.3), height: 1);
