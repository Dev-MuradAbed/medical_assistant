import 'package:flutter/material.dart';
import 'package:medical_assistant/them.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  List categories = ['Covid19', 'Cypto', 'Tech', 'Business', 'Health'];
  int selectedCategory = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Medical Assistant',
          style: TextStyle(
            color: blueClr,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView(
        clipBehavior: Clip.antiAlias,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                5,
                (index) => GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedCategory = index;
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    clipBehavior: Clip.antiAlias,
                    // margin: const EdgeInsets.only(left: 10),
                    alignment: Alignment.center,
                    height: 35,
                    width: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: greenClr,
                        width: 2,
                      ),
                      color: selectedCategory == index
                          ? greenClr
                          : Colors.transparent,
                    ),
                    child: Text(
                      categories[index],
                      style: TextStyle(
                          color: selectedCategory == index
                              ? Colors.white
                              : blueClr),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          GridView(
            scrollDirection: Axis.horizontal,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              mainAxisSpacing: 10,
            ),
            children: [
            Container(
              width: 320,
              height: 160,
              color: Colors.red,
            )

            ],
          ),
        ],
      ),
    );
  }
}
// /ListView.builder(
//         itemCount: 10,
//         itemBuilder: (context, index) => const Card(),
//       )
