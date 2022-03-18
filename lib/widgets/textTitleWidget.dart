import 'package:flutter/material.dart';
class TextTitleWidget extends StatelessWidget {
  const TextTitleWidget({
    Key? key,required this.title,
  }) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        color: Colors.purple.shade500,
        fontSize: 40,
        fontWeight: FontWeight.bold,
        shadows: [
          const Shadow(
              offset: Offset(2, 2),
              color: Colors.black38,
              blurRadius: 10),
          Shadow(
              offset: const Offset(-2, -2),
              color: Colors.white.withOpacity(0.85),
              blurRadius: 10)
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}