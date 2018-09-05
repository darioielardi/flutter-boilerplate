
import 'package:flutter/material.dart';

class BlocProvider<S> extends InheritedWidget {
  final S _bloc;

  const BlocProvider({
    Key key,
    @required S bloc,
    @required Widget child,
  })  : _bloc = bloc,
        super(key: key, child: child);

  static S of<S>(BuildContext context) {
    final type = _typeOf<BlocProvider<S>>();
    final BlocProvider<S> provider = context.inheritFromWidgetOfExactType(type);
    if (provider == null) throw StateError('Inherited Provider does not exist');
    return provider._bloc;
  }

  static Type _typeOf<T>() => T;

  @override
  // bool updateShouldNotify(BlocProvider<T> old) => _bloc != old._bloc;
  bool updateShouldNotify(_) => true;
}
