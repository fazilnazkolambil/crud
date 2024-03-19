import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud/classes/colorTheme.dart';
import 'package:crud/classes/imagePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'main.dart';
import 'mainPages/addUser.dart';
import 'mainPages/editUser.dart';
import 'mainPages/profilePage.dart';

class newPage extends StatefulWidget {
  const newPage({super.key});

  @override
  State<newPage> createState() => _newPageState();
}

class _newPageState extends State<newPage> {
 //var a = FirebaseFirestore.instance.collection("user");
  String? name;
  getData() async {
    SharedPreferences prefs=await SharedPreferences.getInstance();
    name=prefs.getString("name");
  }
  @override
  void initState() {
    getData();
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
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => addUser(),));
        },
      ),
      appBar: AppBar(
        backgroundColor: colorTheme.primaryColor,
        leadingWidth: 0,
        elevation: 0,
        title: Text("Hello, $name",style: TextStyle(
            color: colorTheme.secondaryColor,
            fontSize: width*0.06
        )),
        actions: [
          InkWell(
            onTap: () {
             // Navigator.push(context, MaterialPageRoute(builder: (context) => profilePage(),));
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
                           child: StreamBuilder(
                             stream: FirebaseFirestore.instance.collection("users").snapshots(),
                             builder: (context, snapshot) {
                               if(snapshot.data!.docs.isEmpty){
                                 return Center(child: CircularProgressIndicator());
                               }
                               var datas=snapshot.data!.docs;
                               return ListView.builder(
                                 physics: BouncingScrollPhysics(),
                                 itemCount: datas.length,
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
                                           CircleAvatar(),
                                           Container(
                                             height: width*0.1,
                                             width: width*0.5,
                                             child: Column(
                                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                               crossAxisAlignment: CrossAxisAlignment.start,
                                               children: [
                                                 Text(datas[index]["name"],style: TextStyle(
                                                     fontWeight: FontWeight.w600,
                                                     fontSize: width*0.03
                                                 )),
                                                 Text(datas[index]["password"],style: TextStyle(
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
                                                             Text("Yes",style: TextStyle(color: colorTheme.red),),
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
                                                 // Navigator.push(context, MaterialPageRoute(builder: (context) => editUser(),));
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
