import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:cardinal_plus/cardformessages.dart';
import '../adminmessage.dart';

class Announcements extends StatefulWidget {
  @override
  _AnnouncementsState createState() => _AnnouncementsState();
}

class _AnnouncementsState extends State<Announcements> {
  @override
  List<Messages> messageslist = [];
  Messages messages;

  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection('announcement').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Scaffold(
              body: Text("No announcements!"),
              appBar: AppBar(
                  title: Text('Announcements'),
                  backgroundColor: Colors.red[800]),
            );
          } else
            for (int i = 0; i < snapshot.data.documents.length; i++) {
              DocumentSnapshot snap = snapshot.data.documents[i];
              messageslist.add(
                messages = Messages(
                    department: snap.data['department'],
                    title: snap.data['title'],
                    timestamp: snap.data['timestamp'],
                    announcement: snap.data['announcement']),
              );
            }
          return Scaffold(
            body: ListView.builder(
                itemCount: messageslist.length,
                itemBuilder: (context, index) {
                  return Card(
                    key: Key("$index"),
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          title: Text(
                            messageslist[index].title,
                            style: TextStyle(fontSize: 20.0),
                          ),
                          subtitle: Text(
                              ' ${messageslist[index].announcement} -- Posted on ${messageslist[index].timestamp} from ${messageslist[index].department}',
                              style: TextStyle(fontSize: 14.0)),
                        ),
                      ],
                    ),
                  );
                }),
            appBar: AppBar(
                title: Text('Announcements'), backgroundColor: Colors.red[800]),
          );
        });
  }
}
