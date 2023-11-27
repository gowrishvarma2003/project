import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import '../main.dart' as mainfile;

class OrdersPage extends StatefulWidget {
  @override
  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  List<dynamic> orders = [];
  var sellerId;

  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  Future<void> fetchOrders() async {
    sellerId = FirebaseAuth.instance.currentUser!.phoneNumber;
    if (sellerId != null) {
      sellerId = sellerId.replaceFirst("+91", ""); // Modify user data as needed
      print(sellerId);
    } else {
      print('User data not available.');
      return; // Return if user data is not available
    }

    final response = await http.get(
        Uri.parse('http://' + mainfile.ip + '/server/seller_orders/$sellerId'));
    print(response.body);
    if (response.statusCode == 200) {
      setState(() {
        orders = json.decode(response.body);
      });
      print('http://' + mainfile.ip + '/server${orders[0]['image']}');
      print(orders[0]);
    } else {
      throw Exception('Failed to fetch orders');
    }
  }

  Widget homeProducts() {
    return Scaffold(
      appBar: AppBar(
        title: Text('Orders for Seller ${sellerId ?? ""}'),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 30),
        child: ListView.builder(
          itemCount: orders.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                // Navigate to a new screen to display product details
                // Navigator.of(context).push(
                //   MaterialPageRoute(
                //     builder: (context) =>
                //         ProductDetailScreen(product: products[index]),
                //   ),
                // );
              },
              child: ListTile(
                leading: SizedBox(
                  width: 100.0,
                  height: 100.0,
                  child: Image.network(
                    'http://' +
                        mainfile.ip +
                        '/server${orders[index]['image']}',
                    fit: BoxFit.cover,
                  ),
                ),
                title: Text(
                  orders[index]['productName'],
                  style: TextStyle(fontSize: 20.0),
                ),
                subtitle: Text(
                  'Price: \$${orders[index]['price'].toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return homeProducts();
  }
}
