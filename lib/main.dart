import 'package:cardinal_plus/services/auth.dart';
import 'package:cardinal_plus/user.dart';
import 'package:flutter/material.dart';
import 'Pages/wrapper.dart';
import 'package:provider/provider.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}
