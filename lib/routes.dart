import 'package:boilerplate/ui/chat/chat.dart';
import 'package:boilerplate/ui/questionnaire/questionnaire.dart';
import 'package:boilerplate/ui/register/register.dart';
import 'package:flutter/material.dart';

import 'ui/home/home.dart';
import 'ui/login/login.dart';
import 'ui/splash/splash.dart';

class Routes {
  Routes._();

  //static variables
  static const String splash = '/splash';
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';
  static const String chat = '/chat';
  static const String questionnaire = '/questionnaire';

  static final routes = <String, WidgetBuilder>{
    splash: (BuildContext context) => SplashScreen(),
    login: (BuildContext context) => LoginScreen(),
    register: (BuildContext context) => RegisterScreen(),
    home: (BuildContext context) => HomeScreen(),
    chat: (BuildContext context) => ChatScreen(),
    questionnaire: (BuildContext context) => QuestionnairePage(),
  };
}
