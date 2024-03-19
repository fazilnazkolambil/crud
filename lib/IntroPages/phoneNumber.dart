import 'package:country_code_picker/country_code_picker.dart';
import 'package:crud/IntroPages/otp.dart';
import 'package:crud/classes/colorTheme.dart';
import 'package:crud/classes/imagePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class phoneNumber extends StatefulWidget {
  const phoneNumber({super.key});

  @override
  State<phoneNumber> createState() => _phoneNumberState();
}

class _phoneNumberState extends State<phoneNumber> {
  TextEditingController number_controller=TextEditingController();

  final phone_validation = RegExp(r"[0-9]{10}");
  final formKey = GlobalKey<FormState>();
  String countryCode = "+91";
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
        title: Text("Enter Phone Number",style: TextStyle(
            color: colorTheme.secondaryColor,
            fontSize: width*0.06
        )),
      ),
      body: Padding(
        padding:EdgeInsets.all(width*0.03),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(imagePage.phoneNumber),
                SizedBox(height: width*0.05,),
                TextFormField(
                  maxLength: 10,
                  controller: number_controller,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.done,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: width * 0.05,
                  ),
                  //autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value){
                    if(!phone_validation.hasMatch(value!)){
                      return "Enter a valid Phone number";
                    }else{
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                      counterText: "",
                      prefixIconConstraints: BoxConstraints.tightForFinite(width:width*0.3,height: width*0.15),
                      prefixIcon: CountryCodePicker(
                        initialSelection: "+91",
                        showOnlyCountryWhenClosed: true,
                        showDropDownButton: true,
                        hideMainText: true,

                      ),
                      contentPadding: EdgeInsets.all(width*0.04),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(width * 0.03),
                          borderSide: BorderSide(
                          )),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(width * 0.03),
                          borderSide: BorderSide(
                          ))),
                ),
                SizedBox(height: width*0.1,),
                InkWell(
                  onTap: () {
                    if(
                    number_controller.text!=""&&
                        formKey.currentState!.validate()){

                      FirebaseAuth.instance.verifyPhoneNumber(
                        phoneNumber:'${countryCode+number_controller.text}',
                        verificationCompleted:(PhoneAuthCredential credential) {},
                        verificationFailed: (FirebaseAuthException error) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error.code)));
                            },
                        codeSent: (String verificationId, int? resendToken) {},
                        codeAutoRetrievalTimeout: (String verificationId) {},
                      );
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => otp(),));
                    }else{
                      number_controller.text==""?ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Enter Phone Number!"))):
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Enter a valid Phone Number!")));
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
                      child: Text("Send OTP",style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: colorTheme.fontColor
                      )),
                    ),
                  ),
                ),
                SizedBox(height: width*0.6,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Sign in with ",style: TextStyle(
                        fontSize: width*0.03
                    )),
                    Text("Another Method ?",style: TextStyle(
                        color: colorTheme.fontColor,
                        fontWeight: FontWeight.w600,
                        fontSize: width*0.03
                    )),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
