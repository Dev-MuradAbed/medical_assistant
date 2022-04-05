import 'package:flutter/material.dart';

class ChooseJob extends StatefulWidget {
  const ChooseJob({Key? key}) : super(key: key);

  @override
  State<ChooseJob> createState() => _ChooseJobState();
}

class _ChooseJobState extends State<ChooseJob> {
  List choose = ['U', 'D', 'E'];
  int selectChoose = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(
        3,
        (index) => GestureDetector(
          onTap: () {
            setState(() {
              selectChoose = index;
            });
          },
          child: Container(
            alignment: Alignment.center,
            height: 55,
            width: 55,
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                  color: Color(0xff19A049),
                  blurRadius: 3,
                  spreadRadius: 1,
                ),
              ],
              border: Border.all(
                color: selectChoose == index
                    ? const Color(0xff19A049)
                    : Colors.transparent,
                width: 4,
              ),
              color: selectChoose == index
                  ? Colors.white
                  : const Color(0xff19A049),
              shape: BoxShape.circle,
            ),
            child: Text(
              choose[index],
              style: TextStyle(
                fontFamily: 'Candara',
                color: selectChoose == index
                    ? const Color(0xff184093)
                    : Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
