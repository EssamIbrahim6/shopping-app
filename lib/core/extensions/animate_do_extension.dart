import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

typedef AnimationBuilder =
    Widget Function({required Widget child, Duration duration, Duration delay});

extension AnimateDoExtension on Widget {
  static const _duration = Duration(milliseconds: 600);

  Widget _animate(
    AnimationBuilder builder, {
    Duration duration = _duration,
    Duration delay = Duration.zero,
  }) {
    return builder(child: this, duration: duration, delay: delay);
  }

  Widget fadeIn({
    Duration duration = _duration,
    Duration delay = Duration.zero,
  }) => _animate(FadeIn.new, duration: duration, delay: delay);

  Widget slideInUp({
    Duration duration = _duration,
    Duration delay = Duration.zero,
  }) => _animate(SlideInUp.new, duration: duration, delay: delay);

  Widget bounceIn({
    Duration duration = _duration,
    Duration delay = Duration.zero,
  }) => _animate(BounceIn.new, duration: duration, delay: delay);

  Widget zoomOut({
    Duration duration = _duration,
    Duration delay = Duration.zero,
  }) => _animate(ZoomOut.new, duration: duration, delay: delay);
  Widget fadeOut({
    Duration duration = _duration,
    Duration delay = Duration.zero,
  }) => _animate(FadeOut.new, duration: duration, delay: delay);

  Widget fadeOutUp({
    Duration duration = _duration,
    Duration delay = Duration.zero,
  }) => _animate(FadeOutUp.new, duration: duration, delay: delay);

  Widget fadeOutDown({
    Duration duration = _duration,
    Duration delay = Duration.zero,
  }) => _animate(FadeOutDown.new, duration: duration, delay: delay);

  Widget fadeOutLeft({
    Duration duration = _duration,
    Duration delay = Duration.zero,
  }) => _animate(FadeOutLeft.new, duration: duration, delay: delay);

  Widget fadeOutRight({
    Duration duration = _duration,
    Duration delay = Duration.zero,
  }) => _animate(FadeOutRight.new, duration: duration, delay: delay);
}
