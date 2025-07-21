

abstract class LoginEvent {}

class OnLogin extends LoginEvent {
  String email, password;

  OnLogin({required this.email, required this.password});

}

class OnRegistration extends LoginEvent {
  String fullname,
      email,
      mobileNo,
      createPassword,
      role,
      remark;

  OnRegistration(
      {required this.fullname,
        required this.email,
        required this.createPassword,
        required this.mobileNo,
        required this.role,
        required this.remark});
}