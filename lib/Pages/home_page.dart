import 'package:cardinal_plus/announcements.dart';
import 'package:flutter/material.dart';
import 'package:cardinal_plus/card_announcement.dart';

void main() => runApp(MaterialApp(
      home: HomePage(),
    ));

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Announcements> announcements = [
    Announcements(
        author: 'School of Information Technology',
        message: 'Announcement 1',
        date: '01/06/2020'),
    Announcements(
        author: 'Registrar',
        message: 'Section clearing on 02/10/2020',
        date: '02/07/2020'),
    Announcements(
        author: 'Customer Service',
        message: 'We are open!',
        date: '01/31/2020'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Announcements'),
        backgroundColor: Colors.red[800],
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage('assets/background.png'),
          fit: BoxFit.fill,
        )),
        child: Column(
          children: announcements
              .map((announcement) => CardAnnouncement(
                    announcements: announcement,
                  ))
              .toList(),
        ),
      ),
    );
  }
}
