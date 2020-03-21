import 'package:cardinal_plus/user.dart';
import 'package:flutter/material.dart';
import 'package:cardinal_plus/services/auth.dart';
import 'package:cardinal_plus/shared/loading.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  final Function toggleView;
  RegisterPage({this.toggleView});
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();

  String _studentNumber = '';
  String error = '', _password;
  bool loading = false;

  UserData userData;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return loading
        ? Loading()
        : Scaffold(
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
            body: Center(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
                child: Form(
                  key: _formkey,
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 120.0),
                      TextFormField(
                        inputFormatters: [
                          WhitelistingTextInputFormatter.digitsOnly
                        ],
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
                      SizedBox(height: 20.0),
                      RaisedButton(
                        onPressed: () async {
                          userData = UserData(studentNumber: _studentNumber);

                          print(userData.studentNumber);

                          if (_formkey.currentState.validate()) {
                            dynamic result =
                                await _auth.registerWithEmailAndPassword(
                                    _studentNumber, _password);

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
  }
}
