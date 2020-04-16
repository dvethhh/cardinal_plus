import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MyMapua extends StatefulWidget {
  @override
  _MyMapuaState createState() => _MyMapuaState();
}

class _MyMapuaState extends State<MyMapua> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text("MyMapúa"),
          backgroundColor: Colors.red[800],
        ),
        body: WebView(
          
          javascriptMode: JavascriptMode.unrestricted,
          initialUrl: "https://my.mapua.edu.ph/",
        ));
  }
}
