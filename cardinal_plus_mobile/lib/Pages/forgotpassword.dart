import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

final _formkey = GlobalKey<FormState>();
String _email;
FirebaseAuth user;

class _ForgotPasswordState extends State<ForgotPassword> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        key: _formkey,
        child: Column(
          children: <Widget>[
            TextFormField(
                keyboardType: TextInputType.emailAddress,
                validator: (val) => val.isEmpty ? 'Enter Information' : null,
                decoration: const InputDecoration(
                  icon: Icon(Icons.alternate_email),
                  hintText: 'Enter the email address you registered with',
                  labelText: 'EMAIL',
                ),
                onChanged: (val) {
                  setState(() => _email = val.trim());
                }),
            RaisedButton(
              color: Colors.red[800],
              child: Text('Send Password Reset Link!',
                  style: TextStyle(color: Colors.white)),
              onPressed: () async {
                try {
                  user.sendPasswordResetEmail(email: _email);
                } catch (e) {
                  print(e);
                }

                final snackBar = SnackBar(
                  content: Text(
                    'Check email to reset password!',
                  ),
                );
                Scaffold.of(context).showSnackBar(snackBar);
              },
            )
          ],
        ),
      ),
    );
  }
}
