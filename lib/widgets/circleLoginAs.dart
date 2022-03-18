import 'package:flutter/material.dart';
class circleLoginAs extends StatelessWidget {
  const circleLoginAs({
    Key? key,required this.text,
  }) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.purple.shade500,
          fontSize: 30,
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
      ),
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey.shade200,
          boxShadow: [
            BoxShadow(
                offset: const Offset(10, 10),
                color: Colors.grey.shade300,
                blurRadius: 20),
            BoxShadow(
                offset: const Offset(-10, -10),
                color: Colors.white.withOpacity(0.85),
                blurRadius: 10)
          ]),
    );
  }
}
