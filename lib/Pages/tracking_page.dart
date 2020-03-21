import 'package:flutter/material.dart';
import 'package:cardinal_plus/card_tracking.dart';

class TrackingPage extends StatefulWidget {
  final Function toggleView;
  TrackingPage({this.toggleView});
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
              'Tracking Page',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () => widget.toggleView(),
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
