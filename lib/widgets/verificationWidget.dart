import 'package:flutter/material.dart';

class VerificationWidget extends StatelessWidget {
  const VerificationWidget({Key? key, required this.first, required this.last})
      : super(key: key);
  final bool first, last;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 85,
      child: AspectRatio(
        aspectRatio: 1.0,
        child: Stack(
          children: [
            Container(
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
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: TextField(
                autofocus: true,
                onChanged: (value) {
                  if (value.length == 1 && last == false) {
                    FocusScope.of(context).nextFocus();
                  }
                  if (value.length == 0 && first == false) {
                    FocusScope.of(context).previousFocus();
                  }
                },
                showCursor: false,
                readOnly: false,
                textAlign: TextAlign.center,
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
                keyboardType: TextInputType.number,
                maxLength: 1,
                decoration: InputDecoration(
                  counter: Offstage(),
                  enabledBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.grey.shade200, width: 2)),
                  focusedBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.purple.shade500, width: 2)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}