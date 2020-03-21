import 'package:flutter/material.dart';


import 'package:webview_flutter/webview_flutter.dart';

class BlackBoard extends StatefulWidget {
  @override
  _BlackBoardState createState() => _BlackBoardState();
}

class _BlackBoardState extends State<BlackBoard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("BlackBoard"),
              backgroundColor: Colors.red[800],
      ),
      body: WebView(
         
        javascriptMode: JavascriptMode.unrestricted,
        initialUrl: "https://mapua.BlackBoard.com/",
        
      )
      
    );
  }
}