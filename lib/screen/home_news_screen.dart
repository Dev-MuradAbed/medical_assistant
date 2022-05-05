import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:medical_assistant/api/news_api.dart';
import 'package:medical_assistant/models/ariticles.dart';

import '../models/news.dart';

import '../theme.dart';
import 'news_details.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeNewsScreen extends StatefulWidget {
  const HomeNewsScreen({Key? key}) : super(key: key);

  @override
  State<HomeNewsScreen> createState() => _Home_News_ScrrenState();
}

class _Home_News_ScrrenState extends State<HomeNewsScreen>
    with SingleTickerProviderStateMixin {
  String imagenull="https://www.aljazeera.net/wp-content/uploads/2021/09/GettyImages-521329128.jpg?resize=770%2C513";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          elevation: 0,
          backgroundColor: Colors.white,
          title:  Text(
            AppLocalizations.of(context)!.medical_assistant,
            style: const TextStyle(color: blueClr),
            textAlign: TextAlign.start,
          ),
        ),
        body:
             FutureBuilder(
                future: feachNewsByCategory('Health'),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text('${snapshot.error}'),
                    );
                  } else if (snapshot.hasData){
                    var newList = snapshot.data as News;

                    var sliderList = newList.articles != null
                        ? newList.articles!.length > 10
                            ? newList.articles!.getRange(0, 10).toList()
                            : newList.articles!
                                .take(newList.articles!.length)
                                .toList()
                        : [];

                    var contentList = newList.articles != null
                        ? newList.articles!.length > 10
                            ? newList.articles!
                                .getRange(11, newList.articles!.length - 1)
                                .toList()
                            : []
                        : [];
                    return SafeArea(
                        child: Column(
                      children: [
                        const SizedBox(height: 10,),
                        CarouselSlider(
                          options: CarouselOptions(
                              aspectRatio: 16 / 9,
                              enlargeCenterPage: true,
                              viewportFraction: 0.8),
                          items: sliderList.map((item) {
                            return item.urlToImage != null
                                ?
                              Builder(builder: (context) {
                              return GestureDetector(
                                onTap: null,
                                child: Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.network(
                                        '${item.urlToImage}',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          color: const Color(0xAA333639),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8),
                                            child: Text(
                                              '${item.title}',
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              );
                            })
                                :ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                '$imagenull',
                                fit: BoxFit.cover,
                              ),
                            );
                          }).toList(),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.only(start: 30),
                          child: Container(
                            alignment: AlignmentDirectional.centerStart,
                            child:  Text(
                              AppLocalizations.of(context)!.latest_news,
                              style: const TextStyle(
                                  fontSize: 26, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: contentList.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => NewsViewPage(
                                              title: contentList[index].title,
                                              image: contentList[index].urlToImage ,
                                              imagenull: imagenull,
                                              description: contentList[index].description,
                                              time: contentList[index].publishedAt,)));
                                },
                                child: ListTile(
                                  leading:contentList[index].urlToImage!=null?
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.network(
                                      '${contentList[index].urlToImage}',
                                      fit: BoxFit.cover,
                                      height: 80,
                                      width: 80,
                                    ),
                                  ):ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.network(
                                      imagenull,
                                      fit: BoxFit.cover,
                                      height: 80,
                                      width: 80,
                                    ),
                                  ),
                                  title: Text(
                                    '${contentList[index].title}',
                                    overflow: TextOverflow.ellipsis,
                                    style:
                                        const TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(
                                    '${contentList[index].publishedAt}',
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      ],
                    ));
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                })

        );
  }
}
