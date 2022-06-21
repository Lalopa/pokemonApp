import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  const CustomText({Key? key, required this.text, required this.fontSize})
      : super(key: key);
  final String text;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // The text border
        Text(
          text,
          style: TextStyle(
            fontSize: fontSize,
            letterSpacing: 1.2,
            fontWeight: FontWeight.bold,
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = 0.5
              ..color = Colors.black,
          ),
        ),
        // The text inside
        Text(
          text,
          style: TextStyle(
            fontSize: fontSize,
            letterSpacing: 1.2,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
