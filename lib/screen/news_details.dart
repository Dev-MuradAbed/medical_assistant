import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NewsViewPage extends StatelessWidget {
  final String? title;
  final String? image;
  final String? description;
  final String imagenull;
  final String? time;
  const NewsViewPage({
    Key? key,
    required this.title,
    required this.image,
    required this.description,
    required this.imagenull,
    required this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading:
        IconButton(
          icon: const Icon(Icons.arrow_back_ios,color: Colors.white,),
          onPressed: ()=>Navigator.pop(context),
        ),
      ),
      body: SizedBox(
          width: size.width,
          child: Stack(
            alignment: Alignment.topLeft,
            children: [

              ClipRRect(
                child: Image(
                  fit: BoxFit.cover,
                  image: NetworkImage(image??imagenull),
                  height: size.height,
                  width: size.width,
                ),
              ),

              Positioned(
                bottom: 0,
                left: 0,
                child: Stack(
                  children: [
                    Container(
                      color: const Color(0xAA333639),
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child:Container(
                          width: size.width,
                          margin: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              Text(
                                title??AppLocalizations.of(context)!.no_title,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                              Row(
                                children: [
                                  const SizedBox(
                                    width: 30,
                                    height: 30,
                                  ),
                                  Expanded(
                                    child: Container(
                                      margin: const EdgeInsets.only(left: 10),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            time??AppLocalizations.of(context)!.no_time,
                                            style: TextStyle(color: Colors.grey[400]),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(right: 40),
                                  )
                                ],
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 10, right: 40),
                                height: 3,
                                decoration: const BoxDecoration(color: Colors.white),
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 10, right: 40),
                                child: Text( description??AppLocalizations.of(context)!.no_description,
                                    style: const TextStyle(
                                      color: Colors.white,
                                    )),
                              ),
                              const SizedBox(height: 30,)
                            ],
                          ),
                        ),
                      ),
                    )

                  ],
                ),
              )
            ],
          )),
    );
  }
}
