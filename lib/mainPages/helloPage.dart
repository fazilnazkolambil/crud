import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud/API/postalCodes.dart';
import 'package:crud/IntroPages/startScreen.dart';
import 'package:crud/classes/colorTheme.dart';
import 'package:crud/classes/imagePage.dart';
import 'package:crud/mainPages/profilePage.dart';
import 'package:crud/mainPages/users.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../main.dart';
import 'addUser.dart';

class helloPage extends StatefulWidget {
  const helloPage({super.key});

  @override
  State<helloPage> createState() => _helloPageState();
}

class _helloPageState extends State<helloPage> {
  List images=[
    imagePage.slider1,
    imagePage.slider1,
    imagePage.slider1
  ];
  int currentIndex=0;

  String userName = "";
  String password = "";
  String email = "";
  String userid = "";
  String userImage = "";

  getName() async {
    //SharedPreferences prefs=await SharedPreferences.getInstance();
    //userName=prefs.getString("name") ?? "";
    var data = await FirebaseFirestore.instance.collection("users").doc().get();
    //userName =
    // password=prefs.getString("password") ?? "";
    // email=prefs.getString("email") ?? "";
    // userid=prefs.getString("id") ?? "";
    // userImage=prefs.getString("image") ?? "";
    //print(userImage);
    setState(() {

    });
  }

  @override
  void initState() {
    getName();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: colorTheme.fontColor,
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => addUser(),));
        },
      ),
      backgroundColor: colorTheme.primaryColor,
      appBar: AppBar(
        backgroundColor: colorTheme.primaryColor,
        elevation: 0,
        leadingWidth: 0,
        title: Text("Hello, $userName",style: TextStyle(
            color: colorTheme.secondaryColor,
            fontSize: width*0.06
        )),
        actions: [
          InkWell(
            // onTap: () async{
            //   SharedPreferences prefs = await SharedPreferences.getInstance();
            //   prefs.remove("nameValue");
            //   Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => startScreen(),), (route) => false);
            // },
            onTap: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.remove("login");
              GoogleSignIn().signOut();
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => startScreen(),), (route) => false);
            },
            child: Icon(
              Icons.logout_sharp,
              color: Colors.black,
            ),
          ),
          SizedBox(width: width*0.05,),
          InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => profilePage(
                // userName: userName,
                // password: password,
                // email: email,
                // id: userid,
                // image: userImage,
              ),));
            },
            child: CircleAvatar(
              radius: width*0.06,
              backgroundImage: AssetImage(imagePage.propic),
            ),
          ),
          SizedBox(width: width*0.05,)
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CarouselSlider.builder(
              itemCount: images.length,
              options: CarouselOptions(
                  onPageChanged: (index, reason) {
                    currentIndex = index;
                    setState(() {});
                  },
                  autoPlay: true,
                  viewportFraction: 0.9,
                  autoPlayAnimationDuration: Duration(
                    seconds: 1,
                  )),
              itemBuilder: (BuildContext context, int index, int realIndex) {
                return Container(
                  height: width * 0.4,
                  width: width * 1,
                  margin: EdgeInsets.all(width * 0.03),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(width*0.03)
                  ),
                  child: Image.asset(
                    images[index],
                    fit: BoxFit.fill,
                  ),
                );
              },
            ),
            AnimatedSmoothIndicator(
              activeIndex: currentIndex,
              count: images.length,
              effect: ExpandingDotsEffect(
                activeDotColor: colorTheme.secondaryColor,
                expansionFactor: 1.1,
                dotHeight: width * 0.02,
                dotWidth: width * 0.02,
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => postalCodes(),));
              },
              child: Container(
                decoration: BoxDecoration(
                  //color: Colors.green,
                  borderRadius: BorderRadius.circular(width*0.03),
                ),
                child:Stack(
                  children: [
                    Image.asset(imagePage.container1,fit: BoxFit.fill,),
                    Positioned(
                        top: width*0.12,
                        left: width*0.05,
                        child: Image.asset(imagePage.effect1,fit: BoxFit.fill,)),
                    Positioned(
                      left: width*0.1,
                      right: width*0.1,
                      top: width*0.15,
                      bottom:width*0.1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text("API Integration",style: TextStyle(
                            color: colorTheme.primaryColor,
                            fontWeight: FontWeight.w500,
                            fontSize: width*0.065
                          )),
                          Icon(Icons.arrow_forward_ios_outlined,color: colorTheme.primaryColor,)
                        ],
                      ),
                    )
                  ],
                )
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => users(),));
              },
              child: Container(
                decoration: BoxDecoration(
                  //color: Colors.green,
                  borderRadius: BorderRadius.circular(width*0.03),
                ),
                child:Stack(
                  children: [
                    Image.asset(imagePage.container2,fit: BoxFit.fill,),
                    Positioned(
                        top: width*0.14,
                        left: width*0.05,
                        child: Image.asset(imagePage.effect2,height: width*0.43,width:width*0.9,fit: BoxFit.fill,)),
                    Positioned(
                      left: width*0.1,
                      right: width*0.1,
                      top: width*0.15,
                      bottom:width*0.1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text("User List",style: TextStyle(
                            color: colorTheme.primaryColor,
                            fontWeight: FontWeight.w500,
                            fontSize: width*0.065
                          )),
                          Icon(Icons.arrow_forward_ios_outlined,color: colorTheme.primaryColor,)
                        ],
                      ),
                    )
                  ],
                )
              ),
            ),
          ],
        ),
      ),
    );
  }
}
