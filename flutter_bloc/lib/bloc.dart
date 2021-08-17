import 'dart:async';
import 'package:flutter_bloc/validator.dart';
import 'package:rxdart/rxdart.dart';

class Bloc extends Object with Validator implements MyBloc {
  final _emailController = StreamController<String>.broadcast();
  final _passwordController = StreamController<String>.broadcast();

  Function(String) get emailOnChanged => _emailController.sink.add;
  Function(String) get passwordOnChanged => _passwordController.sink.add;

  Stream<String> get email => _emailController.stream.transform(emailValidator);
  Stream<String> get password =>
      _passwordController.stream.transform(passwordValidator);

  Stream<bool> get submitCheck =>
      Rx.combineLatest2(email, password, (e, p) => true);

  @override
  void dispose() {
    _emailController.close();
    _passwordController.close();
  }
}

abstract class MyBloc {
  void dispose();
}
