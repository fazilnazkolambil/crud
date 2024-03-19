import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud/classes/colorTheme.dart';
import 'package:crud/classes/imagePage.dart';
import 'package:crud/mainPages/users.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../main.dart';

class editUser extends StatefulWidget {
  final String name;
  final String email;
  final String password;
  final String id;
  final String image;

  const editUser({super.key, required this.name, required this.email, required this.password, required this.id, required this.image });

  @override
  State<editUser> createState() => _editUserState();
}

class _editUserState extends State<editUser> {



  var file;

  TextEditingController fullName_controller = TextEditingController();
  TextEditingController email_controller = TextEditingController();
  TextEditingController password_controller=TextEditingController();
  TextEditingController newpassword_controller=TextEditingController();

  String imageUrl = "";

  final password_validation = RegExp(r"^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}");
  final email_validation = RegExp(r"^[a-z0-9.a-z0-9.!#$%&'*+-/=?^_{|}~]+@[a-z0-9]+\.[a-z]+");

  bool visibility1 = false;
  bool visibility2 = false;
  // String newImageUrl = "";
  bool loading = false;

  pickFile(ImageSource) async {
    final imgFile= await ImagePicker.platform.getImageFromSource(source: ImageSource);
    file=File(imgFile!.path);
    if(mounted){
      setState(() {
        file=File(imgFile!.path);
      });
      uploadFiles(file);
    }
  }
  uploadFiles(File file) async {
    setState(() {
      loading = true;
    });
    var uploadTask = await FirebaseStorage.instance
        .ref("users")
        .child(DateTime.now().toString())
        .putFile( file,
    SettableMetadata(contentType: "image/jpeg"));
    var getUrl = await uploadTask.ref.getDownloadURL();
    imageUrl = getUrl;
    print(imageUrl);
    loading = false;
    setState(() {

    });
  }

  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    fullName_controller.text=widget.name;
    email_controller.text=widget.email;
    password_controller.text=widget.password;
    imageUrl=widget.image;
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
        title: Text("Edit User",style: TextStyle(
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
                    loading?CircularProgressIndicator():Container(
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
                              color: colorTheme.fontColor,
                          )
                      )),
                ),
              ),
              Padding(
                padding:EdgeInsets.all(width*0.03),
                child: TextFormField(
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
                  // autovalidateMode: AutovalidateMode.onUserInteraction,
                  // validator: (value){
                  //   if(password_controller.text!=value){
                  //     return "Password Doesn't match";
                  //   }else{
                  //     return null;
                  //   }
                  // },
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
              SizedBox(height: width*0.1,),
              InkWell(
                onTap: () {
                  if(
                  fullName_controller.text!="" &&
                      email_controller.text!="" &&
                      password_controller.text!=""&&
                      // newpassword_controller.text!=""&&
                      formKey.currentState!.validate()) {
                    showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          backgroundColor: colorTheme.primaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  width * 0.03)),
                          content: Container(
                            height: width * 0.36,
                            width: width * 0.4,
                            child: Column(
                              children: [
                                Text("Are you Sure\n"
                                    "You Want to Update Details ?",
                                  textAlign: TextAlign.center,
                                ),
                                Divider(),
                                InkWell(
                                  onTap: () {
                                    FirebaseFirestore.instance.collection("users").doc(widget.id).update({
                                      "name":fullName_controller.text,
                                      "email":email_controller.text,
                                      "password":password_controller.text,
                                      "image":imageUrl
                                    });
                                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => users(),));
                                  },
                                  child: Text("Confirm",
                                    style: TextStyle(color: colorTheme.font2),),
                                ),
                                Divider(),
                                InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text("Cancel", style: TextStyle(
                                        color: colorTheme.red),)),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }else{
                    fullName_controller.text==""?ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Enter Full Name!"))):
                    email_controller.text==""?ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Enter Email!"))):
                    password_controller.text==""?ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Enter Password!"))):
                    newpassword_controller.text==""?ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Confirm Password!"))):
                        ScaffoldMessenger.of(context).showSnackBar( SnackBar(content: Text("Enter Valid details!")));
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
                    child: Text("Edit User",style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: colorTheme.fontColor
                    )),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
