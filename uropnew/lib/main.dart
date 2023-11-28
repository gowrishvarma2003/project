import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:uropnew/auth/otp.dart';
import 'package:uropnew/auth/signup.dart';
import 'package:uropnew/auth/verify.dart';
import 'package:uropnew/home/all_products.dart';
import 'package:uropnew/home/home.dart';
import 'package:uropnew/home/orders.dart';
import 'package:uropnew/selling/products.dart';
import 'package:uropnew/selling/seller.dart';
import 'package:uropnew/selling/seller_orders.dart';

// define a global variable that can be used in all the files
String ip = '10.1.171.172:8000';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: OrdersPage(),
    );
  }
}
