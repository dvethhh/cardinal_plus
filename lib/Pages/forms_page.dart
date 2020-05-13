import 'package:cardinal_plus/Pages/tracking_page.dart';
import 'package:cardinal_plus/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:url_launcher/url_launcher.dart';

class Forms extends StatefulWidget {
  @override
  _FormsState createState() => _FormsState();
}

class _FormsState extends State<Forms> {
  String _fileName, _emailRecepient;
  var selectedDepartment, selectedForm;
  bool downloading = false;


  Future launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: false, forceWebView: false);
    } else {
      print("Can't Launch $url");
    }
  }

  Future<void> createTransaction() async {
    final FirebaseUser user = await FirebaseAuth.instance.currentUser();
    final userid = user.uid;
    print(userid);
    final CollectionReference transactions = Firestore.instance
        .collection('transactions')
        .document("$userid")
        .collection('submittedforms');
    DateTime now = DateTime.now();
    now = DateTime(now.year, now.month, now.day, now.hour, now.minute);
    return await transactions.document().setData({
      'department': selectedDepartment,
      'form': selectedForm,
      'createdOn': now.toString().substring(0, 16),
      'status': "Open",
    });
  }


  Future<void> _sendEmail() async {
    final Directory directory = await getExternalStorageDirectory();
    DocumentSnapshot snapshot = await Firestore.instance
        .collection("department")
        .document(selectedDepartment)
        .get();
    _emailRecepient = snapshot.data['email'];
    final Email email = Email(
      body: 'Please see attached form.',
      subject: '$selectedForm | Sent From Cardinal+ Mobile App',
      recipients: ['$_emailRecepient'],
      attachmentPaths: ['${directory.path}/$_fileName'],
      isHTML: false,
    );
    print(_emailRecepient);

    return await FlutterEmailSender.send(email);
  }

  Future<Null> downloadFile(String fileName) async {
    try {
      final StorageReference ref =
          FirebaseStorage.instance.ref().child(fileName);
      final String url = await ref.getDownloadURL();
      launchURL(url);
      print(url);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<File> uploadFile() async {
    File file = await FilePicker.getFile();
    final Directory directory = await getApplicationDocumentsDirectory();
    return new File('$directory.path/$file');
  }

  Future<String> _getFileName() async {
    DocumentSnapshot snapshot = await Firestore.instance
        .collection("department")
        .document(selectedDepartment)
        .collection('forms')
        .document(selectedForm)
        .get();
    _fileName = snapshot.data['filename'];
    print(_fileName);
    return _fileName;
  }

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
              'Submitted Forms',
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
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(width: 50.0),
                          DropdownButton(
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
                        String _formFormatted;
                        DocumentSnapshot snap = snapshot.data.documents[i];
                        if (snap.documentID.length < 25)
                          _formFormatted = snap.documentID;
                        else
                          _formFormatted = snap.documentID.substring(0, 20);
                        forms.add(
                          DropdownMenuItem(
                            child: Text(
                              _formFormatted,
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
                              final snackBar = SnackBar(
                                content: Text(
                                  'Selected Form is $formValue',
                                ),
                              );
                              Scaffold.of(context).showSnackBar(snackBar);
                              setState(() {
                                selectedForm = formValue;
                                _getFileName();
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
              SizedBox(
                height: 40.0,
              ),
              ButtonBar(
                buttonPadding: EdgeInsets.all(8),
                buttonMinWidth: 150,
                buttonHeight: 60,
                mainAxisSize: MainAxisSize.min,
                alignment: MainAxisAlignment.center,
                children: <Widget>[
                  //download button
                  Tooltip(
                    message: 'Download Selected Form',
                    child: FlatButton(
                        shape: StadiumBorder(),
                        color: Colors.blue[800],
                        child: Column(
                          children: <Widget>[
                            Icon(Icons.cloud_download),
                            Text('Download Form',
                                style: TextStyle(color: Colors.white)),
                          ],
                        ),
                        onPressed: () async {
                          await downloadFile(_fileName);
                          // Navigator.push(context,
                          //     MaterialPageRoute(builder: (context) => FormView()));
                        }),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  FlatButton(
                    shape: StadiumBorder(),
                    color: Colors.blue[800],
                    onPressed: () {
                      uploadFile();
                    },
                    child: Column(
                      children: <Widget>[
                        Icon(Icons.file_upload),
                        Text('Upload Form',
                            style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  FlatButton(
                    shape: StadiumBorder(),
                    color: Colors.green[800],
                    onPressed: () {
                      if (selectedDepartment == null || selectedForm == null)
                        return null;
                      else {
                        _sendEmail();
                        createTransaction();
                      }
                    },
                    child: Column(children: <Widget>[
                      Icon(Icons.send),
                      Text('Send Form', style: TextStyle(color: Colors.white)),
                    ]),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  //Something Something code code

}
