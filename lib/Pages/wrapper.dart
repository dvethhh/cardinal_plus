import 'package:cardinal_plus/authenticate/authenticate.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cardinal_plus/user.dart';
import 'package:cardinal_plus/Pages/bottomnavigation.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);
    print(user);

    // return either the Home or Authenticate widget
    if (user == null){
      return Authenticate();
    } else {
      return MyBottomNavigation();
    }

  }
}