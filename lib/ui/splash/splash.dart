import 'dart:async';

import 'package:boilerplate/data/database/controller/db_controller.dart';
import 'package:boilerplate/data/sharedpref/constants/preferences.dart';
import 'package:boilerplate/routes.dart';
import 'package:boilerplate/stores/form/form_store.dart';
import 'package:boilerplate/widgets/app_icon_widget.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

DBController _dbController = DBController();
final _auth = FirebaseAuth.instance;
DataConnectionChecker connectionChecker = DataConnectionChecker();
bool connectedToInternet = false;

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    getCurrentUser();
    checkConnection();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black,
      child: Center(
          child: Hero(
              tag: 'AppIcon',
              child: AppIconWidget(image: 'assets/icons/ask_pro_icon.png'))),
    );
  }

  startTimer() {
    var _duration = Duration(milliseconds: 1000);
    return Timer(_duration, navigate);
  }

  navigate() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (connectedToInternet) {
      if (preferences.getBool(Preferences.is_logged_in) ?? false) {
//      Future.delayed(Duration(milliseconds: 100)).then((value) => null);
        bool checkUser = await _dbController.checkUser(loggedInUser.email);
        if (checkUser) {
          Navigator.of(context).pushReplacementNamed(Routes.chat);
        } else
          Navigator.of(context).pushReplacementNamed(Routes.questionnaire);
      } else {
        Navigator.of(context).pushReplacementNamed(Routes.login);
      }
    } else {
      Navigator.of(context).pushReplacementNamed(Routes.login);
    }
  }

  checkConnection() async {
    connectedToInternet = await connectionChecker.hasConnection;
    if (connectedToInternet == true) {
      print('YAY! Free cute dog pics!');
    } else {
      print('No internet :( Reason:');
      print(connectionChecker.lastTryResults);
    }
  }

  void getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      print(e);
    }
  }
}
