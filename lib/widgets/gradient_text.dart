import 'package:flutter/material.dart';

class GradientText extends StatelessWidget {
  final String text;
  final TextAlign textAlign;
  final TextStyle style;
  final Gradient gradient;

  GradientText(this.text,
      {required this.textAlign, required this.style, required this.gradient});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) {
        return gradient.createShader(bounds);
      },
      child: Text(
        text,
        textAlign: textAlign,
        style: style.copyWith(
          color: Colors.white,
        ), // Màu chữ có thể là bất kỳ màu nào
      ),
    );
  }
}
