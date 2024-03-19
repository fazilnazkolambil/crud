import 'package:crud/IntroPages/startScreen.dart';
import 'package:crud/classes/colorTheme.dart';
import 'package:crud/mainPages/helloPage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

class splashScreen extends StatefulWidget {
  const splashScreen({super.key});

  @override
  State<splashScreen> createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen> {
  bool loggedin = false;
  // Future<void> getData() async {
  //   SharedPreferences prefs=await SharedPreferences.getInstance();
  //   nameValue=prefs.getBool("nameValue") ?? false;
  // }
  Future<void> getData() async {
    SharedPreferences prefs=await SharedPreferences.getInstance();
    loggedin= prefs.getBool("login") ?? false;
  }

  @override
  void initState(){
    getData();
    Future.delayed(
        Duration(
          seconds: 5
        )
    ).then((value) => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => loggedin ? helloPage():startScreen())));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorTheme.primaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Text("CRUD",style: TextStyle(
              fontSize: width*0.1,
              fontWeight: FontWeight.w700,
              color: colorTheme.fontColor
            )),
          ),
          SizedBox(height: width*0.03,),
          CircularProgressIndicator(
            backgroundColor: colorTheme.fontColor,
            color: colorTheme.font2,
          )
        ],
      ),
    );
  }
}
