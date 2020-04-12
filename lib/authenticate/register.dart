import 'package:cardinal_plus/services/database.dart';
import 'package:cardinal_plus/user.dart';
import 'package:flutter/material.dart';
import 'package:cardinal_plus/services/auth.dart';
import 'package:cardinal_plus/shared/loading.dart';
import 'package:flutter/services.dart';

class RegisterPage extends StatefulWidget {
  final Function toggleView;
  RegisterPage({this.toggleView});
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();

  String _studentNumber = '', error = '', _password, _email, _name;
  bool loading = false;

  UserData userData;

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : StreamBuilder<StudentNumber>(
            stream: DatabaseService(uid: 'studentnumber').studentNumberCheck,
            builder: (context, snapshot) {
              StudentNumber studentNumber = snapshot.data;
              return Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.red[800],
                  title: Text('Register'),
                  actions: <Widget>[
                    FlatButton.icon(
                      icon: Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                      label: Text(
                        'Sign In',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () => widget.toggleView(),
                    ),
                  ],
                ),
                body: SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
                    child: Form(
                      key: _formkey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          TextFormField(
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              WhitelistingTextInputFormatter.digitsOnly
                            ],
                            maxLengthEnforced: true,
                            maxLength: 10,
                            validator: (val) => val.length < 10
                                ? 'Enter Correct Student Number'
                                : null,
                            decoration: const InputDecoration(
                              icon: Icon(Icons.format_list_numbered),
                              labelText: 'STUDENT NUMBER',
                            ),
                            onChanged: (val) {
                              setState(() => _studentNumber = val);
                            },
                          ),
                          TextFormField(
                              validator: (val) =>
                                  val.isEmpty ? 'Enter Information' : null,
                              decoration: const InputDecoration(
                                icon: Icon(Icons.person),
                                hintText: 'Enter Full Name',
                                labelText: 'NAME',
                              ),
                              onChanged: (val) {
                                setState(() => _name = val);
                              }),
                          TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              validator: (val) =>
                                  val.isEmpty ? 'Enter Information' : null,
                              decoration: const InputDecoration(
                                icon: Icon(Icons.alternate_email),
                                hintText: 'Enter a valid Mapúa Email',
                                labelText: 'EMAIL',
                              ),
                              onChanged: (val) {
                                setState(() => _email = val.trim());
                              }),
                          TextFormField(
                            obscureText: true,
                            validator: (val) =>
                                val.isEmpty ? 'Enter Information' : null,
                            decoration: const InputDecoration(
                              icon: Icon(Icons.lock),
                              hintText: 'enter a strong password',
                              labelText: 'PASSWORD',
                            ),
                            onChanged: (val) {
                              setState(() => _password = val);
                            },
                          ),
                          RaisedButton(
                            onPressed: () async {
                              userData = UserData(
                                  email: _email,
                                  studentNumber: _studentNumber,
                                  name: _name);
                              if (_formkey.currentState.validate()) {
                                dynamic result =
                                    await _auth.registerWithEmailAndPassword(
                                        _email, _password);

                                await DatabaseService(uid: _studentNumber)
                                    .updateUserData(
                                        _name, _studentNumber, _email);
                                print(userData.email);

                                if (result == null) {
                                  setState(() {
                                    error = 'Incorrect Student Number';
                                    print(error);
                                  });
                                }
                              }
                            },
                            color: Colors.red[800],
                            child: Text(
                              'REGISTER',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            });
  }
}
