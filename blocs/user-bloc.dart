import 'dart:convert';

import 'package:flutter-boilerplate/blocs/state-storage.dart';
import 'package:flutter-boilerplate/models/user.dart';
import 'package:rxdart/rxdart.dart';

class UserBloc {
  final _user = BehaviorSubject<UserModel>();

  UserBloc() {
    var encodedUser = StateStorage.loadUser();
    print(encodedUser);
    var user = (encodedUser == null) ? null : UserModel.fromMap(json.decode(encodedUser));
    setUser(user);
    _user.stream.listen((value) {
      var encodedUser = (value == null) ? null : json.encode(value);
      StateStorage.saveUser(encodedUser);
    });
  }

  Observable<UserModel> get stream => _user.stream;
  UserModel get user => _user.value;
  Function(UserModel) get setUser => _user.sink.add;

  dispose() {
    _user.close();
  }
}
