import 'package:cardinal_plus/Pages/sendmessage.dart';
import 'package:cardinal_plus/transactions.dart';
import 'package:cardinal_plus/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Pages/settings_form.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CardTracking extends StatefulWidget {
  @override
  _CardTrackingState createState() => _CardTrackingState();
}

class _CardTrackingState extends State<CardTracking> {
  List<Transactions> listTransactions = [];
  Transactions transaction;
  @override
  Widget build(BuildContext context) {
    final _user = Provider.of<User>(context);
    void _showActionPanel(String docid) {
      showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
              child: RatingForm(docid: docid),
            );
          });
    }

    void _showMessagePanel(String docid) {
      showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
              child: SendMessage(
                docid: docid,
              ),
            );
          });
    }

    return StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance
            .collection('transactions')
            .document(_user.uid)
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
                transaction = Transactions(
                  department: snap.data['department'],
                  formName: snap.data['form'],
                  createdOn: snap.data['createdOn'],
                  status: snap.data['status'],
                  transactionId: snap.documentID,
                  remarks: snap.data['remarks'],
                ),
              );
            }
            return Expanded(
              child: ListView.builder(
                  itemCount: listTransactions.length,
                  itemBuilder: (context, index) {
                    return Card(
                      key: Key("$index"),
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
                              onPressed: () => _showMessagePanel(
                                  listTransactions[index].transactionId),
                            ),
                            FlatButton(
                              color: Colors.green[300],
                              child: Text(
                                'Review Transaction',
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () {
                                if (listTransactions[index].status != 'Open')
                                  _showActionPanel(
                                      listTransactions[index].transactionId);
                                else
                                  return null;
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
