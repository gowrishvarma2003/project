import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uropnew/selling/seller.dart';
import '../main.dart' as mainfile;

class OrdersPage  extends StatefulWidget {
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
    } else {
      print('User data not available.');
      return; // Return if user data is not available
    }

    final response = await http
        .get(Uri.parse('http://' + mainfile.ip + '/server/seller_orders/$sellerId'));
    if (response.statusCode == 200) {
      setState(() {
        orders = json.decode(response.body);
      });
    } else {
      throw Exception('Failed to fetch orders');
    }
  }

  Widget homeProducts() {
    if (orders.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Orders for Seller ${sellerId ?? ""}'),
        ),
        body: Center(
          child: Text('No orders'),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            'Order requests',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
          elevation: 4,
        ),
        body: Container(
          margin: EdgeInsets.only(top: 30),
          child: ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          ProductDetailScreen(product: orders[index]),
                    ),
                  );
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
  }

  @override
  Widget build(BuildContext context) {
    return homeProducts();
  }
}

class ProductDetailScreen extends StatefulWidget {
  final Map<String, dynamic> product;
  ProductDetailScreen({required this.product});

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  List<dynamic> orders = [];

  @override
  void initState() {
    super.initState();
    getOrders();
  }

  Future<void> getOrders() async {
    var sellerId = widget.product['user'];
    final response = await http.get(
        Uri.parse('http://' + mainfile.ip + '/server/getaddress/$sellerId'));

    if (response.statusCode == 200) {
      setState(() {
        orders = json.decode(response.body);
      });
      print(orders);
    } else {
      throw Exception('Failed to fetch orders');
    }
  }

  @override
  Widget build(BuildContext context) {
    var product = widget.product;

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text('Product Details', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 4, // Adjust the elevation for the shadow effect
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: SizedBox(
                width: 300.0,
                height: 300.0,
                child: Image.network(
                  'http://' + mainfile.ip + '/server${product['image']}',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              product['productName'],
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            Text(
              'Price: \$${product['price'].toStringAsFixed(2)}',
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 10.0),
            Text(
              'Quantity: ${product['quantity']}',
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 10.0),
            Text(
              'Total: \$${(product['price'] * product['quantity']).toStringAsFixed(2)}',
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 20.0),
            Text(
              'Delivery Address:',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            if (orders.isNotEmpty)
              Container(
                width: MediaQuery.of(context)
                    .size
                    .width, // Set width to screen size
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(
                          0.3), // Reduce the opacity for a lighter shadow
                      spreadRadius: 2,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Card(
                  elevation: 0, // No additional elevation needed with BoxShadow
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${orders[0]['first_name'] ?? ''} ${orders[0]['last_name'] ?? ''}',
                          style: TextStyle(fontSize: 18.0),
                        ),
                        Text(
                          '${orders[0]['street'] ?? ''}, ${orders[0]['city'] ?? ''}',
                          style: TextStyle(fontSize: 18.0),
                        ),
                        Text(
                          '${orders[0]['district'] ?? ''}, ${orders[0]['state'] ?? ''}',
                          style: TextStyle(fontSize: 18.0),
                        ),
                        Text(
                          'Pincode: ${orders[0]['pincode'] ?? ''}',
                          style: TextStyle(fontSize: 18.0),
                        ),
                        Text(
                          'Phone: ${orders[0]['phone'] ?? ''}',
                          style: TextStyle(fontSize: 18.0),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            if (orders.isEmpty)
              Text(
                'No delivery address found.',
                style: TextStyle(fontSize: 18.0),
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                alignment: Alignment.center,
                child: TextButton(
                  onPressed: () {
                    // Add functionality for the button
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                  ),
                  child: Text('Accept Order'),
                ),
              )
          ],
        ),
      ),
    );
  }
}
