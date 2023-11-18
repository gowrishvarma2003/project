import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../main.dart' as mainfile;

class seller extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _sellerstate();
}

class _sellerstate extends State<seller> {
  String? sellername;
  String? phonenumber_f;
  String? pincode_f;
  String? city_f;
  String? street_f;
  String? district_f;
  String? state_f;

  bool agree = false;

  Widget name() {
    return Container(
      margin: EdgeInsets.only(top: 15),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5),
        child: TextFormField(
          onChanged: (name) {
            sellername = name;
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
      print(sellername);
      print(phonenumber_f);
      print(pincode_f);
      print(city_f);
      print(street_f);
      print(district_f);
      print(state_f);

      final String apiUrl = 'http://' + mainfile.ip + '/server/sellers/';

      // Your data to send
      final Map<String, dynamic> dataToSend = {
        'seller_name': sellername,
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
      } else {
        print('Failed to send data. Status code: ${response.statusCode}');
      }
    }

    Widget button() {
      return Container(
          margin: EdgeInsets.only(left: 5, right: 5, top: 20),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: TextButton(
                style: TextButton.styleFrom(
                    // padding: EdgeInsets.symmetric(horizontal: 200),
                    backgroundColor: Colors.black),
                onPressed: () {
                  if (agree) {
                    _register();
                    // Navigator.push(context, MaterialPageRoute(builder: (context)=>getbike()));
                  }
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
                "seller registration",
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
              children: [
                name(),
                phone(),
                address(),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    children: [
                      Checkbox(
                          value: agree,
                          onChanged: (bool? value) {
                            setState(() {
                              agree = value!;
                            });
                            print(agree);
                          }),
                      Text(
                        "Read the Instructions carefully and agree \n to the above conditions",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                ),
                button()
              ],
            ),
          ),
        ));
  }
}