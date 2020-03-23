import 'package:cardinal_plus/services/auth.dart';
import 'package:cardinal_plus/services/database.dart';
import 'package:cardinal_plus/shared/toast.dart';
import 'package:flutter/material.dart';
import 'package:cardinal_plus/user.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();

  final AuthService _auth = AuthService();
  UserData userData;
  String _name;
  String _studentNumber;
  String _email;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Colors.red[800],
        actions: <Widget>[
          FlatButton.icon(
            textColor: Colors.white,
            label: Text('Logout'),
            icon: Icon(Icons.exit_to_app),
            onPressed: () async {
              await _auth.signOut();
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 0.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Center(
                  child: CircleAvatar(
                    backgroundImage: AssetImage('assets/cardinaltwo.png'),
                    radius: 50.0,
                  ),
                ),
                TextFormField(
                  validator: (val) => val.isEmpty ? 'Enter Information' : null,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.person),
                    labelText: 'NAME',
                  ),
                  onChanged: (val) => setState(() => _name = val.toUpperCase()),
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                  maxLength: 10,
                  validator: (val) =>
                      val.length < 10 ? 'Enter Correct Student Number' : null,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.format_list_numbered),
                    labelText: 'STUDENT NUMBER',
                  ),
                  onChanged: (val) => setState(() => _studentNumber = val),
                ),
                SizedBox(height: 30.0),
                RaisedButton(
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                        await DatabaseService(uid: user.uid).updateUserData(
                            _name ?? userData.name,
                            _studentNumber ?? userData.studentNumber,
                            _email ?? userData.email);

                      print(_name);
                      print(_studentNumber);
                      print(user.uid);
                      Toast();
                    }
                  },
                  color: Colors.red[800],
                  child: Text(
                    'Update Info',
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
