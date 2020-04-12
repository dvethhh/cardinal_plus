import 'package:cardinal_plus/Pages/sendmessage.dart';
import 'package:flutter/material.dart';
import 'Pages/settings_form.dart';

class CardTracking extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    void _showActionPanel() {
      showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
              child: RatingForm(),
            );
          });
    }

    void _showMessagePanel() {
      showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
              child: SendMessage(),
            );
          });
    }

    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: Column(
          children: <Widget>[
            ListTile(
              onTap: () => _showActionPanel(),
              trailing: Icon(
                Icons.rate_review,
                color: Colors.yellow[600],
              ),
              title: Text(
                'name of form',
                style: TextStyle(fontSize: 22.0),
              ),
              subtitle: Text('Status - Date Completed'),
            ),
            ButtonBar(children: <Widget>[
              FlatButton(
                color: Colors.blue[300],
                child: Text(
                  'Send Message',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () => _showMessagePanel(),
              ),
              FlatButton(
                color: Colors.green[300],
                child: Text(
                  'Review Transaction',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () => _showActionPanel(),
              ),
            ])
          ],
        ),
      ),
    );
  }
}
