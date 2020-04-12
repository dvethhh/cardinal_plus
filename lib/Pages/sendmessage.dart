import 'package:flutter/material.dart';

class SendMessage extends StatefulWidget {
  @override
  _SendMessageState createState() => _SendMessageState();
}

class _SendMessageState extends State<SendMessage> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: <Widget>[
        Text('Send Message'),
        TextFormField(
          maxLines: 2,
          maxLength: 140,
          validator: (val) =>
              val.isEmpty ? 'Send a short message' : null,
        ),
        SizedBox(height: 10.0),
        RaisedButton(
            color: Colors.red[400],
            child: Text(
              'Send Message',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () async {}),
      ],
    ));
  }
}
