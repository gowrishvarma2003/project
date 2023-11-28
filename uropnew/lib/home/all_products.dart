import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:uropnew/selling/products.dart';
import '../main.dart' as mainfile;
import 'package:firebase_auth/firebase_auth.dart';

class all extends StatefulWidget {
  State<StatefulWidget> createState() => _homestate();
}

class Product {
  final int id;
  final String image;
  final String productName;
  final int quantity;
  final int price;

  Product(
      {required this.id,
      required this.image,
      required this.productName,
      required this.quantity,
      required this.price});
}

class _homestate extends State<all> {
  List<Product> products = [];

  void initState() {
    super.initState();
    // Call your function here when the screen is loaded
    fetchProducts();
  }

  Future<List<Product>> fetchProductsFromServer() async {
    final response =
        await http.get(Uri.parse('http://' + mainfile.ip + '/server/send/'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data
          .map((item) {
            print(item['image']);
            return Product(
                id: item['id'],
                image: item['image'],
                productName: item['product_name'],
                quantity: item['quanteaty'],
                price: item['price']);
          })
          .where((product) =>
              product.quantity > 0) // Filter products with quantity > 0
          .toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  Future<void> fetchProducts() async {
    try {
      List<Product> fetchedProducts = await fetchProductsFromServer();
      setState(() {
        products = fetchedProducts; // Update the products list
      });
      // print(products[0].productName);
    } catch (e) {
      print(e);
    }
  }

// Assume Product is your data model for the products.

  Widget home_products() {
    return Container(
      margin: EdgeInsets.only(top: 30),
      child: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              // Navigate to a new screen to display product details
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) =>
                      ProductDetailScreen(product: products[index]),
                ),
              );
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(80), // Increase the height of the app bar
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.black, // Set the background color to black
          centerTitle: true,
          title: Container(
            margin: EdgeInsets.only(top: 20),
            height: 40, // Decrease the height of the search bar
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search...",
                border: InputBorder.none,
              ),
            ),
          ),
        ),
      ),
      body: home_products(),
    );
  }
}
// class Product {
//   final String image;
//   final String productName;
//   final double price;

//   Product({required this.image, required this.productName, required this.price});
// }

class ProductDetailScreen extends StatefulWidget {
  final Product product;

  ProductDetailScreen({required this.product});

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  late String quantity;

  @override
  void initState() {
    super.initState();
    quantity = "";
  }

  Widget quantityInput() {
    return Container(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: TextFormField(
          onChanged: (number) {
            setState(() {
              quantity = number;
            });
          },
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: "Quantity",
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
          ),
        ),
      ),
    );
  }

  Widget addToCartButton() {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, top: 20),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Colors.black,
            ),
            onPressed: () {
              addToCart();
            },
            child: Text(
              "Add to cart",
              style: TextStyle(
                backgroundColor: Colors.black,
                color: Colors.white,
              ),
            )),
      ),
    );
  }

  void addToCart() async {
    var user = FirebaseAuth.instance.currentUser!.phoneNumber;
    if (user != null) {
      user = user.replaceFirst("+91", ""); // Modify user data as needed
      print(user);
    } else {
      print('User data not available.');
      return; // Return if user data is not available
    }

    Map<String, dynamic> data = {
      'image': widget.product.image,
      'product_name': widget.product.productName,
      'quantity': quantity,
      'price': widget.product.price,
      'user': user, // Include user information in the data payload
    };

    String body = json.encode(data);

    var url = Uri.parse('http://' + mainfile.ip + '/server/cart/');
    var response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: body,
    );

    if (response.statusCode == 200) {
      print('Added to cart successfully!');
    } else {
      print('Failed to add to cart. Error: ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Product Details',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 20),
              width: 200.0,
              height: 200.0,
              child: Image.network(
                'http://' + mainfile.ip + '/server${widget.product.image}',
                fit: BoxFit.cover,
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(left: 20, top: 20),
              child: Text(
                widget.product.productName,
                style: TextStyle(fontSize: 24.0),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(left: 20, top: 10),
              child: Text(
                'Price: \$${widget.product.price.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 16.0,
                  color: const Color.fromARGB(255, 89, 89, 89),
                ),
              ),
            ),
            quantityInput(),
            addToCartButton(),
          ],
        ),
      ),
    );
  }
}
