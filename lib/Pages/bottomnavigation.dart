import 'package:cardinal_plus/Pages/blackboardchoice.dart';
import 'package:cardinal_plus/Pages/mymapua.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'forms_page.dart';
import 'home_page.dart';
import 'profile_page.dart';

class MyBottomNavigation extends StatefulWidget {
  @override
  __MyBottomNavigationState createState() => __MyBottomNavigationState();
}

class __MyBottomNavigationState extends State<MyBottomNavigation> {
  int _currentIndex = 0;
  List<Widget> _pages = [
    HomePage(),
    BlackBoardChoice(),
    MyMapua(),
    Forms(),
    ProfilePage()
  ];
  FirebaseUser user;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _pages[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.shifting,
          currentIndex: _currentIndex,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('Home'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.subject),
              title: Text('Blackboard'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.school),
              title: Text('MyMapúa'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              title: Text('Search Forms'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              title: Text('Profile'),
            ),
          ],
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          unselectedItemColor: Colors.black,
          selectedItemColor: Colors.red[800],
        ));
  }
}
