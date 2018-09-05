import 'package:flutter/material.dart';
import 'package:flutter-boilerplate/services/auth.dart';

class Landing extends StatelessWidget {
  final AuthService auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RaisedButton(
          child: Text('GOOGLE LOGIN'),
          onPressed: auth.handleGoogleSignin,
        ),
      ),
    );
  }
}
