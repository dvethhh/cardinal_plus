import 'package:cardinal_plus/Pages/forms_page.dart';
import 'package:cardinal_plus/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SendMessage extends StatefulWidget {
  final String docid;
  SendMessage({this.docid});
  @override
  _SendMessageState createState() => _SendMessageState();
}

final _formkey = GlobalKey<FormState>();
String _message;

Future<Widget> createAlertDialog(BuildContext context) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Message Sent!'),
          content: const Text('Press ok to go back'),
          actions: <Widget>[
            FlatButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Forms(),
                    ));
              },
            )
          ],
        );
      });
}

var _controller = TextEditingController();

class _SendMessageState extends State<SendMessage> {
  @override
  Widget build(BuildContext context) {
    final _user = Provider.of<User>(context);

    Future<void> _sendMessage(String message) async {
      final CollectionReference transactions = Firestore.instance
          .collection('transactions')
          .document(_user.uid)
          .collection('submittedforms')
          .document(widget.docid)
          .collection('remarks');

      return await transactions.document('studentMessage').setData({
        'student': message,
      });
    }

    return Container(
        child: Form(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 40,
          ),
          Text('Send Message'),
          TextFormField(
            controller: _controller,
            maxLines: 2,
            maxLength: 140,
            validator: (val) => val.isEmpty ? 'Send Short Message' : null,
            onChanged: (val) {
              setState(() => _message = val);
            },
          ),
          SizedBox(height: 10.0),
          FlatButton(
              color: Colors.blue[800],
              child: Text(
                'Send Message',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                print(_message);
                _sendMessage(_message);
                _controller.clear();
                createAlertDialog(context);
              }),
        ],
      ),
    ));
  }
}
