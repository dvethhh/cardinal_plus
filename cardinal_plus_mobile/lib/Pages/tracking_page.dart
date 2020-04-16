import 'package:cardinal_plus/Pages/forms_page.dart';
import 'package:flutter/material.dart';
import 'package:cardinal_plus/card_tracking.dart';

class TrackingPage extends StatefulWidget {
  @override
  _TrackingPageState createState() => _TrackingPageState();
}

class _TrackingPageState extends State<TrackingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(
              Icons.event_note,
              color: Colors.white,
            ),
            label: Text(
              'Forms Page',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Forms()),
              );
            },
          ),
        ],
        backgroundColor: Colors.red[800],
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            SizedBox(height: 20),
            CardTracking(),
          ],
        ),
      ),
    );
  }
}
