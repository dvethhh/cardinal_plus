import 'package:cardinal_plus/Pages/announcements.dart';
import 'package:cardinal_plus/Pages/blackboard.dart';
import 'package:cardinal_plus/Pages/blackboardchoice.dart';
import 'package:cardinal_plus/Pages/mymapua.dart';
import 'package:cardinal_plus/services/auth.dart';
import 'package:cardinal_plus/tileinfo.dart';
import 'package:flutter/material.dart';
import 'package:cardinal_plus/card_announcement.dart';

import 'forms_page.dart';

void main() => runApp(MaterialApp(
      home: HomePage(),
    ));

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

final AuthService _auth = AuthService();

class _HomePageState extends State<HomePage> {
  List<TileInfo> announcements = [
    TileInfo(
        picture: 'assets/bbicon.png',
        title: 'Blackboard',
        description: 'Go to Blackboard',
        widget: BlackBoardChoice()),
    TileInfo(
        picture: 'assets/mapualogo.png',
        title: 'MyMapua',
        description: 'Login to MyMapúa',
        widget: MyMapua()),
    TileInfo(
        picture: 'assets/forms.png',
        title: 'Forms',
        description: 'Search Forms',
        widget: Forms()),
    TileInfo(
        picture: 'assets/announcements.png',
        title: 'Announcements',
        description: 'Check Announcements'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cardinal+'),
        backgroundColor: Colors.red[800],
        actions: <Widget>[
          FlatButton.icon(
            textColor: Colors.white,
            label: Text('Logout'),
            icon: Icon(Icons.exit_to_app),
            onPressed: () async {
              await _auth.signOut();
            },
          )
        ],
      ),
      body: GridView.count(
        crossAxisCount: 2,
        padding: EdgeInsets.all(16.0),
        childAspectRatio: 8.0 / 9.0,
        children: announcements
            .map((announcement) => CardTiles(
                  tileInfo: announcement,
                ))
            .toList(),
      ),
    );
  }
}
