import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud/classes/colorTheme.dart';
import 'package:crud/classes/imagePage.dart';
import 'package:crud/mainPages/addUser.dart';
import 'package:crud/mainPages/editUser.dart';
import 'package:crud/mainPages/profilePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

class users extends StatefulWidget {
  const users({super.key});

  @override
  State<users> createState() => _usersState();
}

class _usersState extends State<users> {
  String userName = '';
  String password = '';
  String email = '';
  String userid = '';
  String userImage = '';
  // getName() async {
  //   SharedPreferences prefs=await SharedPreferences.getInstance();
  //   userName=prefs.getString("name") ?? "";
  //   password=prefs.getString("password") ?? "";
  //   email=prefs.getString("email") ?? "";
  //   userid=prefs.getString("id") ?? "";
  //   userImage=prefs.getString("image") ?? "";
  //   setState(() {
  //
  //   });
  // }
  getImage() async {
    var data=await FirebaseFirestore.instance.collection("users").get();
    for(var docs in data.docs){
      FirebaseFirestore.instance.collection("users").doc(docs.id).update({
        "image":"https://e7.pngegg.com/pngimages/799/987/png-clipart-computer-icons-avatar-icon-design-avatar-heroes-computer-wallpaper.png"
      });
    }
  }
  @override
  void initState() {
    //getName();
    // getImage();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorTheme.primaryColor,
      floatingActionButton: FloatingActionButton(
        backgroundColor: colorTheme.fontColor,
        child: Icon(Icons.add),
        onPressed: () async{

          // var data = await FirebaseFirestore.instance.collection('users').get();
          //
          // for(var docs in data.docs){
          //   FirebaseFirestore.instance.collection('users').doc(docs.id).update(
          //     {
          //       'image':'https://e7.pngegg.com/pngimages/348/800/png-clipart-man-wearing-blue-shirt-illustration-computer-icons-avatar-user-login-avatar-blue-child.png'
          //     }
          //   );
          // }



           Navigator.push(context, MaterialPageRoute(builder: (context) => addUser(),));
        },
      ),
      appBar: AppBar(
        backgroundColor: colorTheme.primaryColor,
        leadingWidth: 0,
        elevation: 0,
        title: Text("Hello, $userName",style: TextStyle(
            color: colorTheme.secondaryColor,
            fontSize: width*0.06
        )),
        actions: [
          InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => profilePage(
              //   userName: userName,
              //   password: password,
              //   email: email,
              //   id: userid,
              //   image: userImage,
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
      body: Padding(
        padding:EdgeInsets.all(width*0.03),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Current Users",style: TextStyle(
                color: colorTheme.secondaryColor,
                fontSize: width*0.06
            )),
            SizedBox(height: width*0.03,),
            Expanded(
              child: StreamBuilder<QuerySnapshot<Map<String,dynamic>>>(
                stream: FirebaseFirestore.instance.collection("users").snapshots(),
                builder: (context, snapshot) {
                  if(!snapshot.hasData){
                    return Center(child: CircularProgressIndicator());
                  }
                  var data=snapshot.data!.docs;
                  return data.length==0?
                      Center(child: Text("No Users found!")):
                   ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                          height: width*0.2,
                          width: width*1,
                          margin: EdgeInsets.only(bottom: width*0.03),
                          decoration: BoxDecoration(
                              color: colorTheme.neutral,
                              borderRadius: BorderRadius.circular(width*0.02)
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [

                              CircleAvatar(
                                backgroundImage:NetworkImage(data[index]["image"]),
                              ),
                              Container(
                                height: width*0.1,
                                width: width*0.5,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(data[index]["name"],style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: width*0.03
                                    )),
                                    Text(data[index]["email"],style: TextStyle(
                                        fontSize: width*0.03
                                    )),
                                  ],
                                ),
                              ),
                              InkWell(
                                  onTap: () {
                                    showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          backgroundColor: colorTheme.primaryColor,
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(width*0.03)),
                                          content: Container(
                                            height: width*0.36,
                                            width: width*0.4,
                                            child: Column(
                                              children: [
                                                Text("Are you Sure\n"
                                                    "You Want to delete User ?",
                                                  textAlign: TextAlign.center,
                                                ),
                                                Divider(),
                                                InkWell(
                                                  onTap: () {
                                                    FirebaseFirestore.instance.collection("users").doc(data[index]["id"]).delete();
                                                    Navigator.pop(context);
                                                  },
                                                    child: Text("Yes",style: TextStyle(color: colorTheme.red),)),
                                                Divider(),
                                                InkWell(
                                                    onTap: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text("Cancel",style: TextStyle(color: colorTheme.font2),)),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: SvgPicture.asset(iconPage.delete,color: colorTheme.red,width: width*0.06)),
                              InkWell(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => editUser(
                                      name: data[index]["name"],
                                      email: data[index]["email"],
                                      password: data[index]["password"],
                                      id: data[index]["id"],
                                      image: data[index]["image"]

                                    ),));
                                  },
                                  child: Icon(Icons.edit_outlined,color: colorTheme.fontColor,))
                            ],
                          )
                      );
                    },

                  );
                }
              ),
            )
          ],
        ),
      ),
    );
  }
}
