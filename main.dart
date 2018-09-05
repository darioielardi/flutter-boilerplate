import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter-boilerplate/blocs/bloc-provider.dart';
import 'package:flutter-boilerplate/blocs/state-storage.dart';
import 'package:flutter-boilerplate/blocs/user-bloc.dart';
import 'package:flutter-boilerplate/models/user.dart';
import 'package:flutter-boilerplate/pages/landing.dart';
import 'package:flutter-boilerplate/services/auth.dart';
import 'package:flutter-boilerplate/widgets/user-fetcher.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  StateStorage.prefs = await SharedPreferences.getInstance();

  final userBloc = UserBloc();
  runApp(App(userBloc));
}

class App extends StatefulWidget {
  final UserBloc userBloc;

  App(this.userBloc);

  @override
  AppState createState() => AppState();
}

class AppState extends State<App> {
  final AuthService _auth = AuthService();

  DocumentReference userRef;

  initState() {
    super.initState();
    _auth.state.listen((user) {
      if (user == null) {
        widget.userBloc.setUser(null);
      } else {
        _auth.handleUserLoggedIn(user).then((ref) {
          ref.get().then((userDoc) {
            var user = UserModel.fromMap(userDoc.data..addAll({'id': userDoc.documentID}));
            widget.userBloc.setUser(user);
          });
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserBloc>(
      bloc: widget.userBloc,
      child: MaterialApp(
        title: 'Flutter Boilerplate',
        home: StreamBuilder<UserModel>(
          stream: widget.userBloc.stream,
          builder: (ctx, snap) => snap.hasData ? UserFetcher(widget.userBloc) : Landing(),
        ),
      ),
    );
  }
}
