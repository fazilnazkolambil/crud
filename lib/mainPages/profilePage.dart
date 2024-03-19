import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud/classes/colorTheme.dart';
import 'package:crud/classes/imagePage.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

class profilePage extends StatefulWidget {
  //final String userName, password, email, id, image;
  const profilePage({super.key,
    //required this.userName, required this.password, required this.email, required this.id, required this.image
     });

  @override
  State<profilePage> createState() => _profilePageState();
}

class _profilePageState extends State<profilePage> {
  var file;

  TextEditingController username_controller = TextEditingController();
  TextEditingController email_controller = TextEditingController();
  TextEditingController password_controller=TextEditingController();


  final password_validation = RegExp(r"^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}");
  final email_validation = RegExp(r"^[a-z0-9.a-z0-9.!#$%&'*+-/=?^_{|}~]+@[a-z0-9]+\.[a-z]+");

  bool visibility = false;
  bool loading = false;
  String imageUrl="";



  pickFile(ImageSource) async {
    final imgFile= await ImagePicker.platform.pickImage(source: ImageSource);
    file=File(imgFile!.path);
    if(mounted){
      setState(() {
        file=File(imgFile!.path);
      });
      getImage(file);
    }
  }

  getImage(File file) async {
    setState(() {
      loading = true;
    });
    var uploadImage = await FirebaseStorage.instance
        .ref("users")
        .child(DateTime.now().toString())
        .putFile(file,SettableMetadata(contentType: "image/jpeg"));
    var getUrl = await uploadImage.ref.getDownloadURL();
    var imageUrl = getUrl;
    loading = false;
    setState(() {
    });
  }

  // String userId = '';
  // String userPassword = '';
  // String userName = '';
  // String userEmail = '';
  // String userImage = '';
  //
  // getData () async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   var userId = prefs.getString("id");
  //   var data = await FirebaseFirestore.instance.collection("users").where("id", isEqualTo: userId).get();
  //       userPassword = data.docs[0]["password"];
  //       userName = data.docs[0]["name"];
  //       userEmail = data.docs[0]["email"];
  //       userImage = data.docs[0]["image"];
  //
  // }
  @override
  void initState() {
    //getData();
    // TODO: implement initState
    // username_controller.text=widget.userName;
    // email_controller.text=widget.email;
    // password_controller.text=widget.password;
    // imageUrl=widget.image;
    super.initState();
  }
  final formKey = GlobalKey<FormState>();
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
        title: Text("Profile",style: TextStyle(
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
                              backgroundImage: NetworkImage(imageUrl)
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
              Container(
                height: width*0.8,
                width: width*1,
                //color: Colors.black,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding:EdgeInsets.all(width*0.03),
                        child: TextFormField(
                          controller: username_controller,
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
                              labelText: "User name",
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
                              labelText: "Email",
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
                          obscureText: visibility?false:true,
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
                                    visibility=!visibility;
                                    setState(() {

                                    });
                                  },
                                  child: Icon(visibility?Icons.visibility_off_outlined:Icons.visibility_outlined)),
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
                    ],
                  ),
                ),
              ),
              SizedBox(height: width*0.1,),
              InkWell(
                onTap: () {
                  if(
                  username_controller.text!="" &&
                      email_controller.text!="" &&
                      password_controller.text!=""&&
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
                                Text("Confirm",
                                  style: TextStyle(color: colorTheme.font2),),
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
                    username_controller.text==""?ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Enter User name!"))):
                    email_controller.text==""?ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Enter Email!"))):
                    password_controller.text==""?ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Enter Password!"))):
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
    );;
  }
}
