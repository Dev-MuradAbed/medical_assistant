import 'package:flutter/material.dart';


class HomeScreen extends StatefulWidget {
final String? titile;
  const HomeScreen({Key? key, this.titile}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.titile!),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(onPressed: (){
            }, child: Text("LogOUT")),
            Text(widget.titile!),
          ],
        ),
      ),
    );
  }
}
