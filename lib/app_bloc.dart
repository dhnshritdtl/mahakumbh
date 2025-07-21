
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Bloc/authentication/authentication_bloc.dart';
import 'Bloc/login/login_bloc.dart';
import 'Repository/UserRepository.dart';

class AppBloc {

  static final userRepository = UserRepository();

  static final authBloc = AuthBloc(userRepository: userRepository);
  static final loginBloc = LoginBloc(userRepository: userRepository);

  static final List<BlocProvider> providers = [

    BlocProvider<LoginBloc>(
      create: (context) => loginBloc,
    ),
    BlocProvider<AuthBloc>(
      create: (context) => authBloc,
    ),


  ];

  static void dispose() {

   loginBloc.close();
   authBloc.close();

  }

  ///Singleton factory
  static final AppBloc _instance = AppBloc._internal();

  factory AppBloc() {
    return _instance;
  }

  AppBloc._internal();
}
