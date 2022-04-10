import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medical_assistant/state/state_managment.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:riverpod/riverpod.dart';

class MyNewDetail extends StatefulWidget {
  const MyNewDetail({Key? key}) : super(key: key);

  @override
  State<MyNewDetail> createState() => _MyNewDetailState();
}

class _MyNewDetailState extends State<MyNewDetail> {
  double progress = 0;
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Color(0xFFA51234)));

    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () => Navigator.pop(context),
                      alignment: AlignmentDirectional.topStart,
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                child: progress < 1.0?LinearProgressIndicator(value: progress,):Container(
                  child: Expanded(
                    child: WebView(
                      // initialUrl: context.read(flavorConfigProvider).state.url
                    ),
                  ),
                ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
