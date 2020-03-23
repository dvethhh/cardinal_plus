import 'package:cardinal_plus/services/auth.dart';
import 'package:cardinal_plus/tileinfo.dart';
import 'package:flutter/material.dart';
import 'package:cardinal_plus/card_announcement.dart';

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
        description: 'Go to Blackboard'),
    TileInfo(
        picture: 'assets/mapualogo.png',
        title: 'MyMapua',
        description: 'Login to MyMapúa'),
    TileInfo(
        picture: 'assets/forms.png',
        title: 'Forms',
        description: 'Search Forms'),
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
