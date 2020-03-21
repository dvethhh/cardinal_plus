import 'package:flutter/material.dart';
import 'Pages/settings_form.dart';

class CardTracking extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    void _showSettingsPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
              child: SettingsForm(),
            );
          });
    }

    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          onTap: () => _showSettingsPanel(),
          trailing: Icon(
            Icons.rate_review,
            color: Colors.blue,
          ),
          title: Text(
            'name of form',
            style: TextStyle(fontSize: 22.0),
          ),
          subtitle: Text('Status- Date Completed'),
        ),
      ),
    );
  }
}
