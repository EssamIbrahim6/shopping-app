import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  Size get size => MediaQuery.sizeOf(this);
  double get width => size.width;
  double get height => size.height;

  EdgeInsets get padding => MediaQuery.paddingOf(this);
  EdgeInsets get viewInsets => MediaQuery.viewInsetsOf(this);
  EdgeInsets get viewPadding => MediaQuery.viewPaddingOf(this);

  bool get isKeyboardOpen => viewInsets.bottom > 0;

  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => theme.textTheme;
  ColorScheme get colors => theme.colorScheme;
}
