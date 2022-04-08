import 'package:flutter/material.dart';
import 'package:medical_assistant/them.dart';

import '../api/category_service.dart';
import '../models/category_model.dart';

class CategorySelector extends StatefulWidget {
  const CategorySelector({Key? key}) : super(key: key);

  @override
  _CategorySelectorState createState() => _CategorySelectorState();
}

class _CategorySelectorState extends State<CategorySelector> {
  List<Category> categories = StaticValues().categories;
  int selectedCategoryIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
            children: List.generate(categories.length, (index) {
              Category category = categories[index];
              bool isSelected = index == selectedCategoryIndex;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    this.selectedCategoryIndex = index;
                  });
                },
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 150),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: isSelected ?Colors.transparent:greenClr,
                      width: 1.5
                    ),
                      borderRadius: BorderRadius.circular(10),
                      color: isSelected ? greenClr : Colors.white),
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                  margin: EdgeInsets.symmetric(horizontal: 2),
                  child: Text(
                    category.name,
                    style: TextStyle(
                        fontSize: 15,
                        color: isSelected ? Colors.white : blueClr),
                  ),
                ),
              );
            })),
      ),
    );
  }
}