import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../main.dart' as mainfile;
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:convert';

class mycart extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _mycartState();
}

class Product {
  final int user;
  final int quantity;
  final int price;
  final String productName;
  final String image;

  Map<String, dynamic> toJson() {
    return {
      'user': user,
      'quantity': quantity,
      'price': price,
      'productName': productName,
      'image': image,
    };
  }

  Product(
      {required this.user,
      required this.quantity,
      required this.price,
      required this.productName,
      required this.image});
}

class _mycartState extends State<mycart> {
  List<Product> products = [];

  Future<void> sendorders(
      List<Product> products, Map<String, dynamic> userDetails) async {
    try {
      // Convert the list of products to a list of JSON objects
      List<Map<String, dynamic>> productsJson =
          products.map((product) => product.toJson()).toList();

      // Add user-specific details to the payload
      Map<String, dynamic> payload = {
        'userDetails': userDetails,
        'products': productsJson,
      };

      // Send the combined payload to the server
      final response = await http.post(
        Uri.parse('http://' + mainfile.ip + '/server/order/'),
        body: jsonEncode(payload),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        print('Products sent successfully');
      } else {
        throw Exception('Failed to send products');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> order() async {
    try {
      print("asdfg");
      List<Product> fetchedProducts = await fetchProductsFromServer();
      print(fetchedProducts[0].quantity);
      setState(() {
        products = fetchedProducts; // Update the products list
        // print(products[0]);
      });

      var user = FirebaseAuth.instance.currentUser!.phoneNumber;
      if (user != null) {
        user = user.replaceFirst("+91", ""); // Modify user data as needed
        print(user);
      } else {
        print('User data not available.');
        return; // Return if user data is not available
      }

      Map<String, dynamic> userDetails = {
        'user': user,
      };

      // Send the fetched products back to the server
      await sendorders(products, userDetails);
    } catch (e) {
      print("error");
      print(e);
    }
  }

  Future<List<Product>> fetchProductsFromServer() async {
    var user = FirebaseAuth.instance.currentUser!.phoneNumber;
    if (user != null) {
      user = user.replaceFirst("+91", ""); // Modify user data as needed
      // print(user);
    } else {
      print('User data not available.');
      // return; // Return if user data is not available
    }
    final response = await http
        .get(Uri.parse('http://' + mainfile.ip + '/server/cart_data/$user'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      // print(data);
      return data.map((item) {
        return Product(
            user: item['user'],
            quantity: item['quantity'],
            price: item['price'],
            productName: item['product_name'],
            image: item['image']);
      }).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  Future<void> fetchProducts() async {
    try {
      print("asdfg");
      List<Product> fetchedProducts = await fetchProductsFromServer();
      print(fetchedProducts[0].quantity);
      setState(() {
        products = fetchedProducts; // Update the products list
        // print(products[0]);
      });
      // print(products[0].productName);
    } catch (e) {
      print(e);
    }
  }

  void initState() {
    super.initState();
    // Call your function here when the screen is loaded
    fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    Widget button() {
      return Container(
          child: TextButton(
        onPressed: () {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => sell_products()),
          // );
          order();
          
        },
        child: Text('Add products'),
      ));
    }

    Widget home_products() {
      return Container(
        margin: EdgeInsets.only(top: 30),
        child: ListView.builder(
          itemCount: products.length,
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
                    'http://' + mainfile.ip + '/server${products[index].image}',
                    fit: BoxFit.cover,
                  ),
                ),
                title: Text(
                  products[index].productName,
                  style: TextStyle(fontSize: 20.0),
                ),
                subtitle: Text(
                  'Price: \$${products[index].price.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
            );
          },
        ),
      );
    }

    return Scaffold(
        body: Column(
      children: [
        Container(
          height: 620,
          child: home_products(),
        ),
        Expanded(child: button())
      ],
    ));
  }
}
