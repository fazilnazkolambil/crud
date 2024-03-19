import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud/IntroPages/otp.dart';
import 'package:crud/IntroPages/phoneNumber.dart';
import 'package:crud/IntroPages/registrationPage.dart';
import 'package:crud/classes/colorTheme.dart';
import 'package:crud/classes/imagePage.dart';
import 'package:crud/mainPages/helloPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../main.dart';



class loginPage extends StatefulWidget {
  const loginPage({super.key});

  @override
  State<loginPage> createState() => _loginPageState();
}
User ?user;

class _loginPageState extends State<loginPage> {

  TextEditingController username_controller = TextEditingController();
  TextEditingController password_controller = TextEditingController();
  bool visibility = true;

  final formKey=GlobalKey<FormState>();


  // String? userName;
  String? currentUserEmail;
  String? currentUserName;
  String? currentUserImage;

 signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    UserCredential userCredential= await FirebaseAuth.instance.signInWithCredential(credential);

     user = userCredential.user!;

    print(user!.email);
    currentUserEmail = user!.email;
    currentUserName = user!.displayName;
    currentUserImage = user!.phoneNumber;

    var data = await FirebaseFirestore.instance.collection("users").where("email", isEqualTo: currentUserEmail).get();
    if(data.docs.isEmpty){
      Navigator.push(context, MaterialPageRoute(builder: (context) => registrationPage(gSignIn: true),));
    }else{
      Navigator.pushAndRemoveUntil(context, CupertinoPageRoute(builder:  (context) => helloPage(),), (route) => false);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorTheme.primaryColor,
      appBar: AppBar(
        backgroundColor: colorTheme.primaryColor,
        elevation: 0,
        title: Text("CRUD",style: TextStyle(
          color: colorTheme.secondaryColor,
          fontWeight: FontWeight.w700,
          fontSize: width*0.06
        )),
        leadingWidth: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(width*0.05),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image(image: AssetImage(imagePage.login)),
              SizedBox(height: width*0.1),
              TextFormField(
                controller: username_controller,
                textInputAction: TextInputAction.done,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: width * 0.04,
                ),
                decoration: InputDecoration(
                    labelText: "Username",
                  labelStyle: TextStyle(
                    color: colorTheme.secondaryColor
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(width*0.03),
                    borderSide: BorderSide(
                      color: colorTheme.fontColor,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(width*0.03),
                    borderSide: BorderSide(
                      color: colorTheme.fontColor,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(width*0.03),
                    borderSide: BorderSide(
                      color: colorTheme.fontColor
                    )
                  )
                ),
              ),
              SizedBox(height: width*0.05),
              TextFormField(
                controller: password_controller,
                obscureText: visibility?true:false,
                obscuringCharacter: "*",
                textInputAction: TextInputAction.done,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: width * 0.04,
                ),
                decoration: InputDecoration(
                  suffixIcon: InkWell(
                    onTap: () {
                      visibility=!visibility;
                      setState(() {

                      });
                    },
                      child: Icon(visibility?Icons.visibility_off_outlined:Icons.visibility_outlined)),
                  labelText: "Password",
                  labelStyle: TextStyle(
                    color: colorTheme.secondaryColor
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(width*0.03),
                    borderSide: BorderSide(
                      color: colorTheme.fontColor,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(width*0.03),
                    borderSide: BorderSide(
                      color: colorTheme.fontColor,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(width*0.03),
                    borderSide: BorderSide(
                      color: colorTheme.fontColor
                    )
                  )
                ),
              ),
              SizedBox(height: width*0.1),
              InkWell(
                onTap: () async {

                  if(
                      username_controller.text.isNotEmpty
                    // password_controller.text.isNotEmpty &&
                    // formKey.currentState!.validate()
                  ){
                    FirebaseAuth.instance.signInWithEmailAndPassword(
                        email: username_controller.text,
                        password: password_controller.text
                    ).then((value) async {
                      var data =await FirebaseFirestore.instance.collection("users").where('email',isEqualTo: username_controller.text).get();
                      if(data.docs.isEmpty){
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Username not found")));
                      }else {
                        var password = data.docs[0]['password'];
                        if(password_controller.text==password){
                          SharedPreferences prefs = await SharedPreferences.getInstance();
                          prefs.setBool("login", true);
                           prefs.setString("name", data.docs[0]['name']);
                          prefs.setString("id", data.docs[0]['id']);
                          // prefs.setString("password", data.docs[0]['password']);
                          // prefs.setString("email", data.docs[0]['email']);
                          // prefs.setString("image", data.docs[0]['image']);

                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => helloPage(),));
                        }else{
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Incorrect password")));
                        }
                      }
                    }).catchError((error){
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error.code)));

                    });


                    // SharedPreferences prefs=await SharedPreferences.getInstance();
                    // prefs.setString("name", username_controller.text);
                    // prefs.setBool("nameValue", true);
                    // nameValue=prefs.getBool("nameValue") ?? false;

                    // SharedPreferences prefs=await SharedPreferences.getInstance();
                    // prefs.setString("name", username_controller.text);
                    // prefs.setString("loggedin", "name");
                    // loggedin=prefs.getString("loggedin") ?? "";
                    //  SharedPreferences prefs=await SharedPreferences.getInstance();
                    //  prefs.setString("name", username_controller.text);
                    //  prefs.setInt("loggedint", 1);
                    //  loggedint=prefs.getInt("loggedint") ?? 0;
                  }else{
                    username_controller.text==""?ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Enter Username!"))):
                    password_controller.text==""?ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Enter Password!"))):
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Enter valid details!!")));
                  }
                },
                child: Container(
                  height: width*0.13,
                  width: width*0.7,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(width*0.08),
                    color: colorTheme.primaryColor,
                    border: Border.all(color: colorTheme.fontColor,width: width*0.005),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SvgPicture.asset(iconPage.lock),
                      Center(
                        child: Text("Login",style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: colorTheme.fontColor
                        )),
                      ),
                      SizedBox()
                    ],
                  ),
                ),
              ),
              SizedBox(height: width*0.05),
              InkWell(
                onTap: (){
                  signInWithGoogle();
                  },
                child: Container(
                  height: width*0.13,
                  width: width*0.7,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(width*0.08),
                    color: colorTheme.primaryColor,
                    border: Border.all(color: colorTheme.fontColor,width: width*0.005),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SvgPicture.asset(iconPage.google,width: width*0.05),
                      Center(
                        child: Text("Sign in with Google",style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: colorTheme.fontColor
                        )),
                      ),
                      SizedBox()
                    ],
                  ),
                ),
              ),
              SizedBox(height: width*0.05),
              InkWell(
               onTap: () {
                 Navigator.push(context, MaterialPageRoute(builder: (context) => phoneNumber(),));
               },
                child: Container(
                  height: width*0.13,
                  width: width*0.7,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(width*0.08),
                    color: colorTheme.primaryColor,
                    border: Border.all(color: colorTheme.fontColor,width: width*0.005),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                     Icon(Icons.local_phone_outlined,color: colorTheme.fontColor,),
                      Center(
                        child: Text("OTP sign in",style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: colorTheme.fontColor
                        )),
                      ),
                      SizedBox()
                    ],
                  ),
                ),
              ),
              SizedBox(height: width*0.05),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account ? ",style: TextStyle(
                    color: colorTheme.fontColor,
                    fontSize: width*0.03
                  )),
                  InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => registrationPage(gSignIn: false),));
                    },
                    child: Text("Create Now",style: TextStyle(
                      color: colorTheme.fontColor,
                      fontWeight: FontWeight.w600,
                      fontSize: width*0.03
                    )),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
