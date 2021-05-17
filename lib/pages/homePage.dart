import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:expenses_management/pages/home.dart';
import 'package:expenses_management/pages/page2.dart';
import 'package:expenses_management/pages/page3.dart';
import 'package:flutter/material.dart';
import './dashboard.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: 0,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: PageView(
        controller: _pageController,
        children: [
          Dashboard(),
          Home(),
          Page2(),
          Page3(),
        ],
      ),
      bottomNavigationBar: BottomNavyBar(
        backgroundColor: Colors.black87,
        iconSize: 20,
        containerHeight: 50,
        selectedIndex: _currentIndex,
        onItemSelected: (index) {
          setState(() => _currentIndex = index);
          _pageController.jumpToPage(index);
        },
        items: [
          BottomNavyBarItem(
            icon: Icon(Icons.dashboard),
            title: Text('Dashboard'),
            activeColor: Colors.red,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.home_outlined),
            title: Text('Home'),
            activeColor: Colors.red,
          ),
          BottomNavyBarItem(
              icon: Icon(Icons.money_outlined),
              title: Text('Cash'),
              activeColor: Colors.purpleAccent),
          BottomNavyBarItem(
              icon: Icon(Icons.credit_card_rounded),
              title: Text('Messages'),
              activeColor: Colors.pink),
        ],
      ),
    );
  }
}
