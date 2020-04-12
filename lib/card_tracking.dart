import 'package:cardinal_plus/Pages/sendmessage.dart';
import 'package:cardinal_plus/transactions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'Pages/settings_form.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CardTracking extends StatefulWidget {
  final String userid;
  CardTracking({this.userid});
  @override
  _CardTrackingState createState() => _CardTrackingState();
}

List<Transactions> listTransactions = [];
Transactions transaction;

class _CardTrackingState extends State<CardTracking> {
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

    Future<void> _getUserid() async {
      final FirebaseUser user = await FirebaseAuth.instance.currentUser();
      final String userid = user.uid;
      return userid;
    }

    _getUserid();
    return StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance
            .collection('transactions')
            .document("ySyGlewJbbNkfsffu8YXfPnjK973")
            .collection('submittedforms')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator(
              backgroundColor: Colors.red,
            );
          } else {
            for (int i = 0; i < snapshot.data.documents.length; i++) {
              DocumentSnapshot snap = snapshot.data.documents[i];
              listTransactions.add(
                transaction = new Transactions(
                    department: snap.data['department'],
                    formName: snap.data['form'],
                    createdOn: snap.data['createdOn'],
                    status: snap.data['status'],
                    transactionId: snap.documentID,
                    remarks: snap.data['remarks']),
              );
            }
            return Expanded(
              child: new ListView.builder(
                  itemCount: listTransactions.length,
                  itemBuilder: (context, index) {
                    return new Card(
                      child: Column(
                        children: <Widget>[
                          ListTile(
                            title: Text(
                              listTransactions[index].formName,
                              style: TextStyle(fontSize: 20.0),
                            ),
                            subtitle: Text(
                                'Status - ${listTransactions[index].status} - Submitted on ${listTransactions[index].createdOn} to ${listTransactions[index].department}',
                                style: TextStyle(fontSize: 14.0)),
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
                              onPressed: () {
                                if (listTransactions[index].status != 'Open')
                                  _showActionPanel();
                                else
                                  null;
                              },
                            ),
                          ])
                        ],
                      ),
                    );
                  }),
            );
          }
        });
  }
}
