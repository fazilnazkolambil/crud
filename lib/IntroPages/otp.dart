import 'package:crud/IntroPages/phoneNumber.dart';
import 'package:crud/classes/colorTheme.dart';
import 'package:crud/classes/imagePage.dart';
import 'package:crud/mainPages/helloPage.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

import '../main.dart';

class otp extends StatefulWidget {
  const otp({super.key});

  @override
  State<otp> createState() => _otpState();
}

class _otpState extends State<otp> {
  TextEditingController pin_controller=TextEditingController();
  final formKey=GlobalKey<FormState>();
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
        title: Text("Verify OTP",style: TextStyle(
            color: colorTheme.secondaryColor,
            fontSize: width*0.06
        )),
        centerTitle: true,
      ),
      body: Padding(
        padding:EdgeInsets.all(width*0.05),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(imagePage.otp),
                SizedBox(height: width*0.1,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Otp has been sent to ",style: TextStyle(
                      color: colorTheme.lightfont.withOpacity(0.4),
                      fontSize: width*0.035
                    )),
                    Text("*****634 ",style: TextStyle(
                      color: colorTheme.fontColor,
                      fontWeight: FontWeight.w600
                    )),
                    InkWell(
                        onTap: () {
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => phoneNumber(),));
                        },
                        child: Icon(Icons.edit_outlined,size: width*0.05,color: colorTheme.fontColor,))
                  ],
                ),
                SizedBox(height: width*0.05,),
                FractionallySizedBox(
                  child: Pinput(
                    controller:pin_controller,
                    length: 6,
                  ),
                ),
                SizedBox(height: width*0.15,),
                InkWell(
                  onTap: () {
                    if(
                    pin_controller.text!=""&&
                        formKey.currentState!.validate()){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => helloPage(),));
                    }else{
                      pin_controller.text==""?ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Enter OTP!"))):
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Enter a Valid OTP!")));
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
                      child: Text("Verify",style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: colorTheme.fontColor
                      )),
                    ),
                  ),
                ),
                SizedBox(height: width*0.05,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Haven't got the confirmation code yet?  ",style: TextStyle(
                        fontSize: width*0.03
                    )),
                    Text("Resend",style: TextStyle(
                        color: colorTheme.fontColor,
                        fontWeight: FontWeight.w600,
                        fontSize: width*0.03
                    )),
                  ],
                ),
                SizedBox(height: width*0.4,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Try Another ",style: TextStyle(
                        fontSize: width*0.03
                    )),
                    Text("Method ?",style: TextStyle(
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
