// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:goeasy/screens/signup/signup.dart';
// import 'package:goeasy/screens/signup/verify.dart';
// import 'package:goeasy/screens/signup/start.dart';
import 'package:pinput/pinput.dart';
// import '../home.dart';
import 'package:uropnew/auth/verify.dart';
import 'package:uropnew/auth/signup.dart';

class otp extends StatefulWidget{
  String phone;
  otp({required this.phone});
  @override
  State<StatefulWidget> createState() => _otpstate();
}

class _otpstate extends State<otp>{

  final FirebaseAuth auth = FirebaseAuth.instance;

  var code = "";
// String phoennumber;
// _otpstate(phone, {required this.phoennumber});

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyle(fontSize: 20, color: Color.fromRGBO(30, 60, 87, 1), fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: Color.fromRGBO(234, 239, 243, 1),
      ),
    );
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          iconSize: 32.0,
          color: Colors.grey,
          onPressed: () {
            print(widget.phone);
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
            Pinput(
              length: 6,
              showCursor: true,
              onChanged: (value){
                code = value;
              },
            ),
            Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: ElevatedButton(
                    onPressed: ()async{
                      try {
                        PhoneAuthCredential credential = PhoneAuthProvider
                            .credential(
                            verificationId: verify.verified, smsCode: code);
                        await auth.signInWithCredential(credential);
                        var valid = auth.currentUser;
                        Navigator.push(context, MaterialPageRoute(builder: (context) => signup()));
                        String idToCheck = widget.phone;
                      }
                      catch(e){
                        validator: (s) {
                          return s == Icons.verified ? null : 'Pin is incorrect';
                        };
                      }
                    },
                    child: Text("Verify"),
                  ),
                )
            )
          ],
        ),
      ),
    );
  }
}