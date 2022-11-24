import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class AnimatedButton extends StatefulWidget {
  const AnimatedButton({Key? key}) : super(key: key);

  @override
  State<AnimatedButton> createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton>
    with SingleTickerProviderStateMixin {
  final borderRadius = BorderRadius.circular(20);
  final imgBorderRadius = BorderRadius.circular(15);
  late final animation = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 800));
  bool _small = false;
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: animation,
        builder: (context, _) {
          final tween = _small
              ? Curves.elasticOut.transform(animation.value)
              : Curves.elasticIn.transform(animation.value);
          final elevation = lerpDouble(10, 20, tween)!;
          final padding = EdgeInsets.lerp(
              const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 15.0,
              ),
              const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
              tween)!;
          final color = Color.lerp(Colors.white, Colors.teal, tween)!;
          final angle = lerpDouble(0, 2 * pi, tween)!;
          final imgWidth = lerpDouble(100, 140, tween)!;
          final imgHeight = lerpDouble(80, 100, tween)!;
          final nameTextStyle = TextStyle.lerp(
              const TextStyle(
                fontSize: 16,
                color: Colors.teal,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.5,
              ),
              const TextStyle(
                fontSize: 22,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.3,
              ),
              tween)!;
          final positionTextStyle = TextStyle.lerp(
              const TextStyle(
                letterSpacing: -0.5,
                fontWeight: FontWeight.w300,
                color: Colors.black,
              ),
              const TextStyle(
                letterSpacing: 1.0,
                fontWeight: FontWeight.w500,
                color: Colors.amber,
              ),
              tween)!;
          return Material(
            elevation: elevation,
            borderRadius: borderRadius,
            color: color,
            child: InkWell(
              onTap: () {
                setState(() {
                  _small = !_small;
                });
                if (_small) {
                  animation.forward(from: 0);
                } else {
                  animation.reverse(from: 1);
                }
              },
              borderRadius: borderRadius,
              child: Padding(
                padding: padding,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Transform.rotate(
                      angle: angle,
                      child: ClipRRect(
                        borderRadius: imgBorderRadius,
                        child: Image.network(
                          'https://korealandscape.net//wp-content/uploads/2022/03/kim-go-eun.jpg',
                          width: imgWidth,
                          height: imgHeight,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Ye Lwin Oo',
                          style: nameTextStyle,
                        ),
                        const SizedBox(height: 5.0),
                        Text(
                          '@flutter dev',
                          style: positionTextStyle,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
