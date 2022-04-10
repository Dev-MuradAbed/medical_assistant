import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:medical_assistant/api/news_api.dart';
import 'package:medical_assistant/models/ariticles.dart';

import '../models/news.dart';
import 'news_details.dart';

class Home_News_Screen extends StatefulWidget {
  const Home_News_Screen({Key? key}) : super(key: key);

  @override
  State<Home_News_Screen> createState() => _Home_News_ScrrenState();
}

class _Home_News_ScrrenState extends State<Home_News_Screen>
    with SingleTickerProviderStateMixin {
  String imagenull="https://www.aljazeera.net/wp-content/uploads/2021/09/GettyImages-521329128.jpg?resize=770%2C513";
  final List<Tab> tabs = <Tab>[
    Tab(text: 'General'),
    Tab(text: 'Techonology'),
    Tab(text: 'Sports'),
    Tab(text: 'Business'),
    Tab(text: 'Entertainment'),
    Tab(text: 'Health'),
  ];
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: Text(
            'App Name',
            style: TextStyle(color: Colors.black),
          ),
          bottom: TabBar(
            isScrollable: true,
            unselectedLabelColor: Colors.grey,
            labelColor: Colors.white,
            indicatorSize: TabBarIndicatorSize.tab,
            indicator: BubbleTabIndicator(
              indicatorHeight: 25.0,
              indicatorColor: Colors.teal,
              tabBarIndicatorSize: TabBarIndicatorSize.tab,
            ),
            tabs: tabs,
            controller: _tabController,
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: tabs.map((tab) {
            return FutureBuilder(
                future: feachNewsByCategory(tab.text!),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text('${snapshot.error}'),
                    );
                  } else if (snapshot.hasData) {
                    var newList = snapshot.data as News;
                    // select top 10
                    //if length >10, we will get from 0~10
                    //if length <10, we will get from 0~x
                    //if length ==null, we will get 0
                    var sliderList = newList.articles != null
                        ? newList.articles!.length > 10
                            ? newList.articles!.getRange(0, 10).toList()
                            : newList.articles!
                                .take(newList.articles!.length)
                                .toList()
                        : [];
                    //select article excepts top 10
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
                        CarouselSlider(
                          options: CarouselOptions(
                              aspectRatio: 16 / 9,
                              enlargeCenterPage: true,
                              viewportFraction: 0.8),
                          items: sliderList.map((item) {
                            return Builder(builder: (context) {
                              return GestureDetector(
                                onTap: null,
                                child: Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.network(
                                        '${item.urlToImage!=null?item.urlToImage:imagenull}',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          color: Color(0xAA333639),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8),
                                            child: Text(
                                              '${item.title}',
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
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
                            });
                          }).toList(),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.only(start: 30),
                          child: Container(
                            alignment: AlignmentDirectional.centerStart,
                            child: Text(
                              'Latest News',
                              style: TextStyle(
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
                                  leading:contentList[index].urlToImage!=null? ClipRRect(
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
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(
                                    '${contentList[index].publishedAt}',
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      ],
                    ));
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                });
          }).toList(),
        ));
  }
}
