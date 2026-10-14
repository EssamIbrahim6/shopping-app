import 'package:flutter/material.dart';

abstract final class AppSpacing {
  AppSpacing._();

  // Spacing
  static const double x1 = 8.0;
  static const double x2 = 16.0;
  static const double x3 = 24.0;
  static const double x4 = 32.0;
  static const double x5 = 40.0;
  static const double x6 = 48.0;
  static const double x7 = 96.0;

  // Radius
  static const double radiusXs = 4.0;
  static const double radiusSm = 8.0;
  static const double radiusMd = 12.0;
  static const double radiusLg = 16.0;
  static const double radiusXl = 20.0;
  static const double radius2xl = 24.0;

  // Padding
  static const EdgeInsets allX1 = EdgeInsets.all(x1);
  static const EdgeInsets allX2 = EdgeInsets.all(x2);
  static const EdgeInsets allX3 = EdgeInsets.all(x3);

  static const EdgeInsets horizontalX1 = EdgeInsets.symmetric(horizontal: x1);
  static const EdgeInsets horizontalX2 = EdgeInsets.symmetric(horizontal: x2);
  static const EdgeInsets horizontalX3 = EdgeInsets.symmetric(horizontal: x3);

  static const EdgeInsets verticalX1 = EdgeInsets.symmetric(vertical: x1);
  static const EdgeInsets verticalX2 = EdgeInsets.symmetric(vertical: x2);
  static const EdgeInsets verticalX3 = EdgeInsets.symmetric(vertical: x3);

  static const EdgeInsets horizontalVerticalX1 = EdgeInsets.symmetric(
    horizontal: x1,
    vertical: x1,
  );

  static const EdgeInsets horizontalVerticalX2 = EdgeInsets.symmetric(
    horizontal: x2,
    vertical: x1,
  );

  static const EdgeInsets horizontalVerticalX3 = EdgeInsets.symmetric(
    horizontal: x3,
    vertical: x2,
  );

  static const EdgeInsets screenPadding = horizontalX2;
}

const SizedBox vSpace1 = SizedBox(height: AppSpacing.x1);
const SizedBox vSpace2 = SizedBox(height: AppSpacing.x2);
const SizedBox vSpace3 = SizedBox(height: AppSpacing.x3);
const SizedBox vSpace4 = SizedBox(height: AppSpacing.x4);

const SizedBox hSpace1 = SizedBox(width: AppSpacing.x1);
const SizedBox hSpace2 = SizedBox(width: AppSpacing.x2);
const SizedBox hSpace3 = SizedBox(width: AppSpacing.x3);
const SizedBox hSpace4 = SizedBox(width: AppSpacing.x4);

SizedBox verticalSpace(double height) => SizedBox(height: height);
SizedBox horizontalSpace(double width) => SizedBox(width: width);
