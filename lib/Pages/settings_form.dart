import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> rating = ['1', '2', '3', '4', '5'];

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Text(
            'Rate this Transaction.',
            style: TextStyle(fontSize: 18.0),
          ),
          SizedBox(height: 20.0),
          // Slider(
          //   value: _rating,
          //   min: 1,
          //   max: 5,
          //   divisions: 4,
          //   label: _rating.toInt().toString(),
          //   onChanged: (val) => setState(() => _rating = val),
          // ),

          //Rating Bar
          RatingBar(
            initialRating: 5,
            itemCount: 5,
            itemBuilder: (context, index) {
              switch (index) {
                case 0:
                  return Icon(
                    Icons.sentiment_very_dissatisfied,
                    color: Colors.red,
                  );
                case 1:
                  return Icon(
                    Icons.sentiment_dissatisfied,
                    color: Colors.redAccent,
                  );
                case 2:
                  return Icon(
                    Icons.sentiment_neutral,
                    color: Colors.amber,
                  );
                case 3:
                  return Icon(
                    Icons.sentiment_satisfied,
                    color: Colors.lightGreen,
                  );
                case 4:
                  return Icon(
                    Icons.sentiment_very_satisfied,
                    color: Colors.green,
                  );
              }
            },
            onRatingUpdate: (rating) {
              print(rating);
            },
          ),

          SizedBox(height: 10.0),
          Text('Reason For This Rating'),
          TextFormField(
            maxLines: 2,
            maxLength: 140,
            validator: (val) =>
                val.isEmpty ? 'Please Rate This Transaction' : null,
          ),
          SizedBox(height: 10.0),
          RaisedButton(
              color: Colors.red[400],
              child: Text(
                'Review',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () async {}),
        ],
      ),
    );
  }
}
