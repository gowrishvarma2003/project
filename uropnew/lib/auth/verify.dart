import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:goeasy/screens/signup/otp.dart';
// import 'package:goeasy/screens/login.dart';
// import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import '../../main.dart';
import 'package:uropnew/auth/otp.dart';
class verify extends StatefulWidget{

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
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          iconSize: 32.0,
          color: Colors.grey,
          onPressed: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => MyApp()),
            // );
          },
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Text(
              "Enter Phone number for \n Verification",
            ),

            Text(
              "This number will be used for all rides related \n communication. You shall recive an SMS \n with code for verfication",
            ),

            TextField(
              keyboardType: TextInputType.number, // Set the keyboard type to number
              onChanged: (value){
                phonenumber = value;
                print(phonenumber);
              },
              decoration: InputDecoration(
                hintText: 'Your number',
              ),
            ),
            Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: ElevatedButton(
                    onPressed: ()async{
                      await FirebaseAuth.instance.verifyPhoneNumber(
                        phoneNumber: countrycode + phonenumber,
                        verificationCompleted: (PhoneAuthCredential credential) {},
                        verificationFailed: (FirebaseAuthException e) {},
                        codeSent: (String verificationId, int? resendToken) {
                          verify.verified = verificationId;
                          Navigator.push(context, MaterialPageRoute(builder: (context) => otp(phone : phonenumber),
                            // settings: RouteSettings(
                            //   arguments: phonenumber
                            // )
                          ),
                          );
                        },
                        codeAutoRetrievalTimeout: (String verificationId) {},
                      );
                    },
                    child: Text("Next"),
                  ),
                )
            )
          ],
        ),
      ),
    );
  }
}