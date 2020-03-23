import 'package:cardinal_plus/user.dart';
import 'package:flutter/material.dart';
import 'package:cardinal_plus/services/auth.dart';
import 'package:cardinal_plus/services/database.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();
  bool loading = false;

  String email = '';
  String password = '';
  String error = '', _studentNumber;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: _studentNumber).userData,
      builder: (context, snapshot) {
        UserData userData = snapshot.data;
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.red[800],
            title: Text('Sign In'),
            actions: <Widget>[
              FlatButton.icon(
                icon: Icon(
                  Icons.person,
                  color: Colors.white,
                ),
                label: Text(
                  'Register',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () => widget.toggleView(),
              ),
            ],
          ),
          backgroundColor: Colors.grey[120],
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
              child: Form(
                key: _formkey,
                child: Column(
                  children: <Widget>[
                    CircleAvatar(
                      backgroundColor: Colors.yellow[200],
                      backgroundImage: AssetImage('assets/mapualogo.png'),
                      radius: 70.0,
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      validator: (val) =>
                          val.isEmpty ? 'Enter Information' : null,
                      onChanged: (val) {
                        setState(() => _studentNumber = val);
                      },
                      decoration: const InputDecoration(
                        icon: Icon(Icons.format_list_numbered),
                        labelText: 'STUDENT NUMBER',
                      ),
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      obscureText: true,
                      validator: (val) =>
                          val.isEmpty ? 'Enter Information' : null,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.lock),
                        hintText: 'Enter a strong password',
                        labelText: 'PASSWORD',
                      ),
                      onChanged: (val) {
                        setState(() => password = val);
                      },
                    ),
                    SizedBox(height: 20.0),
                    ButtonBar(children: <Widget>[
                      FlatButton(
                        onPressed: () async {
                          if (_formkey.currentState.validate()) {
                            loading = true;
                            dynamic result =
                                await _auth.signInWithEmailAndPassword(
                                    userData.email, password);
                            print(userData.email);

                            AlertDialog(
                              content: Text(error),
                            );
                            if (result == null) {
                              loading = false;
                            }
                          }
                        },
                        color: Colors.red[800],
                        child: Text(
                          'SIGN IN',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      FlatButton(
                        color: Colors.white,
                        onPressed: () {
                          Scaffold.of(context).showSnackBar(SnackBar(
                            content: Text('Yay! A SnackBar!'),
                          ));
                        },
                        child: Text('Forgot Password?'),
                      ),
                    ])
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
