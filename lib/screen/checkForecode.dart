import 'package:flutter/material.dart';
import 'package:medical_assistant/them.dart';
class CodeFore extends StatefulWidget {
  const CodeFore({Key? key}) : super(key: key);

  @override
  State<CodeFore> createState() => _CodeForeState();
}

class _CodeForeState extends State<CodeFore> {
  late TextEditingController _firstCodeTextController;
  late TextEditingController _secondCodeTextController;
  late TextEditingController _thirdCodeTextController;
  late TextEditingController _fourthCodeTextController;

  late FocusNode _firstCodeFocusNode;
  late FocusNode _secondCodeFocusNode;
  late FocusNode _thirdCodeFocusNode;
  late FocusNode _fourthCodeFocusNode;
  @override
  void initState() {
    super.initState();
    _firstCodeTextController=TextEditingController();
    _secondCodeTextController=TextEditingController();
    _thirdCodeTextController=TextEditingController();
    _fourthCodeTextController=TextEditingController();
    _firstCodeFocusNode=FocusNode();
    _secondCodeFocusNode=FocusNode();
    _thirdCodeFocusNode=FocusNode();
    _fourthCodeFocusNode=FocusNode();
  }
  @override
  void dispose() {
    _firstCodeTextController.dispose();
    _secondCodeTextController.dispose();
    _thirdCodeTextController.dispose();
    _fourthCodeTextController.dispose();
    _firstCodeFocusNode.dispose();
    _secondCodeFocusNode.dispose();
    _thirdCodeFocusNode.dispose();
    _fourthCodeFocusNode.dispose();

    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: const Text("forecode"),
      ),
      body: Center(
        child: Row(
          children: [
            Expanded(
              child: CodeTextFiled(textEditingController: _firstCodeTextController, focusNode: _firstCodeFocusNode ,onChanged: (String value){
                if(value.isNotEmpty){
                  _secondCodeFocusNode.requestFocus();
                }
              }),
            ),
            const SizedBox(width: 5,),
            Expanded(
              child: CodeTextFiled(textEditingController: _secondCodeTextController, focusNode: _secondCodeFocusNode ,onChanged: (String value){

                  if (value.isNotEmpty) {
                    _thirdCodeFocusNode.requestFocus();
                  } else {
                    _firstCodeFocusNode.requestFocus();
                  }

              }),
            ),
            const SizedBox(width: 5,),
            Expanded(
              child: CodeTextFiled(textEditingController: _thirdCodeTextController, focusNode: _thirdCodeFocusNode ,onChanged: (String value){

                if (value.isNotEmpty) {
                  _fourthCodeFocusNode.requestFocus();
                } else {
                  _secondCodeFocusNode.requestFocus();
                }

              }),
            ),
            const SizedBox(width: 5,),
            Expanded(
              child: CodeTextFiled(textEditingController: _fourthCodeTextController, focusNode: _fourthCodeFocusNode ,onChanged: (String value){

                if (value.isEmpty) {
                  _thirdCodeFocusNode.requestFocus();
                }

              }),
            ),

          ],
        ),
      ),
    );
  }
}

class CodeTextFiled extends StatelessWidget {


  const CodeTextFiled({
    Key? key,
    required TextEditingController textEditingController,
    required FocusNode focusNode,required  ValueChanged<String> onChanged,

  }) : _textEditingController = textEditingController, _focusNode = focusNode,_onChanged=onChanged, super(key: key);

  final TextEditingController _textEditingController;
  final FocusNode _focusNode;
  final ValueChanged<String> _onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller:_textEditingController ,
      focusNode:_focusNode ,
      textAlign: TextAlign.center,
      style: const TextStyle(fontFamily: 'Candara',fontWeight: FontWeight.bold,color: blueClr),
      keyboardType: const TextInputType.numberWithOptions(signed: false,decimal: false),
      onChanged: _onChanged,
      maxLength: 1,
      decoration: InputDecoration(
        counterText: '',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            width: 1,
            color:Colors.grey
          )
        )
      ),

    );
  }
}
