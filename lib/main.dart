import 'package:crud/API/postalCodes.dart';
import 'package:crud/IntroPages/loginPage.dart';
import 'package:crud/IntroPages/otp.dart';
import 'package:crud/IntroPages/phoneNumber.dart';
import 'package:crud/IntroPages/registrationPage.dart';
import 'package:crud/IntroPages/splashScreen.dart';
import 'package:crud/IntroPages/startScreen.dart';
import 'package:crud/PostalCheck.dart';
import 'package:crud/mainPages/editUser.dart';
import 'package:crud/mainPages/helloPage.dart';
import 'package:crud/mainPages/profilePage.dart';
import 'package:crud/mainPages/users.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'firebase_options.dart';
import 'mainPages/addUser.dart';
import 'newPage.dart';
var width;
var height;


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    width=MediaQuery.of(context).size.width;
    height=MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus!.unfocus();
      },
      child: MaterialApp(
        theme: ThemeData(
          textTheme: GoogleFonts.poppinsTextTheme(),
        ),
        home: splashScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

