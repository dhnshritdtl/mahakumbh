import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'Screens/LoginRegistration/splash_screen.dart';
import 'app_bloc.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}



class _AppState extends State<App> {
 // final route = Routes();

  var locator;
  String? role='';


  @override
  void dispose() {
    AppBloc.dispose();
    super.dispose();
  }



  @override
  void initState() {
    super.initState();
   // role = UserRepository().getRole();

  }


  @override
  Widget build(BuildContext context) {
    return
      MultiBlocProvider(
        providers: AppBloc.providers,
        child:
        MaterialApp(
          // navigatorKey: PushNotify.navigatorKey, // imp nvigator key is used as navigation through context didnt worked
          debugShowCheckedModeBanner: false,
          //theme: AppTheme.lightTheme,
          // darkTheme: AppTheme.darkTheme,
         // locale: AppLanguage.defaultLanguage,
          home:SplashScreen()
          // localizationsDelegates: [
          //  // Translate.delegate,
          //   // EasyLocalization.of(context).delegate,
          //
          //  // GlobalMaterialLocalizations.delegate,
          //  // GlobalWidgetsLocalizations.delegate,
          // ],

         // supportedLocales: AppLanguage.supportLanguage,


          //onGenerateRoute: route.generateRoute,
        /*  home:
          BlocBuilder<AuthBloc, AuthenticationState>(
            builder: (context, app) {

              if (app is AuthenticationSuccess) {
                return BottomNavigation(index: 0,dropValue: Application.customerLogin!.role.toString());
              }
              if (app is AuthenticationFail) {
               return SignUpAsScreen();
              //  return BottomNavigation(index: 0,);
              }
              return SplashScreen();

            },
          ),*/

      )

      );

  }
}
