import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud/IntroPages/loginPage.dart';
import 'package:crud/classes/colorTheme.dart';
import 'package:crud/classes/imagePage.dart';
import 'package:crud/mainPages/helloPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

class registrationPage extends StatefulWidget {
  const registrationPage({super.key, required this.gSignIn});
  final bool gSignIn;

  @override
  State<registrationPage> createState() => _registrationPageState();
}

class _registrationPageState extends State<registrationPage> {
  var file;

  TextEditingController fullName_controller = TextEditingController();
  TextEditingController email_controller = TextEditingController();
  TextEditingController password_controller=TextEditingController();
  TextEditingController newpassword_controller=TextEditingController();

  final password_validation = RegExp(r"^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}");
  final email_validation = RegExp(r"^[a-z0-9.a-z0-9.!#$%&'*+-/=?^_{|}~]+@[a-z0-9]+\.[a-z]+");

  bool visibility1 = false;
  bool visibility2 = false;
  bool loading = false;

  pickFile(ImageSource) async {
    final imgFile= await ImagePicker.platform.pickImage(source: ImageSource);
    file=File(imgFile!.path);
    if(mounted){
      setState(() {
        file=File(imgFile!.path);
      });
      uploadImage(file);
    }
  }
  String imageUrl = "";
  uploadImage(File file) async {
    loading = true;
    setState(() {

    });
    var uploadTask = await FirebaseStorage.instance
        .ref("users")
        .child(DateTime.now().toString())
        .putFile(file,SettableMetadata( contentType: "image/jpeg"));
    var getImage = await uploadTask.ref.getDownloadURL();
        imageUrl = getImage;
        loading = false;
        setState(() {

        });
  }
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {

    if(widget.gSignIn==true){
      email_controller.text= user!.email.toString();
      fullName_controller.text= user!.displayName.toString();
      imageUrl = user!.photoURL.toString();
    }
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorTheme.primaryColor,
      appBar: AppBar(
        backgroundColor: colorTheme.primaryColor,
        elevation: 0,
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios_new)),
        iconTheme: IconThemeData(color: colorTheme.secondaryColor),
        title: Text("User Registration",style: TextStyle(
            color: colorTheme.secondaryColor,
            fontSize: width*0.06
        )),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(width*0.03),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Container(
                height: width*0.4,
                width: width,
                //color: Colors.black,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    loading? CircularProgressIndicator():Container(
                      height: width*0.35,
                      width: width*0.35,
                      //color: Colors.black,
                      child: Stack(
                        children: [
                         CircleAvatar(
                            radius: width*0.35,
                            backgroundImage: NetworkImage(imageUrl),
                          ),
                          Positioned(
                              right: width*0.05,
                              bottom: 0,
                              child: InkWell(
                                onTap: () {
                                  showModalBottomSheet(
                                    backgroundColor: colorTheme.primaryColor.withOpacity(0),
                                      context: context,
                                      builder: (context) => Container(
                                        height: width*0.65,
                                        width: width*1,
                                        child: Column(
                                          children: [
                                            Container(
                                              height: width*0.35,
                                              width: width*1,
                                              margin: EdgeInsets.all(width*0.03),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(width*0.02),
                                                color: colorTheme.primaryColor
                                              ),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                      pickFile(ImageSource.gallery);
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text("Photo Gallery",style: TextStyle(
                                                      color: colorTheme.font2,
                                                      fontSize: width*0.045,
                                                    )),
                                                  ),
                                                  Divider(),
                                                  InkWell(
                                                    onTap: () {
                                                      pickFile(ImageSource.camera);
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text("Camera",style: TextStyle(
                                                      color: colorTheme.font2,
                                                      fontSize: width*0.045,
                                                    )),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              height: width*0.15,
                                              width: width*1,
                                              margin: EdgeInsets.all(width*0.03),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(width*0.02),
                                                color: colorTheme.primaryColor
                                              ),
                                              child: Center(
                                                child: InkWell(
                                                  onTap: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text("Cancel",style: TextStyle(
                                                    color: colorTheme.font2,
                                                    fontSize: width*0.045,
                                                    fontWeight: FontWeight.w600
                                                  )),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                  );
                                },
                                child: CircleAvatar(
                                  radius: width*0.04,
                                  backgroundColor: colorTheme.fontColor,
                                    child: Icon(Icons.edit_outlined,size: width*0.05,color: colorTheme.primaryColor,)),
                              )
                          )
                        ],
                      ),
                    ),

                  ],
                ),
              ),
              SizedBox(height: width*0.05,),
              Padding(
                padding:EdgeInsets.all(width*0.03),
                child: TextFormField(
                  controller: fullName_controller,
                  textCapitalization: TextCapitalization.words,
                  keyboardType: TextInputType.multiline,
                  textInputAction: TextInputAction.done,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: width * 0.05,
                      color: colorTheme.fontColor
                  ),
                  decoration: InputDecoration(
                    suffixIcon: Icon(Icons.person_2_outlined),
                      filled: true,
                      contentPadding: EdgeInsets.all(width*0.04),
                      labelText: "Full Name",
                      labelStyle: TextStyle(
                        fontSize: width * 0.04,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(width * 0.03),
                          borderSide: BorderSide(
                            color: colorTheme.primaryColor,
                          )),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(width*0.03),
                          borderSide: BorderSide(
                              color: colorTheme.primaryColor
                          )
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(width * 0.03),
                          borderSide: BorderSide(
                              color: colorTheme.fontColor
                          )
                      )),
                ),
              ),
              Padding(
                padding:EdgeInsets.all(width*0.03),
                child: TextFormField(
                  readOnly: widget.gSignIn,
                  controller: email_controller,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.done,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: width * 0.05,
                      color: colorTheme.fontColor
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (!email_validation.hasMatch(value!)) {
                      return "Please enter a valid email";
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    suffixIcon: Icon(Icons.email_outlined),
                      filled: true,
                      contentPadding: EdgeInsets.all(width*0.04),
                      labelText: "Valid email",
                      labelStyle: TextStyle(
                        fontSize: width * 0.04,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(width * 0.03),
                          borderSide: BorderSide(
                            color: colorTheme.primaryColor,
                          )),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(width*0.03),
                          borderSide: BorderSide(
                              color: colorTheme.primaryColor
                          )
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(width * 0.03),
                          borderSide: BorderSide(
                              color: colorTheme.fontColor
                          )
                      )),
                ),
              ),
              Padding(
                padding:EdgeInsets.all(width*0.03),
                child: TextFormField(
                  controller: password_controller,
                  keyboardType: TextInputType.multiline,
                  textInputAction: TextInputAction.done,
                  obscureText: visibility1?false:true,
                  obscuringCharacter: "*",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: width * 0.05,
                      color: colorTheme.fontColor
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value){
                    if(!password_validation.hasMatch(value!)){
                      return "Create a Strong Password.";
                    }else{
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                      filled: true,
                      contentPadding: EdgeInsets.all(width*0.04),
                      suffixIcon: InkWell(
                          onTap: () {
                            visibility1=!visibility1;
                            setState(() {

                            });
                          },
                          child: Icon(visibility1?Icons.lock_open_outlined:Icons.lock_outline_rounded)),
                      labelText: "Password",
                      labelStyle: TextStyle(
                        fontSize: width * 0.04,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(width * 0.03),
                          borderSide: BorderSide(
                            color: colorTheme.primaryColor,
                          )),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(width * 0.03),
                          borderSide: BorderSide(
                            color: colorTheme.primaryColor,
                          )),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(width * 0.03),
                          borderSide: BorderSide(
                              color: colorTheme.fontColor
                          )
                      )
                  ),
                ),
              ),
              Padding(
                padding:EdgeInsets.all(width*0.03),
                child: TextFormField(
                  controller: newpassword_controller,
                  keyboardType: TextInputType.multiline,
                  textInputAction: TextInputAction.done,
                  obscureText: visibility2?false:true,
                  obscuringCharacter: "*",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: width * 0.05,
                      color: colorTheme.fontColor
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value){
                    if(password_controller.text!=value){
                      return "Password Doesn't match";
                    }else{
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                      filled: true,
                      contentPadding: EdgeInsets.all(width*0.04),
                      suffixIcon: InkWell(
                          onTap: () {
                            visibility2=!visibility2;
                            setState(() {

                            });
                          },
                          child: Icon(visibility2?Icons.lock_open_outlined:Icons.lock_outline_rounded)),
                      labelText: "Confirm Password",
                      labelStyle: TextStyle(
                        fontSize: width * 0.04,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(width * 0.03),
                          borderSide: BorderSide(
                            color: colorTheme.primaryColor,
                          )),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(width * 0.03),
                          borderSide: BorderSide(
                            color: colorTheme.primaryColor,
                          )),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(width * 0.03),
                          borderSide: BorderSide(
                              color: colorTheme.fontColor
                          )
                      )
                  ),
                ),
              ),
              SizedBox(height: width*0.05,),
              InkWell(
                onTap: () async {
                  if(
                  fullName_controller.text!=""&&
                  email_controller.text!=""&&
                  password_controller.text!=""&&
                  newpassword_controller.text!=""&&
                      imageUrl!="" &&
                      formKey.currentState!.validate()
                  ){

                    FirebaseAuth.instance.createUserWithEmailAndPassword(
                        email: email_controller.text,
                        password: password_controller.text
                    ).then((value) async {
                      FirebaseFirestore.instance.collection("users").add({
                        "name": fullName_controller.text,
                        "email": email_controller.text,
                        "password": password_controller.text,
                        "image": imageUrl,
                      }).then((value) {
                        value.update({
                          "id": value.id
                        }).then((value) {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) => helloPage(),));
                        });
                      });
                      SharedPreferences prefs = await SharedPreferences
                          .getInstance();
                      prefs.setBool("login", true);
                      prefs.setString("name", fullName_controller.text);
                    }).catchError((error){
                      print("--------$error");
                 ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error.code)));

                    });


                     {

                    }
                  }else{
                    fullName_controller.text==""?ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Enter your Full name!"))):
                    email_controller.text==""?ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Enter your Email!"))):
                    password_controller.text==""?ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Enter a Password!"))):
                    newpassword_controller.text==""?ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Confirm Password!"))):
                    imageUrl==""?ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Upload an image!"))):
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Enter valid details!")));
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
                  child: Center(
                    child: Text("Sign Up",style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: colorTheme.fontColor
                    )),
                  ),
                ),
              ),
              SizedBox(height: width*0.35),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an Account ",style: TextStyle(
                      fontSize: width*0.03
                  )),
                  InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => loginPage(),));
                    },
                    child: Text("Login ?",style: TextStyle(
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
