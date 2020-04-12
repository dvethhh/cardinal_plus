import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';

class SubmitForm extends StatefulWidget {
  @override
  _SubmitFormState createState() => _SubmitFormState();
}

String createTransaction() {
  String transactionNumber;

 return transactionNumber = Timestamp.now().toString();
}

final CollectionReference reference = Firestore.instance.collection('transactions');

class _SubmitFormState extends State<SubmitForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RaisedButton(
          child: Text('Submit'),
          onPressed: () {},
        ),
      ),
    );
  }
}
