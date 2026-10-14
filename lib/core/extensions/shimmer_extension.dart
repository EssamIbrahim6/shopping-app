import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

extension ShimmerExtension on Widget {
  Widget withShimmer({bool isShow = true, Color? color, Key? key}) {
    return _ShimmerWrapper(key: key, isShow: isShow, color: color, child: this);
  }
}

class _ShimmerWrapper extends StatelessWidget {
  final Widget child;
  final bool isShow;
  final Color? color;

  const _ShimmerWrapper({
    super.key,
    required this.child,
    required this.isShow,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    if (!isShow) return child;

    return Shimmer.fromColors(
      baseColor: Theme.of(context).colorScheme.onSurface.withValues(alpha: .05),
      highlightColor: Theme.of(
        context,
      ).colorScheme.onSurface.withValues(alpha: .1),
      child: Container(
        color: color ?? Theme.of(context).colorScheme.surface,
        child: child,
      ),
    );
  }
}
