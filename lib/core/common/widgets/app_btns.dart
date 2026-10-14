import 'package:flutter/material.dart';
import 'package:shopping_app/core/theme/app_style.dart';

class _AppButton extends StatelessWidget {
  const _AppButton({
    required this.onPressed,
    required this.child,
    required this.shadow,
  });

  final VoidCallback? onPressed;
  final Widget child;
  final BoxShadow shadow;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(boxShadow: [shadow]),
      child: ElevatedButton(onPressed: onPressed, child: child),
    );
  }
}

class PrimaryBtn extends StatelessWidget {
  const PrimaryBtn({super.key, required this.onPressed, required this.child});

  final VoidCallback? onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: AppStyles.primaryDecoration,
      child: ElevatedButton(
        style: AppStyles.primaryStyle,
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}

class SecondaryBtn extends StatelessWidget {
  const SecondaryBtn({super.key, required this.onPressed, required this.child});

  final VoidCallback? onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: AppStyles.secondaryDecoration,
      child: ElevatedButton(
        style: AppStyles.secondaryStyle,
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}

class DefaultBtn extends StatelessWidget {
  const DefaultBtn({super.key, required this.onPressed, required this.child});

  final VoidCallback? onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return _AppButton(
      onPressed: onPressed,
      shadow: AppStyles.defaultShadow,
      child: child,
    );
  }
}
