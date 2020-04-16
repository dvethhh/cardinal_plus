import 'package:cardinal_plus/Pages/blackboard.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io' show Platform;

Future launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url, forceSafariVC: true, forceWebView: true);
  } else {
    print("Can't Launch $url");
  }
}

String _downloadFrom() {
  String iosOrAndroid;
  if (Platform.isAndroid) {
    iosOrAndroid = 'Download From Play Store';
  } else {
    iosOrAndroid = 'Download From App Store';
  }
  return iosOrAndroid;
}

const String url =
    'https://play.google.com/store/apps/details?id=com.blackboard.android.bbstudent&hl=en';

class BlackBoardChoice extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Blackboard'),
        backgroundColor: Colors.red[800],
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Card(
              shape: BeveledRectangleBorder(
                side: BorderSide(
                  color: Colors.black,
                  width: 1.0,
                ),
              ),
              child: ListTile(
                leading: Image.asset('assets/bbplaystore.png'),
                onTap: () => launchURL(url),
                title: Text(
                  'BlackBoard App',
                  style: TextStyle(fontSize: 22.0),
                ),
                subtitle: Text(_downloadFrom()),
              ),
            ),
            Card(
              shape: BeveledRectangleBorder(
                side: BorderSide(
                  color: Colors.black,
                  width: 1.0,
                ),
              ),
              child: ListTile(
                leading: Image.asset('assets/bbicon.png'),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => BlackBoard()));
                },
                title: Text(
                  'BlackBoard Web',
                  style: TextStyle(fontSize: 22.0),
                ),
                subtitle: Text('Go to Blackboard'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
