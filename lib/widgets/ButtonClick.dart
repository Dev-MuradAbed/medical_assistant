import 'package:flutter/material.dart';
class ButtonClick extends StatefulWidget {
  const ButtonClick({
    Key? key,required this.text, this.IdtextEditingController, this.PasswordtextEditingController,
  }) : super(key: key);
  final String text;
  final TextEditingController? IdtextEditingController;
  final TextEditingController? PasswordtextEditingController;

  @override
  State<ButtonClick> createState() => _ButtonClickState();
}

class _ButtonClickState extends State<ButtonClick> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        setState(() {
          _checkfiled(widget.IdtextEditingController!, widget.PasswordtextEditingController!);
        });

      },
      child: Container(
        decoration: BoxDecoration(

          // shape: BoxShape.circle,
            borderRadius: BorderRadius.circular(25),
            color: Colors.grey.shade200,
            boxShadow: [
              BoxShadow(
                  offset: const Offset(10, 10),
                  // color: Colors.black38,
                  color: Colors.grey.shade300,
                  blurRadius: 20),
              BoxShadow(
                  offset: const Offset(-10, -10),
                  color: Colors.white.withOpacity(0.85),
                  blurRadius: 10)
            ]),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            widget.text,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.purple.shade500,
            ),
          ),
        ),
      ),
    );

  }

}
_checkfiled(TextEditingController IdtextEditingController,TextEditingController PasswordtextEditingController){
  if(IdtextEditingController.text==""||PasswordtextEditingController.text==""){
   return print("some thing empty please complete your data");
  }else if(IdtextEditingController.text=="123"&&PasswordtextEditingController.text=="123"){
    return print("welcom to app");
  } else{
    print("try agin");
  }
}
