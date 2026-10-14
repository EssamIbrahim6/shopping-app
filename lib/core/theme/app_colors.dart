import 'package:flutter/material.dart';

abstract final class AppColors {
  AppColors._();
  static const primary = Color(0xFF6C63FF);
  static const primaryLight = Color(0xFFEEECFF);
  static const primaryDark = Color(0xFF5147D9);
  static const accent = Color(0xFFFF785A);
  static const accentDark = Color(0xFFC2412D);
  static const accentLight = Color(0xFFFFE5DF);
  static const background = Color(0xFFF7F7FC);
  static const surface = Colors.white;
  static const heading = Color(0xFF222338);
  static const body = Color(0xFF414256);
  static const bodyLight = Color(0xFF77788A);

  static const border = Color(0xFFE8E8F0);
  static const divider = Color(0xFFF0F0F6);
  static const disabled = Color(0xFFE8E8F0);

  static const success = Color(0xFF16834A);
  static const warning = Color(0xFFB54708);
  static const error = Color(0xFFB42318);
  static const info = Color(0xFF3B82F6);

  static const cartScreenBackground = background;
  static const cartSummaryBackground = Colors.white;
  static const cartDividerColor = border;

  static const onPrimary = Colors.white;
  static const onSurface = heading;
  static const dotColor = Color(0xFFAAAAB8);
  static const reviewerBgColor = Color(0xffE4E4E4);
  static const reviewerAvatar = Color(0xFF555555);

  static const redBorder = error;
  static const blackBorder = Color(0xFF000000);
  static const grayBorder = Color(0xff9E9E9E);
}
