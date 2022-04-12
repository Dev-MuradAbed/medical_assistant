import 'package:flutter/material.dart';
import 'package:medical_assistant/them.dart';

import '../../widgets/button_widget.dart';



class ForgetScreen extends StatefulWidget {
  const ForgetScreen({Key? key}) : super(key: key);

  @override
  State<ForgetScreen> createState() => _ForgetScreenState();
}

class _ForgetScreenState extends State<ForgetScreen> {
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
    _firstCodeTextController = TextEditingController();
    _secondCodeTextController = TextEditingController();
    _thirdCodeTextController = TextEditingController();
    _fourthCodeTextController = TextEditingController();
    _firstCodeFocusNode = FocusNode();
    _secondCodeFocusNode = FocusNode();
    _thirdCodeFocusNode = FocusNode();
    _fourthCodeFocusNode = FocusNode();
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: blueClr,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          "Forget Password",
          style: TextStyle(
            color: blueClr,
            fontSize: 25,
            fontFamily: 'Candara',
            fontWeight: FontWeight.bold,
          ),
        ),

      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Password Recovery',
            style: TextStyle(
              fontFamily: 'Candara',
              color: blueClr,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 15),
          const Text(
            'Enter 4 number code sent you\non your your email address',
            style: TextStyle(
              fontFamily: 'Candara',
              color: blackClr,
              fontSize: 15,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 15),
          const Text(
            'dev*****ed@gmail.com',
            style: TextStyle(
              fontFamily: 'Candara',
              color: blackClr,
              letterSpacing: 1.2,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 30),
          Row(
            children: [
              const Spacer(),
              CodeTextFiled(
                  textEditingController: _firstCodeTextController,
                  focusNode: _firstCodeFocusNode,
                  onChanged: (String value) {
                    if (value.isNotEmpty) {
                      _secondCodeFocusNode.requestFocus();
                    }
                  }),
              const SizedBox(
                width: 15,
              ),
              CodeTextFiled(
                  textEditingController: _secondCodeTextController,
                  focusNode: _secondCodeFocusNode,
                  onChanged: (String value) {
                    if (value.isNotEmpty) {
                      _thirdCodeFocusNode.requestFocus();
                    } else {
                      _firstCodeFocusNode.requestFocus();
                    }
                  }),
              const SizedBox(
                width: 15,
              ),
              CodeTextFiled(
                  textEditingController: _thirdCodeTextController,
                  focusNode: _thirdCodeFocusNode,
                  onChanged: (String value) {
                    if (value.isNotEmpty) {
                      _fourthCodeFocusNode.requestFocus();
                    } else {
                      _secondCodeFocusNode.requestFocus();
                    }
                  }),
              const SizedBox(
                width: 15,
              ),
              CodeTextFiled(
                  textEditingController: _fourthCodeTextController,
                  focusNode: _fourthCodeFocusNode,
                  onChanged: (String value) {
                    if (value.isEmpty) {
                      _thirdCodeFocusNode.requestFocus();
                    }
                  }),
              const Spacer(),
            ],
          ),
          const SizedBox(height: 50),
          ButtonWidget(text: 'Sent Again', onPressed: () {
            Navigator.pushNamed(context, '/change_password');
          }),
          const SizedBox(height: 90),
        ],
      ),
    );
  }
}

class CodeTextFiled extends StatelessWidget {
  const CodeTextFiled({
    Key? key,
    required TextEditingController textEditingController,
    required FocusNode focusNode,
    required ValueChanged<String> onChanged,
  })  : _textEditingController = textEditingController,
        _focusNode = focusNode,
        _onChanged = onChanged,
        super(key: key);

  final TextEditingController _textEditingController;
  final FocusNode _focusNode;
  final ValueChanged<String> _onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      alignment: Alignment.topCenter,
      height: 64,
      width: 51,
      decoration: BoxDecoration(
        border: Border.all(
          style: BorderStyle.solid,
          color: greenClr,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [
          BoxShadow(
            color: greenClr,
            blurRadius: 8,
            offset: Offset(1, 3),
          ),
        ],
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 22.0, left: 4, right: 4),
        child: TextField(
          controller: _textEditingController,
          focusNode: _focusNode,
          textAlign: TextAlign.center,
          style: const TextStyle(
              fontSize: 20,
              fontFamily: 'Candara',
              fontWeight: FontWeight.bold,
              color: blueClr),
          keyboardType: const TextInputType.numberWithOptions(
            signed: false,
            decimal: false,
          ),
          cursorColor: blueClr,
          cursorHeight: 18,
          cursorRadius: const Radius.circular(15),
          onChanged: _onChanged,
          maxLength: 1,
          decoration: InputDecoration(
            enabledBorder: UnderlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: greenClr,
                width: 3,
              ),
            ),
            focusedBorder: UnderlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: blueClr,
                width: 3,
              ),
            ),
            counterText: '',
          ),
        ),
      ),
    );
  }
}

