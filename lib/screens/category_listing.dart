// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:banktime/screens/free_lessons.dart';
import 'package:banktime/screens/premium_lessons.dart';
import 'package:banktime/widget/app_style.dart';

class CategoryListingScreen extends StatefulWidget {
  const CategoryListingScreen({Key? key}) : super(key: key);
  @override
  _CategoryListingScreenState createState() => _CategoryListingScreenState();
}

class _CategoryListingScreenState extends State<CategoryListingScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            decoration:
                const BoxDecoration(color: Color.fromRGBO(0, 80, 92, 1)),
            child: Padding(
              padding: const EdgeInsets.only(
                  bottom: 20, top: 60, left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Home',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 45,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: TabBar(
              controller: _tabController,
              indicator: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                      width: 5.0, color: Color.fromRGBO(169, 58, 139, 1)),
                ),
              ),
              labelColor: Color.fromRGBO(9, 140, 237, 1),
              unselectedLabelColor: Color.fromRGBO(255, 18, 101, 1),
              labelStyle: AppThemeData()
                  .testStyle18
                  .copyWith(color: AppThemeData().blueColor),
              tabs: [
                Tab(
                  text: 'Lessons',
                ),
                Tab(
                  text: 'Premium',
                ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
                controller: _tabController,
                children: [FreeLessonsScreen(), const PremiumLessonsScreen()]),
          ),
        ],
      ),

    );
  }

}
