import 'package:flutter/material.dart';

/// Centralised colour palette for the portfolio.
///
/// RULE: No inline colours anywhere in the project. Every colour used in a
/// widget must reference one of these constants.
class AppColors {
  AppColors._();

  static const Color background = Color(0xFF282C33);
  static const Color primary = Color(0xFF2A9CF2); // blue accent
  static const Color white = Color(0xFFFFFFFF);
  static const Color gray = Color(0xFFABB2BF);
  static const Color line = Color(0xFF2A9CF2);
  static const Color border = Color(0xFFABB2BF);
  static const Color cardBackground = Color(0xFF2A2E36);
  static const Color scrim = Color(0x99282C33);
  static const Color transparent = Colors.transparent;
  static const Color success = Color(0xFF3FB950); // form sent
  static const Color error = Color(0xFFE5534B); // form failed
}

/// Centralised typography. The whole site uses the `Fira Code` monospace family.
///
/// RULE: No inline `TextStyle` anywhere in the project. Every piece of text must
/// reference one of these named styles (use the responsive getters in
/// [AppTextStyles] for headings that shrink on small screens).
class AppTextStyles {
  AppTextStyles._();

  static const String fontFamily = 'Fira Code';

  // --- Headings -------------------------------------------------------------
  static const TextStyle heroTitle = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w600,
    fontSize: 32,
    height: 1.31,
    color: AppColors.white,
  );

  static const TextStyle heroTitleMobile = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w600,
    fontSize: 24,
    height: 1.31,
    color: AppColors.white,
  );

  static const TextStyle sectionTitle = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w600,
    fontSize: 32,
    height: 1.31,
    color: AppColors.white,
  );

  static const TextStyle sectionTitleMobile = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w600,
    fontSize: 24,
    height: 1.31,
    color: AppColors.white,
  );

  static const TextStyle sectionHash = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w600,
    fontSize: 32,
    height: 1.31,
    color: AppColors.primary,
  );

  static const TextStyle sectionHashMobile = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w600,
    fontSize: 24,
    height: 1.31,
    color: AppColors.primary,
  );

  static const TextStyle cardTitle = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w500,
    fontSize: 24,
    height: 1.31,
    color: AppColors.white,
  );

  static const TextStyle quote = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w500,
    fontSize: 24,
    height: 1.31,
    color: AppColors.white,
  );

  static const TextStyle quoteMobile = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w500,
    fontSize: 18,
    height: 1.31,
    color: AppColors.white,
  );

  // --- Body -----------------------------------------------------------------
  static const TextStyle heroSubtitle = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 16,
    height: 1.56,
    color: AppColors.gray,
  );

  static const TextStyle body = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 16,
    height: 1.5,
    color: AppColors.gray,
  );

  static const TextStyle bodyWhite = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 16,
    height: 1.5,
    color: AppColors.white,
  );

  static const TextStyle bold = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w600,
    fontSize: 16,
    height: 1.31,
    color: AppColors.white,
  );

  // --- Labels / interactive -------------------------------------------------
  static const TextStyle button = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w500,
    fontSize: 16,
    height: 1.31,
    color: AppColors.white,
  );

  static const TextStyle navLink = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w500,
    fontSize: 16,
    height: 1.31,
    color: AppColors.gray,
  );

  static const TextStyle navHash = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w500,
    fontSize: 16,
    height: 1.31,
    color: AppColors.primary,
  );

  static const TextStyle navLinkActive = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w500,
    fontSize: 16,
    height: 1.31,
    color: AppColors.white,
  );

  static const TextStyle logoName = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w500,
    fontSize: 24,
    height: 1.31,
    color: AppColors.white,
  );

  static const TextStyle tag = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 16,
    height: 1.31,
    color: AppColors.gray,
  );

  static const TextStyle tagPrimary = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 16,
    height: 1.31,
    color: AppColors.primary,
  );

  static const TextStyle skillItem = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 16,
    height: 1.31,
    color: AppColors.gray,
  );

  static const TextStyle badge = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 16,
    height: 1.31,
    color: AppColors.gray,
  );

  static const TextStyle copyright = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 16,
    height: 1.31,
    color: AppColors.gray,
  );

  static const TextStyle footerName = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w500,
    fontSize: 24,
    height: 1.31,
    color: AppColors.white,
  );

  // --- Contact form ---------------------------------------------------------
  static const TextStyle inputText = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 16,
    height: 1.5,
    color: AppColors.white,
  );

  static const TextStyle inputHint = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 16,
    height: 1.5,
    color: AppColors.gray,
  );

  static const TextStyle formFeedbackSuccess = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    height: 1.4,
    color: AppColors.success,
  );

  static const TextStyle formFeedbackError = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    height: 1.4,
    color: AppColors.error,
  );

  // --- Responsive helpers ---------------------------------------------------
  static TextStyle heroTitleFor(bool isMobile) =>
      isMobile ? heroTitleMobile : heroTitle;

  static TextStyle sectionTitleFor(bool isMobile) =>
      isMobile ? sectionTitleMobile : sectionTitle;

  static TextStyle sectionHashFor(bool isMobile) =>
      isMobile ? sectionHashMobile : sectionHash;

  static TextStyle quoteFor(bool isMobile) => isMobile ? quoteMobile : quote;
}

/// The single application theme (dark, code-editor aesthetic).
ThemeData buildAppTheme() {
  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.background,
    fontFamily: AppTextStyles.fontFamily,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.primary,
      onPrimary: AppColors.white,
      secondary: AppColors.primary,
      onSecondary: AppColors.white,
      surface: AppColors.background,
      onSurface: AppColors.white,
    ),
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: AppColors.primary,
    ),
  );
}
