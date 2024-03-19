import 'package:crud/IntroPages/loginPage.dart';
import 'package:crud/IntroPages/registrationPage.dart';
import 'package:crud/classes/colorTheme.dart';
import 'package:crud/classes/imagePage.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class startScreen extends StatefulWidget {
  const startScreen({super.key});

  @override
  State<startScreen> createState() => _startScreenState();
}

class _startScreenState extends State<startScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorTheme.primaryColor,
      appBar: AppBar(
        backgroundColor: colorTheme.primaryColor,
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: width*1,
            width: width*1,
            //color: colorTheme.secondaryColor,
            child: Image.asset(imagePage.startScreen),
          ),
          Text("CRUD",style:TextStyle(
            color: colorTheme.fontColor,
            fontWeight: FontWeight.w700,
            fontSize: width*0.07
          )),
          Text("Create, Read, Update, Delete",style: TextStyle(
            color: colorTheme.fontColor
          )),
          SizedBox(height: width*0.03,),
          InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => loginPage(),));
            },
            child: Container(
              height: width*0.13,
              width: width*0.7,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(width*0.08),
                color: colorTheme.fontColor
              ),
              child: Center(
                child: Text("Login",style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: colorTheme.primaryColor
                )),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => registrationPage(gSignIn: false),));
            },
            child: Container(
              height: width*0.13,
              width: width*0.7,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(width*0.08),
                color: colorTheme.primaryColor,
                border: Border.all(color: colorTheme.fontColor,width: width*0.005),
              ),
              child: Center(
                child: Text("Sign up",style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: colorTheme.fontColor
                )),
              ),
            ),
          ),
          SizedBox(height: width*0.05,),
        ],
      ),
    );
  }
}
