import 'package:flutter/material.dart';
import 'categoryPage.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new HomePageState();
  }
}

class HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  TabController _tabController;


  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
        bottom: TabBar(
          controller: _tabController,
          tabs: <Widget>[
            Tab(text: 'android'),
            Tab(text: 'ios'),
            Tab(text: 'all'),
            Tab(text: '福利'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          CategoryPage(type: 1),
          CategoryPage(type: 2),
          CategoryPage(type: 3),
          CategoryPage(type: 4),
        ],
      )
    );
  }
}
