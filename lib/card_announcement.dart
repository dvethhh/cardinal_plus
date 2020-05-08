import 'package:flutter/material.dart';
import 'package:cardinal_plus/tileinfo.dart';

class CardTiles extends StatelessWidget {
  final TileInfo tileInfo;
  CardTiles({this.tileInfo});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Card(
          color: Colors.grey[300],
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => tileInfo.widget));
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                AspectRatio(
                  aspectRatio: 18.0 / 11.0,
                  child: Image.asset(tileInfo.picture),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(tileInfo.title, style: theme.textTheme.headline6),
                      SizedBox(height: 8.0),
                      Text(tileInfo.description, style: theme.textTheme.bodyText1),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
