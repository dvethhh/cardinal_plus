import 'package:flutter/material.dart';
import 'adminmessage.dart';

class CardAnnouncements extends StatelessWidget {
  final Messages messages;
  CardAnnouncements({this.messages});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Card(
          child: ListTile(
            isThreeLine: true,
            title: Text(messages.title),
            subtitle: Text(
                "${messages.announcement} -- Posted on ${messages.timestamp} from ${messages.department}"),
          ),
        ));
  }
}
