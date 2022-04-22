import 'package:flutter/material.dart';
import 'package:medical_assistant/theme.dart';
class ListRate extends StatelessWidget {
  const ListRate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        elevation: 0,
        title: const Text('List Rate',style: TextStyle(color: Colors.black),),
        backgroundColor: white,
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context,index){
      return    Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: greenClr),
          ),
          child: ListTile(
            leading: const Icon(Icons.timer_outlined,color: greenClr,),
                trailing: const Icon(Icons.favorite,color: greenClr,),
                title: const Padding(
                  padding:   EdgeInsets.only(bottom: 10),
                  child:  Text('March,20 20:30AM'),
                ),
            subtitle:
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                Text("120/180 mmHg"),
                Spacer(),
                Text("Normal Rate"),
                Spacer()
              ],
            ),
              ),
        ),
      );
        },
      ),
    );
  }
}
