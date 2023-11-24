import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:goeasy/main.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:goeasy/screens/home.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:uropnew/home/home.dart';

class signup extends StatelessWidget {
  String? first_name_f;
  String? last_name_f;
  String? phonenumber_f;
  String? pincode_f;
  String? city_f;
  String? street_f;
  String? district_f;
  String? state_f;

  Widget name() {
    return Container(
      margin: EdgeInsets.only(top: 10, left: 5, right: 5),
      child: Row(
        children: [
          Expanded(
            child: Container(
              // margin: EdgeInsets.only(top: 20,left: 5,right: 5,bottom: 5),
              child: TextFormField(
                onChanged: (name) {
                  first_name_f = name;
                },
                decoration: const InputDecoration(
                    fillColor: Colors.black,
                    border: OutlineInputBorder(),
                    labelText: 'First Name',
                    labelStyle: TextStyle(color: Colors.black),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Colors.black,
                      width: 1.5,
                    )),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Colors.black,
                      width: 1.5,
                    ))),
              ),
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 5),
              child: TextFormField(
                onChanged: (name) {
                  last_name_f = name;
                },
                decoration: const InputDecoration(
                  fillColor: Colors.black,
                  border: OutlineInputBorder(),
                  labelText: 'Last Name',
                  labelStyle: TextStyle(color: Colors.black),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                    color: Colors.black,
                    width: 1.5,
                  )),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                    color: Colors.black,
                    width: 1.5,
                  )),
                  // errorText: validate && (phonenumber?.isEmpty ?? true)
                  //   ? "This Field cannot be empty"
                  //   :null      ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget phone() {
    return Container(
      child: Container(
        // height: 100,
        margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        child: TextFormField(
          onChanged: (number) {
            phonenumber_f = number;
          },
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: "Phonenumber",
            fillColor: Colors.black,
            border: OutlineInputBorder(),
            labelStyle: TextStyle(color: Colors.black),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black,
                width: 1.5,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black,
                width: 1.5,
              ),
            ),
            // errorText: validate && (phonenumber?.isEmpty ?? true)
            //     ? "This Field cannot be empty"
            //     :null
          ),
        ),
      ),
    );
  }

  Widget address() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                child: TextFormField(
                  onChanged: (code) {
                    pincode_f = code;
                  },
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      fillColor: Colors.black,
                      border: OutlineInputBorder(),
                      labelText: 'Pincode',
                      labelStyle: TextStyle(color: Colors.black),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                        color: Colors.black,
                        width: 1.5,
                      )),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                        color: Colors.black,
                        width: 1.5,
                      ))),
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 5),
                child: TextFormField(
                  onChanged: (city_name) {
                    city_f = city_name;
                  },
                  decoration: const InputDecoration(
                    fillColor: Colors.black,
                    border: OutlineInputBorder(),
                    labelText: 'City',
                    labelStyle: TextStyle(color: Colors.black),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Colors.black,
                      width: 1.5,
                    )),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Colors.black,
                      width: 1.5,
                    )),
                    // errorText: validate && (phonenumber?.isEmpty ?? true)
                    //   ? "This Field cannot be empty"
                    //   :null      ),
                  ),
                ),
              ),
            ),
          ],
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          child: TextFormField(
            onChanged: (district_name) {
              district_f = district_name;
            },
            decoration: const InputDecoration(
              fillColor: Colors.black,
              border: OutlineInputBorder(),
              labelText: 'District',
              labelStyle: TextStyle(color: Colors.black),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                color: Colors.black,
                width: 1.5,
              )),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                color: Colors.black,
                width: 1.5,
              )),
              // errorText: validate && (phonenumber?.isEmpty ?? true)
              //   ? "This Field cannot be empty"
              //   :null      ),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          child: TextFormField(
            onChanged: (street_name) {
              street_f = street_name;
            },
            decoration: const InputDecoration(
              fillColor: Colors.black,
              border: OutlineInputBorder(),
              labelText: 'Address, streetname, Building no etc..',
              labelStyle: TextStyle(color: Colors.black),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                color: Colors.black,
                width: 1.5,
              )),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                color: Colors.black,
                width: 1.5,
              )),
              // errorText: validate && (phonenumber?.isEmpty ?? true)
              //   ? "This Field cannot be empty"
              //   :null      ),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          child: TextFormField(
            onChanged: (state_name) {
              state_f = state_name;
            },
            decoration: const InputDecoration(
              fillColor: Colors.black,
              border: OutlineInputBorder(),
              labelText: 'State',
              labelStyle: TextStyle(color: Colors.black),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                color: Colors.black,
                width: 1.5,
              )),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                color: Colors.black,
                width: 1.5,
              )),
              // errorText: validate && (phonenumber?.isEmpty ?? true)
              //   ? "This Field cannot be empty"
              //   :null      ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    void _register() async {
      // print(first_name_f);
      // print(last_name_f);
      // print(phonenumber_f);
      // print(pincode_f);
      // print(city_f);
      // print(street_f);
      // print(district_f);
      // print(state_f);

      final String apiUrl = 'http://10.1.178.164:8000/server/receive/';

      // Your data to send
      final Map<String, dynamic> dataToSend = {
        'first_name': first_name_f,
        'last_name': last_name_f,
        'phone': phonenumber_f,
        'pincode': pincode_f,
        'city': city_f,
        'street': street_f,
        'district': district_f,
        'state': state_f,
        // Add your actual data here
      };

      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(dataToSend),
      );

      if (response.statusCode == 200) {
        print('Data sent successfully.');
         Navigator.push(context, MaterialPageRoute(builder: (context)=>home()));
      } else {
        print('Failed to send data. Status code: ${response.statusCode}');
      }
    }

    Widget button() {
      return Container(
          margin: EdgeInsets.only(left: 5, right: 5, top: 30),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: TextButton(
                style: TextButton.styleFrom(
                    // padding: EdgeInsets.symmetric(horizontal: 200),
                    backgroundColor: Colors.black),
                onPressed: () {
                  _register();
                },
                child: Text(
                  "Sign up",
                  style: TextStyle(
                    backgroundColor: Colors.black,
                    color: Colors.white,
                  ),
                )),
          ));
    }

    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return Scaffold(
        appBar: AppBar(
            // elevation: 0.5,
            backgroundColor: Colors.white,
            title: Container(
              // padding: EdgeInsets.only(bottom: 20),
              // margin: EdgeInsets.only(top: 10),
              child: Text(
                "Enter detailes",
                style: TextStyle(color: Colors.black),
              ),
            ),
            leading: Container(
              // padding: EdgeInsets.only(bottom: 20),
              // margin: EdgeInsets.only(top: 10),
              child: IconButton(
                icon: Icon(Icons.arrow_back),
                iconSize: 25.0,
                color: Colors.black,
                onPressed: () {
                  // Navigator.push(context, MaterialPageRoute(builder: (context) => Vachileowner()),);
                },
              ),
            )),
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: SingleChildScrollView(
            child: Column(
              children: [name(), phone(), address(), button()],
            ),
          ),
        ));
  }
}
