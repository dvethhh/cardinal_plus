import 'package:cardinal_plus/Pages/mymapua.dart';
import 'package:flutter/material.dart';
import 'package:cardinal_plus/announcements.dart';


class CardAnnouncement extends StatelessWidget {
  final Announcements announcements;
  CardAnnouncement({this.announcements});



  @override
  Widget build(BuildContext context) {

 

    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(
        
        
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          onTap:  (){ } ,
          title: Text(announcements.message, style: TextStyle(
            fontSize: 22.0
          ),),
          subtitle: Text('${announcements.author} - ${announcements.date}'),
        ),
      ),
    );
  }
}
