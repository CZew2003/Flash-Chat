import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class FlickerAnimatedTextCorrected extends AnimatedText {
  /// Marks ending of flickering entry interval of text
  final double entryEnd;
  final Duration speed;

  FlickerAnimatedTextCorrected(
    String text, {
    TextAlign textAlign = TextAlign.start,
    TextStyle? textStyle,
    this.speed = const Duration(milliseconds: 1600),
    this.entryEnd = 0.5,
  }) : super(
          text: text,
          textStyle: textStyle,
          duration: speed,
          textAlign: textAlign,
        );

  late Animation<double> _entry;

  @override
  void initAnimation(AnimationController controller) {
    _entry = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(0.0, entryEnd, curve: Curves.bounceIn),
      ),
    );
  }

  @override
  Widget completeText(BuildContext context) => const SizedBox.shrink();

  @override
  Widget animatedBuilder(BuildContext context, Widget? child) {
    return Opacity(
      opacity: _entry.value != 1.0 ? _entry.value : _entry.value,
      child: textWidget(text),
    );
  }
}
