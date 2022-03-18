import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget(
      {Key? key,
      required this.prefixIcon,
      required this.hintTextField,
      this.suffixIcon,
      this.suffixIconSize,
      this.color,
      this.obscureText = false,
       this.textEditingController,
        this.topmargin=30, this.enable=true, this.ontap, this.typeKey})
      : super(key: key);
  final String hintTextField;
  final IconData prefixIcon;
  final IconData? suffixIcon;
  final double? suffixIconSize;
  final Color? color;
  final bool obscureText;
  final TextEditingController? textEditingController;
  final double topmargin;
  final bool enable;
  final GestureTapCallback? ontap;
  final TextInputType? typeKey;


  @override
  Widget build(BuildContext context) {
    return Container(
      margin:  EdgeInsets.only(top: topmargin),
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Colors.grey.shade100,
          boxShadow: [
            BoxShadow(
                offset: const Offset(10, 10),
                color: Colors.grey.shade200,
                blurRadius: 20),
            BoxShadow(
                offset: const Offset(-10, -10),
                color: Colors.white.withOpacity(0.85),
                blurRadius: 10)
          ]),
      child: InkWell(
        onTap: ontap,
        child: TextField(
          keyboardType: typeKey,
          enabled: enable,
          controller: textEditingController,
          obscureText: obscureText,
          cursorColor: Colors.purple.shade500,
          decoration: InputDecoration(
            hintText: hintTextField,
            hintStyle: const TextStyle(
              color: Colors.black54,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            prefixIcon: Icon(prefixIcon, color: Colors.purple.shade500),
            suffixIcon: Icon(
              suffixIcon,
              size: suffixIconSize,
              color: color,
            ),
            border: InputBorder.none,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          ),
        ),
      ),
    );
  }
}
