import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:goeasy/screens/signup/otp.dart';
// import 'package:goeasy/screens/login.dart';
// import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import '../../main.dart';
import 'package:uropnew/auth/otp.dart';

class verify extends StatefulWidget {
  static String verified = "";
  @override
  State<StatefulWidget> createState() => _verifystate();
}

class _verifystate extends State<verify> {
  TextEditingController countrycode = TextEditingController();
  var phonenumber = "";

  @override
  Widget build(BuildContext context) {
    var countrycode = "+91";
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white, // Set the background color to white
        title: Text(
          'Sign in',
          style: TextStyle(color: Colors.black), // Set text color to black
        ),
        iconTheme:
            IconThemeData(color: Colors.black), // Set icon color to black
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              // margin: EdgeInsets.only(top: 40),
              child: Text(
              "Enter Phone number for \n Verification",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 50,top: 10),
              child: Text(
              "This number will be used for all rides related \n communication. You shall recive an SMS \n with code for verfication",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            ),
            SizedBox(height: 32),
            TextField(
              keyboardType:
                  TextInputType.number, // Set the keyboard type to number
              onChanged: (value) {
                phonenumber = value;
                print(phonenumber);
              },
              decoration: InputDecoration(
                hintText: 'Your number',
              ),
            ),
            Container(
          margin: EdgeInsets.only(left: 20, right: 20, top: 20),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: TextButton(
                style: TextButton.styleFrom(
                    // padding: EdgeInsets.symmetric(horizontal: 200),
                    backgroundColor: Colors.black),
                onPressed: () async {
                  await FirebaseAuth.instance.verifyPhoneNumber(
                    phoneNumber: countrycode + phonenumber,
                    verificationCompleted: (PhoneAuthCredential credential) {},
                    verificationFailed: (FirebaseAuthException e) {},
                    codeSent: (String verificationId, int? resendToken) {
                      verify.verified = verificationId;
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => otp(phone: phonenumber),
                          // settings: RouteSettings(
                          //   arguments: phonenumber
                          // )
                        ),
                      );
                    },
                    codeAutoRetrievalTimeout: (String verificationId) {},
                  );
                },
                child: Text(
                  "Log in",
                  style: TextStyle(
                    backgroundColor: Colors.black,
                    color: Colors.white,
                  ),
                )),
          )),
            // Expanded(
            //     child: Align(
            //   alignment: Alignment.bottomCenter,
            //   child: ElevatedButton(
            //     onPressed: () async {
            //       await FirebaseAuth.instance.verifyPhoneNumber(
            //         phoneNumber: countrycode + phonenumber,
            //         verificationCompleted: (PhoneAuthCredential credential) {},
            //         verificationFailed: (FirebaseAuthException e) {},
            //         codeSent: (String verificationId, int? resendToken) {
            //           verify.verified = verificationId;
            //           Navigator.push(
            //             context,
            //             MaterialPageRoute(
            //               builder: (context) => otp(phone: phonenumber),
            //               // settings: RouteSettings(
            //               //   arguments: phonenumber
            //               // )
            //             ),
            //           );
            //         },
            //         codeAutoRetrievalTimeout: (String verificationId) {},
            //       );
            //     },
            //     child: Text("Next"),
            //   ),
            // ))
          ],
        ),
      ),
    );
  }
}
