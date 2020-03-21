import 'package:cardinal_plus/Pages/tracking_page.dart';
import 'package:flutter/material.dart';

class Forms extends StatefulWidget {
  final Function toggleView;
  Forms({this.toggleView});

  @override
  _FormsState createState() => _FormsState();
}

class _FormsState extends State<Forms> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Forms Pages',
        ),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(
              Icons.search,
              color: Colors.white,
            ),
            label: Text(
              'Tracking Page',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TrackingPage()),
              );
            },
          ),
        ],
        backgroundColor: Colors.red[800],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20.0, 8.0, 20.0, 0),
        child: Column(
          children: <Widget>[
            Text('Choose Department',
                style: TextStyle(
                  fontSize: 18,
                )),
            SizedBox(height: 18),
            DropdownButtonFormField(
              hint: Text('School of Information Technology'),
              items: List<DropdownMenuItem>(),
            ),
            SizedBox(height: 18),
            DropdownButtonFormField(
              hint: Text('ETY'),
              items: List<DropdownMenuItem>(),
            ),
          ],
        ),
      ),
    );
  }
}
