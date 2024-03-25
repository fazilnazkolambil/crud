import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../main.dart';

class checkoutPage extends StatefulWidget {
  final List? items, addings;
  const checkoutPage({super.key,required this.items,required this.addings});

  @override
  State<checkoutPage> createState() => _checkoutPageState();
}

class _checkoutPageState extends State<checkoutPage> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      drawer: Drawer(),
      appBar: AppBar(
        title: Text("KFC"),
        backgroundColor: Colors.red,
        actions: [
          Icon(CupertinoIcons.heart),
          SizedBox(width: width*0.05,),
          InkWell(
              onTap: () {
                print(widget.items);
                //print(widget.items![1]["dip1"]);
              },
              child: Icon(CupertinoIcons.bag)),
          SizedBox(width: width*0.05,),
        ],
      ),
      body: Column(
        children: [
          Text("Orders",style: TextStyle(fontSize: width*0.06,fontWeight: FontWeight.w700)),
          Expanded(
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: widget.items!.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  height: width*0.5,
                  width: width*1,
                  decoration: BoxDecoration(
                      border: Border.all()
                  ),
                  child: Row(
                    children: [
                      Container(
                          height: width*0.3,
                          width: width*0.3,
                          margin: EdgeInsets.all(width*0.03),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(width*0.03),
                              image: DecorationImage(image: AssetImage(widget.items![index]["itemImage"]))
                          )),
                      Container(
                        width: width*0.5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            widget.items!.isNotEmpty?
                            Row(
                              mainAxisAlignment:MainAxisAlignment.spaceBetween,
                              children: [
                                Text("${(widget.items![index]["itemName"]).toString().substring(0,10)}...",style: TextStyle(fontWeight: FontWeight.w700),),
                                Text((widget.items![index]["itemQuantity"]).toString(),style: TextStyle(fontWeight: FontWeight.w700),),
                                Text("₹${widget.items![index]["itemPrice"]}",style: TextStyle(fontWeight: FontWeight.w700)),
                              ],
                            ):SizedBox(),
                            widget.items![index]["dip1"]["quantity"] == 0 ? SizedBox()
                            :Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(widget.items![index]["dip1"]["name"]),
                                Text((widget.items![index]["dip1"]["quantity"]).toString()),
                                Text((widget.items![index]["dip1"]["quantity"]*widget.items![index]["dip1"]["price"]).toString()),
                              ],
                            ),
                            widget.items![index]["dip2"]["quantity"] == 0 ? SizedBox()
                                :Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(widget.items![index]["dip2"]["name"]),
                                Text((widget.items![index]["dip2"]["quantity"]).toString()),
                                Row(
                                  children: [
                                    Text((widget.items![index]["dip2"]["quantity"]*widget.items![index]["dip2"]["price"]).toString()),
                                  ],
                                ),

                              ],
                            ),
                            widget.items![index]["drink1"]["quantity"] == 0 ? SizedBox()
                                :Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(widget.items![index]["drink1"]["name"]),
                                Text((widget.items![index]["drink1"]["quantity"]).toString()),
                                Row(
                                  children: [
                                    Text((widget.items![index]["drink1"]["quantity"]*widget.items![index]["drink1"]["price"]).toString()),
                                  ],
                                ),

                              ],
                            ),
                            widget.items![index]["drink2"]["quantity"] == 0 ? SizedBox()
                                :Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(widget.items![index]["drink2"]["name"]),
                                Text((widget.items![index]["drink2"]["quantity"]).toString()),
                                Row(
                                  children: [
                                    Text((widget.items![index]["drink2"]["quantity"]*widget.items![index]["drink2"]["price"]).toString()),
                                  ],
                                ),

                              ],
                            ),
                            Divider(
                              color: Colors.black,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Total",style: TextStyle(fontWeight: FontWeight.w700)),
                                Text(
                                    "₹${(widget.items![index]["itemPrice"]+
                                    (widget.items![index]["dip1"]["quantity"]*widget.items![index]["dip1"]["price"])+
                                    (widget.items![index]["dip2"]["quantity"]*widget.items![index]["dip2"]["price"])+
                                    (widget.items![index]["drink1"]["quantity"]*widget.items![index]["drink1"]["price"])+
                                    (widget.items![index]["drink2"]["quantity"]*widget.items![index]["drink2"]["price"]))}/-"
                                ,style: TextStyle(fontWeight: FontWeight.w700)),
                              ],
                            ),

                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          // ElevatedButton(
          //     onPressed: () {
          //       print(widget.items!);
          //     },
          //     child: Text("check"))
        ],
      ),
    );
  }
}
