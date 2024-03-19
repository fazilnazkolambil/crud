import 'dart:convert';
import 'package:crud/classes/colorTheme.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../main.dart';

class postalCheck extends StatefulWidget {
  const postalCheck({super.key});

  @override
  State<postalCheck> createState() => _postalCheckState();
}

class _postalCheckState extends State<postalCheck> {
  http.Response? apiData;

  List api = [];
  //List api2 = [];
  List postOffice = [];

  TextEditingController search_controller = TextEditingController();

  getPostalCodes() async {

    apiData = await http.get(Uri.tryParse("https://india-pincode-with-latitude-and-longitude.p.rapidapi.com/api/v1/pincode/643233")!);
    print(apiData!.statusCode);
    // print("aaaaaaaaaaaaaaaaaaaaa${apiData!.body}aaaaaaaaaaaaaaaaaaaaaaa");

    // c=json.decode('[{"Message": "Number of pincode(s) found:5","Status": "Success"}]');
    // print(c);
    api = json.decode(apiData!.body);
    print(api);

    if (apiData != null ) {
      postOffice = api[0]["PostOffice"] ?? [];
      setState(() {
      });
    }
    // if(apiData2 != null){
    //   postOffice = api2[0]["PostOffice"] ?? [];
    //   setState(() {
    //
    //   });
    // }
    setState(() {

    });
  }
  // @override
  // void initState() {
  //   getPostalCodes();
  //   // TODO: implement initState
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorTheme.primaryColor,
      appBar: AppBar(
        backgroundColor: colorTheme.primaryColor,
        elevation: 0,
        leading: InkWell(
            onTap: () {
              print(apiData);
              print(apiData!.statusCode);
              //Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios_new)),
        iconTheme: IconThemeData(color: colorTheme.secondaryColor),
        title: Text("Postal Codes",
            style: TextStyle(
                color: colorTheme.secondaryColor, fontSize: width * 0.06)),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(width * 0.03),
        child: Column(
          children: [
            TextFormField(
              controller: search_controller,
              // maxLength: 6,
              onChanged: (value) {
                getPostalCodes();
                setState(() {
                  search_controller.text=value;
                });
              },
              onFieldSubmitted: (value) {
                getPostalCodes();
              },
              decoration: InputDecoration(
                counterText: "",
                labelText: "Enter pincode",
                labelStyle: TextStyle(color: colorTheme.secondaryColor),
                filled: true,
                constraints: BoxConstraints(maxHeight: width * 0.13),
                prefixIcon: Icon(
                  Icons.search,
                  color: colorTheme.font2,
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(width * 0.02),
                    borderSide: BorderSide.none),
              ),
            ),
            SizedBox(height: width * 0.05),
            Expanded(
              child: ListView.builder(
                itemCount: postOffice.length,
                physics: BouncingScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    //height: width * 0.2,
                    width: width * 1,
                    margin: EdgeInsets.only(top: width * 0.05),
                    padding: EdgeInsets.all(width * 0.03),
                    decoration: BoxDecoration(
                        color: colorTheme.neutral,
                        borderRadius: BorderRadius.circular(width * 0.03)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text("Postoffice : ${postOffice[index]["Name"]}",
                            style: TextStyle(fontWeight: FontWeight.w600)),
                        Text("Pincode : ${postOffice[index]["Pincode"]}",
                            style: TextStyle(fontWeight: FontWeight.w600)),
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
