import 'package:cardinal_plus/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class RatingForm extends StatefulWidget {
  final String docid;
  RatingForm({this.docid});
  @override
  _RatingFormState createState() => _RatingFormState();
}

String _review;
double _rating;

class _RatingFormState extends State<RatingForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> rating = ['1', '2', '3', '4', '5'];

  @override
  Widget build(BuildContext context) {
    final _user = Provider.of<User>(context);

    Future<void> _writeReview(String review, double rating) async {
      final CollectionReference transactions = Firestore.instance
          .collection('transactions')
          .document(_user.uid)
          .collection('submittedforms');

      return await transactions
          .document(widget.docid)
          .setData({'review': review, 'ratings': rating});
    }

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

                  break;
                case 1:
                  return Icon(
                    Icons.sentiment_dissatisfied,
                    color: Colors.redAccent,
                  );

                  break;
                case 2:
                  return Icon(
                    Icons.sentiment_neutral,
                    color: Colors.amber,
                  );

                  break;
                case 3:
                  return Icon(
                    Icons.sentiment_satisfied,
                    color: Colors.lightGreen,
                  );

                  break;
                case 4:
                  return Icon(
                    Icons.sentiment_very_satisfied,
                    color: Colors.green,
                  );
              }
            },
            onRatingUpdate: (rating) {
              print(rating);
              setState(() => _rating = rating);
            },
          ),

          SizedBox(height: 10.0),
          Text('Reason For This Rating'),
          TextFormField(
            maxLines: 2,
            maxLength: 140,
            validator: (val) =>
                val.isEmpty ? 'Please Rate This Transaction' : null,
            onChanged: (val) {
              setState(() => _review = val);
            },
          ),
          SizedBox(height: 10.0),
          RaisedButton(
              color: Colors.red[400],
              child: Text(
                'Review',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () async {
                print(_rating);
                _writeReview(_review, _rating);
              }),
        ],
      ),
    );
  }
}
