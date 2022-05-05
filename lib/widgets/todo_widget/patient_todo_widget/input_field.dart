
import 'package:flutter/material.dart';

import '../../../size_config.dart';
import '../../../theme.dart';

class InputField extends StatelessWidget {
  const InputField(
      {Key? key,
      required this.title,
      required this.hint,
      this.controller,
      this.widget})
      : super(key: key);
  final String title;

  final String hint;

  final TextEditingController? controller;
  final Widget? widget;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      margin: const EdgeInsets.only(top: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,style: titleStyle,),
          Container(
            padding: const EdgeInsets.only(left: 14),
            margin: const EdgeInsets.only(top: 8),
            height: 52,
            width: SizeConfig.screenWidth,
            decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey
                ),
                borderRadius: BorderRadius.circular(12)),
            child: Row(
              children: [
                Expanded(
                    child: TextFormField(
                      autofocus: false,
                      controller: controller,
                      readOnly: widget!=null?true:false,
                      style: subTitle,
                      cursorColor: Colors.grey,
                      decoration:  InputDecoration(
                        hintText: hint,
                        hintStyle: subTitle,
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                          color: Colors.grey,
                          )
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                          color: Colors.grey,
                          )
                         )
                      ),
                    )),
                widget??Container()
              ],
            ),
          ),
        ],
      ),
    );
  }
}
