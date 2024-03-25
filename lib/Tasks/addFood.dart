import 'dart:core';

import 'package:crud/Tasks/checkoutPage.dart';
import 'package:crud/classes/colorTheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class addFood extends StatefulWidget {
  const addFood({super.key});

  @override
  State<addFood> createState() => _addFoodState();
}

class _addFoodState extends State<addFood> {

  List foodList = [
    {
      "name":"Chicken Mingles Bucket Meal",
      "price":499,
      "quantity":0,
      "descriptions":"->4 Hot Wings,\n->2 Chicken Peri Peri Boneless Strips,\n->Medium Fries",
      "image":"assets/images/chicken mingles.jpg",
      "addons":[{
        "name":"Mayonnise",
        "quantity":0,
        "price":25,
      },
      {
        "name":"Ketchup",
        "quantity":0,
        "price":20,
      },
      {
        "name":"Sprite",
        "quantity":0,
        "price":40,
      },
     {
        "name":"Cocacola",
        "quantity":0,
        "price":45,
      }],

    },
    {
      "name":"Chicken Bucket",
      "price":699,
      "quantity":0,
      "descriptions":"->6 Hot Wings,\n->4 Chicken Peri Peri Boneless Strips,\n->Medium Fries",
      "image":"assets/images/chicken bucket.png",
      "addons":[{
        "name":"Mayonnise",
        "quantity":0,
        "price":25,
      },
        {
          "name":"Ketchup",
          "quantity":0,
          "price":20,
        },
        {
          "name":"Sprite",
          "quantity":0,
          "price":40,
        },
        {
          "name":"Cocacola",
          "quantity":0,
          "price":45,
        }],
    },
    {
      "name":"Chicken Chizza",
      "price":319,
      "quantity":0,
      "descriptions":"->Crunchy chicken topped with cheese,\n spicy sauce, veggies & herbs",
      "image":"assets/images/chicken chizza.jpg",
      "addons":[{
        "name":"Mayonnise",
        "quantity":0,
        "price":25,
      },
        {
          "name":"Ketchup",
          "quantity":0,
          "price":20,
        },
        {
          "name":"Sprite",
          "quantity":0,
          "price":40,
        },
        {
          "name":"Cocacola",
          "quantity":0,
          "price":45,
        }],

    },
    {
      "name":"Zinger Pro Burger",
      "price":239,
      "quantity":0,
      "descriptions":"Premium burger with crunchy chicken,\n Mexican habanero sauce, cheese,tomato & onion",
      "image":"assets/images/zinger burger.jpg",
      "addons":[{
        "name":"Mayonnise",
        "quantity":0,
        "price":25,
      },
        {
          "name":"Ketchup",
          "quantity":0,
          "price":20,
        },
        {
          "name":"Sprite",
          "quantity":0,
          "price":40,
        },
        {
          "name":"Cocacola",
          "quantity":0,
          "price":45,
        }],
    },
    {
      "name":"Double Chicken Roll",
      "price":168,
      "quantity":0,
      "descriptions":"->Double fun with double chicken \nstrip filling, layerful parantha onion",
      "image":"assets/images/chicken roll.jpg",
      "addons":[{
        "name":"Mayonnise",
        "quantity":0,
        "price":25,
      },
        {
          "name":"Ketchup",
          "quantity":0,
          "price":20,
        },
        {
          "name":"Sprite",
          "quantity":0,
          "price":40,
        },
        {
          "name":"Cocacola",
          "quantity":0,
          "price":45,
        }],
    },
  ];

  List addedValue = [];
  List saveAdd = [];
  List saveItems = [];
  List done = [];


  List<Map<String,dynamic>> totalItems = [];
  List addings = [];
  var addons;


num total = 0;
getTotal(){
  for(int i = 0;i<totalItems.length;i++){
    total = total + (totalItems[i]["itemPrice"])*(totalItems[i]["itemQuantity"]);
    for(int j = 0; j <totalItems[i]["addons"].length;j++){
      total = total + (totalItems[i]["addons"][i]["price"])*(totalItems[i]["addons"][i]["quantity"]);
    }
    setState(() {

    });
  }
}
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      bottomNavigationBar: done.isNotEmpty ?Container(
        height: width*0.2,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("₹$total/-",
                    style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.w700,
                        fontSize: width*0.055
                    )),
                InkWell(
                  onTap: () {
                    //getTotal();
                    // Navigator.push(context, MaterialPageRoute(builder: (context) => checkoutPage(
                    //   items: totalItems,
                    //   addings: addings,
                    // ),));
                  },
                  child: Container(
                    height: width*0.12,
                    width: width*0.6,
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(width*0.07),
                        boxShadow:[
                          BoxShadow(
                              offset: Offset(0,4),
                              spreadRadius: 0,
                              blurRadius: 5,
                              color: colorTheme.secondaryColor.withOpacity(0.25)
                          ),
                        ]
                    ),
                    child: Center(child: Text("Checkout!",style: TextStyle(
                        color: colorTheme.primaryColor,
                        fontWeight: FontWeight.w600
                    ),)),
                  ),
                )
              ],
            ),
          ],
        ),
      ):SizedBox(),
      backgroundColor: Colors.grey,
      drawer: Drawer(),
      appBar: AppBar(
        title: Text("KFC"),
        backgroundColor: Colors.red,
        actions: [
          InkWell(
              onTap: () {
                print(totalItems);
              },
              child: Icon(CupertinoIcons.heart)),
          SizedBox(width: width*0.05,),
          Icon(CupertinoIcons.bag),
          SizedBox(width: width*0.05,),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: foodList.length,
              itemBuilder: (BuildContext context, int index) {
                addons = foodList[index]["addons"];
                return Container(
                  height:saveAdd.contains(index) && saveItems.contains(index)? width*0.7:width*0.5,
                  width: width*1,
                  margin: EdgeInsets.only(bottom: width*0.03),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(width*0.03),
                      color: colorTheme.primaryColor
                  ),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Container(
                                height: width*0.3,
                                width: width*0.3,
                                margin: EdgeInsets.all(width*0.03),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(width*0.03),
                                    image: DecorationImage(image: AssetImage(foodList[index]["image"]))
                                )),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(foodList[index]["name"],style: TextStyle(
                                    fontSize: width*0.035,
                                    fontWeight: FontWeight.w700
                                )),
                                Text(foodList[index]["descriptions"],style: TextStyle(
                                  fontSize: width*0.03,
                                ),),
                                saveAdd.contains(index) && !done.contains(index)?InkWell(
                                  onTap: () {
                                   // more = !more;
                                    if(saveItems.contains(index)){
                                      saveItems.remove(index);
                                    }else{
                                      saveItems.add(index);
                                    }
                                    setState(() {

                                    });
                                  },
                                  child: SizedBox(
                                    child: Column(
                                      children: [
                                        Text("Add items",style: TextStyle(fontSize: width*0.025)),
                                        Icon(saveItems.contains(index)?CupertinoIcons.chevron_up:CupertinoIcons.chevron_down,size: width*0.05),
                                      ],
                                    ),
                                  ),
                                ):SizedBox()
                              ],
                            ),
                            SizedBox(width:width*0.04),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Center(child: Text("${foodList[index]["price"]}/-",style: TextStyle(
                                    fontWeight: FontWeight.w700
                                ),)),
                                InkWell(
                                  onTap: () {

                                    if(saveAdd.contains(index)){
                                      saveAdd.remove(index);
                                    }else{
                                      saveAdd.add(index);
                                    }
                                    if(saveAdd.contains(index)){
                                      addedValue.add(foodList[index]["price"]);
                                    }else{
                                      addedValue.remove(foodList[index]["price"]);
                                    }
                                    setState(() {

                                    });
                                  },
                                  child: Container(
                                    width: width*0.15,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(width*0.02),
                                        color: saveAdd.contains(index)?Colors.green:Colors.red
                                    ),
                                    child: Center(child: Text(saveAdd.contains(index)?"Added":"Add",style: TextStyle(color: colorTheme.primaryColor,fontWeight: FontWeight.w600))),
                                  ),
                                ),
                                saveAdd.contains(index) && !done.contains(index)?
                                    Row(
                                      children: [
                                        IconButton(
                                            onPressed: () {
                                              foodList[index]["quantity"]==0?0
                                                  :foodList[index]["quantity"]--;
                                              setState(() {
                                                //getTotal();
                                              });
                                        },
                                            icon: Icon(Icons.remove)),
                                        Text(foodList[index]["quantity"].toString()),
                                        IconButton(
                                            onPressed: () {
                                              foodList[index]["quantity"]++;
                                              setState(() {
                                                //getTotal();
                                              });
                                        },
                                            icon: Icon(Icons.add)),
                                      ],
                                    ):Text((foodList[index]["quantity"]).toString())
                              ],
                            ),
                          ],
                        ),
                        saveItems.contains(index) && saveAdd.contains(index) && !done.contains(index)?
                        Column(
                          children: [
                            Row(
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(addons[0]["name"]
                                          ,style: TextStyle(fontSize: width*0.03),),
                                        SizedBox(width: width*0.02,),
                                        // tick1?
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            InkWell(
                                                onTap:() {
                                                  addons[0]["quantity"] == 0?0:addons[0]["quantity"]--;
                                                  setState(() {

                                                  });
                                                },
                                                child: CircleAvatar(backgroundColor:Colors.red,radius:width*0.03,child: Icon(Icons.remove,size: width*0.04,))),
                                            Padding(
                                              padding:EdgeInsets.only(left: width*0.02,right: width*0.02),
                                              child: Text(addons[0]["quantity"].toString()),
                                            ),
                                            InkWell(
                                                onTap: () {
                                                  addons[0]["quantity"]++;
                                                  setState(() {

                                                  });
                                                },
                                                child: CircleAvatar(backgroundColor:Colors.green,radius:width*0.03,child: Icon(Icons.add,size: width*0.04))),
                                          ],
                                        )
                                            //:SizedBox()
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(addons[1]["name"]
                                          ,style: TextStyle(fontSize: width*0.03),),
                                        SizedBox(width: width*0.02,),
                                        // tick2?
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            InkWell(
                                                onTap:() {
                                                  addons[1]["quantity"] == 0?0:addons[1]["quantity"]--;
                                                  setState(() {

                                                  });
                                                },
                                                child: CircleAvatar(backgroundColor:Colors.red,radius:width*0.03,child: Icon(Icons.remove,size: width*0.04,))),
                                            Padding(
                                              padding:EdgeInsets.only(left: width*0.02,right: width*0.02),
                                              child: Text(addons[1]["quantity"].toString()),
                                            ),
                                            InkWell(
                                                onTap: () {
                                                  addons[1]["quantity"]++;
                                                  setState(() {

                                                  });
                                                },
                                                child: CircleAvatar(backgroundColor:Colors.green,radius:width*0.03,child: Icon(Icons.add,size: width*0.04))),
                                          ],
                                        )
                                            //:SizedBox()
                                      ],
                                    ),
                                  ],
                                ),
                                Container(height: width*0.2,
                                  width: width*0.002,
                                  color: Colors.black,),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(addons[2]["name"],style: TextStyle(fontSize: width*0.03),),
                                        SizedBox(width: width*0.02,),
                                        // tick3?
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            InkWell(
                                                onTap:() {
                                                  addons[2]["quantity"]==0?0:addons[2]["quantity"]--;
                                                  setState(() {

                                                  });
                                                },
                                                child: CircleAvatar(backgroundColor:Colors.red,radius:width*0.03,child: Icon(Icons.remove,size: width*0.04,))),
                                            Padding(
                                              padding:EdgeInsets.only(left: width*0.02,right: width*0.02),
                                              child: Text(addons[2]["quantity"].toString()),
                                            ),
                                            InkWell(
                                                onTap: () {
                                                  addons[2]["quantity"]++;
                                                  setState(() {

                                                  });
                                                },
                                                child: CircleAvatar(backgroundColor:Colors.green,radius:width*0.03,child: Icon(Icons.add,size: width*0.04))),
                                          ],
                                        )
                                            //:SizedBox()
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(addons[3]["name"],style: TextStyle(fontSize: width*0.03),),
                                        SizedBox(width: width*0.02,),
                                        //tick4?
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            InkWell(
                                                onTap:() {
                                                  addons[3]["quantity"]==0?0:addons[3]["quantity"]--;
                                                  setState(() {

                                                  });
                                                },
                                                child: CircleAvatar(backgroundColor:Colors.red,radius:width*0.03,child: Icon(Icons.remove,size: width*0.04,))),
                                            Padding(
                                              padding:EdgeInsets.only(left: width*0.02,right: width*0.02),
                                              child: Text(addons[3]["quantity"].toString()),
                                            ),
                                            InkWell(
                                                onTap: () {
                                                  addons[3]["quantity"]++;
                                                  setState(() {

                                                  });
                                                },
                                                child: CircleAvatar(backgroundColor:Colors.green,radius:width*0.03,child: Icon(Icons.add,size: width*0.04))),
                                          ],
                                        )
                                            //:SizedBox()
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        )

                            :SizedBox(),
                        saveAdd.contains(index)?
                        InkWell(
                          onTap: () {

                            if(done.contains(index)){
                              done.remove(index);
                            }else{
                              done.add(index);
                            }
                            totalItems.addAll([{
                              "itemImage":foodList[index]["image"],
                              "itemName":foodList[index]["name"],
                              "itemPrice":foodList[index]["price"]*foodList[index]["quantity"],
                              "itemQuantity":foodList[index]["quantity"],
                              "addons":[{
                                "name":addons[0]["name"],
                                "price":addons[0]["price"],
                                "quantity":addons[0]["quantity"],
                              },
                              {
                                "name":addons[1]["name"],
                                "price":addons[1]["price"],
                                "quantity":addons[1]["quantity"],
                              },
                              {
                                "name":addons[2]["name"],
                                "price":addons[2]["price"],
                                "quantity":addons[2]["quantity"],
                              },
                              {
                                "name":addons[3]["name"],
                                "price":addons[3]["price"],
                                "quantity":addons[3]["quantity"],
                              }],
                            }]);
                            setState(() {
                              getTotal();
                            });
                          },
                          child:done.contains(index)?
                          Icon(Icons.done,color: Colors.green,)
                              :Container(
                            height: width*0.1,
                            width: width*0.25,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(width*0.03),
                                color: Colors.green
                            ),
                            child: Center(child: Text("Done",style: TextStyle(color: Colors.white),),),
                          ),
                        ):SizedBox()
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
