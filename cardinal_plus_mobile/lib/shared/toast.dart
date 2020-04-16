import 'package:flutter/material.dart';

class Toast extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SnackBar(
        content: Text('Information Updated'),
      ),
    );
  }
}
