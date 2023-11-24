import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:uropnew/auth/verify.dart';
import 'package:uropnew/auth/signup.dart';

class otp extends StatefulWidget {
  final String phone;

  otp({required this.phone});

  @override
  State<StatefulWidget> createState() => _OTPState();
}

class _OTPState extends State<otp> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  var code = "";

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyle(
        fontSize: 20,
        color: Color(0xFF1E3C57),
        fontWeight: FontWeight.w600,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFFEAEFF3)),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: Color(0xFF72B2EE)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: Color(0xFFEAEFF3),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white, // Set the background color to white
        title: Text(
          'Enter otp',
          style: TextStyle(color: Colors.black), // Set text color to black
        ),
        iconTheme:
            IconThemeData(color: Colors.black), // Set icon color to black
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 40,left: 10,right: 10),
              child: Text(
              "Enter the otp sent to your phonenumber",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            ),
            // Container(
            //   margin: EdgeInsets.only(bottom: 50,top: 10),
            //   child: Text(
            //   "This number will be used for all rides related \n communication. You shall recive an SMS \n with code for verfication",
            //   style: TextStyle(
            //     fontSize: 16,
            //   ),
            // ),
            // ),
            SizedBox(height: 32),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Pinput(
              length: 6,
              showCursor: true,
              onChanged: (value) {
                setState(() {
                  code = value;
                });
              },
            ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(
                  onPressed: () async {
                    try {
                      PhoneAuthCredential credential = PhoneAuthProvider.credential(
                        verificationId: verify.verified,
                        smsCode: code,
                      );
                      await auth.signInWithCredential(credential);
                      var valid = auth.currentUser;
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => signup(),
                        ),
                      );
                    } catch (e) {
                      // Handle validation errors
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black,
                  ),
                  child: Text(
                    "Verify",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
