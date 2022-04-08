import 'package:flutter/material.dart';
import 'package:medical_assistant/them.dart';

import '../components/categorySelector.dart';
import '../components/newsCarousel.dart';
import '../components/tiledNewsView.dart';
import '../components/topbar.dart';
import '../components/welcomeWidget.dart';



class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
            width: size.width,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(15),
child: Text("Medical Assistant",style: TextStyle(
  fontFamily: 'Candara',
    fontSize: 25,
    color: blueClr,
    fontWeight: FontWeight.bold

),),
                  ),

                  CategorySelector(),
                  SizedBox(
                    height: 15,
                  ),
                  SizedBox(height: 5),
                  NewsCarousel(),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    alignment: AlignmentDirectional.centerStart,
                    padding: EdgeInsets.all(15),
                    child: Text("Latest News",style: TextStyle(
                        fontFamily: 'Candara',
                        fontSize: 25,
                        color: blueClr,
                        fontWeight: FontWeight.bold

                    ),),
                  ),

                  Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TiledNewsView(),
                        TiledNewsView(),
                      ],
                    ),
                  )
                ],
              ),
            )),
      ),
    );
  }
}