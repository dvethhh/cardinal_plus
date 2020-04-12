import 'package:cardinal_plus/Pages/formview.dart';
import 'package:cardinal_plus/Pages/tracking_page.dart';
import 'package:cardinal_plus/transactions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

const String kTestString = 'Hello world!';
FirebaseUser user;
final CollectionReference transactions =
    Firestore.instance.collection('transactions');
String _fileName;
var selectedDepartment, selectedForm;

class Forms extends StatefulWidget {
  @override
  _FormsState createState() => _FormsState();
}

Future<void> createTransaction() async {
  return await transactions.document(user.uid).setData({
    'department': selectedDepartment,
    'form': selectedForm,
    'createdOn': DateTime.now(),
    'transactionId': Timestamp.fromMicrosecondsSinceEpoch(5),
    'status': "Open",
  });
}

final Email email = Email(
  body: 'Please see attached form.',
  subject: '$selectedForm | ',
  recipients: ['example@example.com'],
  cc: ['cc@example.com'],
  bcc: ['bcc@example.com'],
  attachmentPaths: ['/path/to/attachment.zip'],
  isHTML: false,
);

Future<Null> downloadFile(String fileName) async {
  final Directory directory = await getExternalStorageDirectory();
  final File file = File('${directory.path}/${fileName}');

  final StorageReference ref = FirebaseStorage.instance.ref().child(fileName);
  final StorageFileDownloadTask downloadTask = ref.writeToFile(file);

  final int byteNumber = (await downloadTask.future).totalByteCount;

  print(byteNumber);
}

Future<Null> uploadFile(String fileName) async {
  final Directory directory = await getExternalStorageDirectory();
}

void _getData() async {
  await Firestore.instance
      .collection("department/$selectedDepartment/forms/$selectedForm/filename")
      .getDocuments()
      .then((QuerySnapshot snapshot) {
    snapshot.documents.forEach((f) => print('${f.data}}'));
  });
}

class _FormsState extends State<Forms> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Forms Pages',
        ),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(
              Icons.search,
              color: Colors.white,
            ),
            label: Text(
              'Tracking Page',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TrackingPage()),
              );
            },
          ),
        ],
        backgroundColor: Colors.red[800],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20.0, 8.0, 20.0, 0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(height: 18),
              StreamBuilder<QuerySnapshot>(
                  stream:
                      Firestore.instance.collection("department").snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData)
                      return CircularProgressIndicator(
                        backgroundColor: Colors.red,
                      );
                    else {
                      List<DropdownMenuItem> departments = [];
                      for (int i = 0; i < snapshot.data.documents.length; i++) {
                        DocumentSnapshot snap = snapshot.data.documents[i];
                        departments.add(
                          DropdownMenuItem(
                            child: Text(
                              snap.documentID,
                              style: TextStyle(color: Colors.red[800]),
                            ),
                            value: "${snap.documentID}",
                          ),
                        );
                      }
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(width: 50.0),
                          Expanded(
                            child: DropdownButton(
                              items: departments,
                              onChanged: (departmentValue) {
                                selectedForm = null;
                                final snackBar = SnackBar(
                                  content: Text(
                                    'Selected Department is $departmentValue',
                                  ),
                                );
                                Scaffold.of(context).showSnackBar(snackBar);
                                setState(() {
                                  selectedDepartment = departmentValue;
                                });
                              },
                              value: selectedDepartment,
                              isExpanded: false,
                              hint: new Text(
                                "Choose Department",
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                  }),
              SizedBox(
                height: 40.0,
              ),
              StreamBuilder<QuerySnapshot>(
                  stream: Firestore.instance
                      .collection("department/$selectedDepartment/forms")
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData)
                      return CircularProgressIndicator(
                        backgroundColor: Colors.red,
                      );
                    else {
                      List<DropdownMenuItem> forms = [];
                      for (int i = 0; i < snapshot.data.documents.length; i++) {
                        DocumentSnapshot snap = snapshot.data.documents[i];
                        forms.add(
                          DropdownMenuItem(
                            child: Text(
                              snap.documentID,
                              style: TextStyle(color: Colors.red[800]),
                            ),
                            value: "${snap.documentID}",
                          ),
                        );
                      }
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          DropdownButton(
                            items: forms,
                            onChanged: (formValue) {
                              _getData();
                              final snackBar = SnackBar(
                                content: Text(
                                  'Selected Form is $formValue',
                                ),
                              );
                              Scaffold.of(context).showSnackBar(snackBar);
                              setState(() {
                                selectedForm = formValue;
                              });
                            },
                            value: selectedForm,
                            isExpanded: false,
                            hint: new Text(
                              "Choose Form",
                            ),
                          ),
                          SizedBox(width: 50.0),
                        ],
                      );
                    }
                  }),
              FlatButton(
                  color: Colors.red[800],
                  child:
                      Text('Open Form', style: TextStyle(color: Colors.white)),
                  onPressed: () async {
                    await downloadFile('request_to_complete.pdf');
                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (context) => FormView()));
                  }),
              SizedBox(
                height: 80.0,
              ),
              ButtonBar(
                children: <Widget>[
                  FlatButton(
                    color: Colors.red[800],
                    onPressed: () {},
                    child: Text('Upload Form',
                        style: TextStyle(color: Colors.white)),
                  ),
                  FlatButton(
                    color: Colors.red[800],
                    onPressed: () {
                      createTransaction();
                    },
                    child: Text('Send Form',
                        style: TextStyle(color: Colors.white)),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
