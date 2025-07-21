
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mahakumbh/Bloc/login/bloc.dart';
import 'package:mahakumbh/Repository/UserRepository.dart';

import '../../Model/customer_login_model.dart';
import '../../Model/customer_registration_model.dart';
import '../../app_bloc.dart';
import '../authentication/authentication_event.dart';


class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository? userRepository;
  LoginBloc({this.userRepository}) : super(InitialLoginState()) {
    // ✅ Register event handler for OnLogin

    on<OnLogin>((event, emit) async {
      emit(LoginLoading());

      final CustomerLoginRepo result = await userRepository!.login(
         email: event.email,
         password: event.password,
         // token: fcmToken,
         // deviceID: deviceId
     );
     print(result);

     ///Case API fail but not have token
     if (result.status == true) {
       ///Login API success
       // final  VendorLogin user = VendorLogin.fromJson(result.data);
       CustomerLoginModel user = CustomerLoginModel();
       // user.status = user.status!.toInt();
       user = result.data!;
      AppBloc.authBloc.add(OnSaveUser(user));

      try {
        // Your login logic here
        await Future.delayed(const Duration(seconds:1)); // Simulate API call

        emit(LoginSuccess(userModel: user, message: "Login Successfully"));
      } catch (e) {
        emit(LoginFail(msg: "Please Enter Correct Username and Password"));
      }
    }});


    // On Registration

    on<OnRegistration>((event, emit) async {
      emit(CustomerRegistrationLoading());

      final RegistrationRepo result = await userRepository!.registration(
              fullname:event.fullname,
              createPassword:event.createPassword,
              email:event.email,
              mobileNo:event.mobileNo,
              role:event.role,
              remark:event.remark,
      );
      print(result);

      print(result.message);
      if (result.message == "Admin registered successfully") {
// if (result.message == null) {
        ///Login API success
        RegistrationModel user = RegistrationModel();
// RegistrationModel user = new RegistrationModel();
//  user.status = user.status!.toInt();
        //user = result.email;
        //print(user);

        try {
          // Your login logic here
          await Future.delayed(const Duration(seconds:1)); // Simulate API call

          emit(CustomerRegistrationSuccess(msg: result.message));
        } catch (e) {
          emit(CustomerRegistrationFail(msg: result.message));
        }
      }else{
        emit(CustomerRegistrationFail(msg: result.message));
      }
    }
    );

  }
}





