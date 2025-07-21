

import '../../Model/customer_login_model.dart';

abstract class LoginState{}

class InitialLoginState extends LoginState {}

class LoginLoading extends LoginState {
}

class LoginFail extends LoginState {
  final String? msg;

  LoginFail({this.msg});
}

class LoginSuccess extends LoginState {
  CustomerLoginModel userModel;
  String message;
  LoginSuccess({required this.userModel,required this.message});

}

class CustomerRegistrationLoading extends LoginState {

}

class CustomerRegistrationSuccess extends LoginState {
  String msg;
  CustomerRegistrationSuccess({required this.msg});
}

class CustomerRegistrationFail extends LoginState {
  String msg;
  CustomerRegistrationFail({required this.msg});
}


