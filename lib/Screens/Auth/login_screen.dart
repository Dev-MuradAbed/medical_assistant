import 'package:flutter/material.dart';
class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title:const Text("Login",style: TextStyle(color: Colors.greenAccent),),
        centerTitle: true,

      ),
      body:   Padding(
        padding: const EdgeInsets.symmetric(vertical: 30,horizontal: 20),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                    decoration: const BoxDecoration (
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black12,
                              blurRadius: 10,
                              spreadRadius: 1,
                              offset: Offset(0.5,0.5)

                          ),
                          BoxShadow(
                              color: Colors.white,
                              blurRadius: 10,
                              spreadRadius: 1,
                              offset: Offset(-.5,-0.5)
                          ),
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(25))

                    ),
                    child: const CircleAvatar(backgroundColor: Colors.white,radius: 30,child:  Text("U",style: TextStyle(color: Colors.greenAccent,fontSize: 24,fontWeight: FontWeight.bold),),)),
                Container(
                    decoration: const BoxDecoration (
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black12,
                              blurRadius: 10,
                              spreadRadius: 1,
                              offset: Offset(0.5,0.5)

                          ),
                          BoxShadow(
                              color: Colors.white,
                              blurRadius: 10,
                              spreadRadius: 1,
                              offset: Offset(-.5,-0.5)
                          ),
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(25))

                    ),
                    child: const CircleAvatar(backgroundColor: Colors.white,radius: 30,child:  Text("D",style: TextStyle(color: Colors.greenAccent,fontSize: 24,fontWeight: FontWeight.bold),),)),
                Container(
                    decoration: const BoxDecoration (
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black12,
                              blurRadius: 10,
                              spreadRadius: 1,
                              offset: Offset(0.5,0.5)

                          ),
                          BoxShadow(
                              color: Colors.white,
                              blurRadius: 10,
                              spreadRadius: 1,
                              offset: Offset(-.5,-0.5)
                          ),
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(25))

                    ),
                    child: const CircleAvatar(backgroundColor: Colors.white,radius: 30,child: Text("E",style:  TextStyle(color: Colors.greenAccent,fontSize: 24,fontWeight: FontWeight.bold),),)),


              ],
            ),
            const TextFieldWidget(),
           const TextFieldWidget(),
          const SizedBox(height: 6,),
          const  Text("forget your password?",textAlign: TextAlign.end,style: TextStyle(color: Colors.grey),),
            const SizedBox(height: 20,),
            Container(
              decoration: const BoxDecoration (
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        spreadRadius: 1,
                        offset: Offset(0.5,0.5)

                    ),
                    BoxShadow(
                        color: Colors.white,
                        blurRadius: 10,
                        spreadRadius: 1,
                        offset: Offset(-.5,-0.5)
                    ),
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(25))

              ),
              child:const Padding(
                padding:   EdgeInsets.all(10.0),
                child:  Text("LOGIN AS User",textAlign: TextAlign.center,style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.greenAccent),),
              ),

              // child: ElevatedButton(onPressed: (){},style: ElevatedButton.styleFrom(
              //   elevation: 3,
              //   primary: Colors.white,
              //   shape:const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(25)))
              // ),),
            ),
            const SizedBox(height: 6,),
            const  Text("You don't have any account?",textAlign: TextAlign.start,style: TextStyle(color: Colors.grey),),
            Center(
              child: Column(
                children: [
                  const SizedBox(height: 30,),
                  const Text("-OR-",style: TextStyle(fontSize: 20,color: Colors.greenAccent),),
                  const SizedBox(height: 30,),
                  Container(
                      decoration: const BoxDecoration (
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black12,
                                blurRadius: 10,
                                spreadRadius: 1,
                                offset: Offset(0.5,0.5)

                            ),
                            BoxShadow(
                                color: Colors.white,
                                blurRadius: 10,
                                spreadRadius: 1,
                                offset: Offset(-.5,-0.5)
                            ),
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(25))

                      ),
                      child: const Icon(Icons.fingerprint_sharp,size: 50,color: Colors.greenAccent,))

                ],
                
              ),
              
            )


          ],
        ),
      ),
    );
  }
}

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:const EdgeInsets.only(top: 40),
      width: double.infinity,
      height: 50,
      decoration: const BoxDecoration (
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
                blurRadius: 10,
                spreadRadius: 1,
                offset: Offset(0.5,0.5)

          ),
          BoxShadow(
              color: Colors.white,
              blurRadius: 10,
              spreadRadius: 1,
              offset: Offset(-.5,-0.5)
          ),
        ],
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(25))

      ),
      child:const TextField(
        cursorColor: Colors.greenAccent,
      decoration: InputDecoration(
        hintText: 'Enter your id number',
        hintStyle: TextStyle(color: Colors.grey),
        prefixIcon: Icon(Icons.perm_identity,color: Colors.greenAccent,),
        border: InputBorder.none,
        contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 15),


      ),
      ),
    );
  }
}
