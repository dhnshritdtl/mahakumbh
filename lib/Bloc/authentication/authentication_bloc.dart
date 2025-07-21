import 'dart:async';
import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Model/customer_login_model.dart';
import '../../Repository/UserRepository.dart';
import '../../Util/application.dart';
import '../../app_bloc.dart';
import 'authentication_event.dart';
import 'authentication_state.dart';



class AuthBloc extends Bloc<AuthenticationEvent, AuthenticationState> {

// This is demo
  final UserRepository? userRepository;
  AuthBloc({this.userRepository}) : super(InitialAuthenticationState()){


    on<OnSaveUser>((event, emit) async{

      emit( AuthenticationLoading());
      ///Save to Storage user via repository
      final savePreferences = await userRepository!.saveUser(event.user.adminId.toString());

      ///Check result save user
      if (savePreferences) {


        ///Set user
        Application.customerLogin = event.user;
        // UtilPreferences.setString(Preferences.user, Application.user.toString());

        ///Notify loading to UI
        if (Application.customerLogin!.adminId != null) {
          emit(AuthenticationSuccess());
        }
        else {
          emit(AuthenticationFail());
        }
      }else
      {
        const String message = "Cannot save user data to storage phone";
        throw Exception(message);
      }
    }
    );
  }
}
