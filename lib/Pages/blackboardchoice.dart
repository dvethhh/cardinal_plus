import 'package:flutter/material.dart';

class BlackBoardChoice extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          onTap: () {},
          title: Text(
            'BlackBoard',
            style: TextStyle(fontSize: 22.0),
          ),
          subtitle: Text('Download From '),
        ),
      ),
    );
  }
}
