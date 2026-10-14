import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shopping_app/core/constants/app_strings.dart';
import 'package:shopping_app/core/theme/app_colors.dart';

class AppTheme {
  AppTheme._();

  static const colorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: AppColors.primary,
    onPrimary: AppColors.onPrimary,
    secondary: AppColors.primaryDark,
    onSecondary: Colors.white,
    error: AppColors.error,
    onError: Colors.white,
    surface: AppColors.surface,
    onSurface: AppColors.onSurface,
    primaryContainer: AppColors.primaryLight,
    onPrimaryContainer: AppColors.heading,
    tertiary: AppColors.info,
    onTertiary: Colors.white,
    surfaceContainerHighest: AppColors.border,
    onSurfaceVariant: AppColors.body,
  );
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: AppStrings.appFontFamily,
    colorScheme: colorScheme,
    primaryColor: AppColors.primary,
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.background,
    appBarTheme: const AppBarTheme(
      elevation: 0,
      toolbarHeight: 64,
      scrolledUnderElevation: 0,
      backgroundColor: AppColors.background,
      foregroundColor: AppColors.body,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
    ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: AppColors.primary,
      selectionColor: AppColors.primary.withValues(alpha: 0.3),
      selectionHandleColor: AppColors.primary,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.background,
      isDense: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      hintStyle: const TextStyle(color: AppColors.bodyLight, fontSize: 12),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.disabled),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.primary, width: 1),
      ),

      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.error),
      ),

      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.error, width: 2),
      ),

      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.disabled),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        minimumSize: const Size(double.infinity, 48),
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primary,
        side: const BorderSide(color: AppColors.primary),
        minimumSize: const Size(double.infinity, 48),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
    textTheme: TextTheme(
      headlineLarge: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: AppColors.heading,
      ),

      headlineMedium: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: AppColors.heading,
      ),
      titleLarge: TextStyle(
        color: AppColors.primary,
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
      titleSmall: TextStyle(
        color: Colors.orange,
        fontWeight: FontWeight.w600,
        fontSize: 12,
      ),
      titleMedium: TextStyle(
        fontSize: 14,
        color: AppColors.bodyLight,
        fontWeight: FontWeight.w400,
      ),
      bodyLarge: TextStyle(fontSize: 16, color: AppColors.body),
      bodyMedium: TextStyle(fontSize: 14, color: AppColors.body),
      bodySmall: TextStyle(fontSize: 12, color: AppColors.body),
      labelLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      labelMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: AppColors.background,
      ),
      labelSmall: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w400,
        color: AppColors.body,
      ),
    ),

    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: colorScheme.surface,
      selectedItemColor: colorScheme.primary,
      unselectedItemColor: colorScheme.onSurfaceVariant,
      type: BottomNavigationBarType.fixed,
      selectedLabelStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
      unselectedLabelStyle: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
    ),
  );
}
