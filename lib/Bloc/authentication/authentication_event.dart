

import '../../Model/customer_login_model.dart';

abstract class AuthenticationEvent {}

class OnAuthCheck extends AuthenticationEvent {}

class OnSaveUser extends AuthenticationEvent {
  final CustomerLoginModel user;
  OnSaveUser(this.user);
}


class OnClear extends AuthenticationEvent {}
