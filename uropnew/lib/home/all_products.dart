import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:uropnew/selling/products.dart';

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
      required this.price
      });
}

class _homestate extends State<all> {

  List<Product> products = [];

  void initState() {
    super.initState();
    // Call your function here when the screen is loaded
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    try {
      List<Product> fetchedProducts = await fetchProductsFromServer();
      setState(() {
        products = fetchedProducts; // Update the products list
      });
    } catch (e) {
      // Handle errors
    }
  }

  Future<List<Product>> fetchProductsFromServer() async {
    final response =
        await http.get(Uri.parse('http://10.1.173.125:8000/server/send/'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((item) {
        return Product(
            id: item['id'],
            image: item['image'],
            productName: item['product_name'],
            quantity: item['quanteaty'],
            price: item['price']);
      }).where((product) => product.quantity > 0) // Filter products with quantity > 0
        .toList();
    } else {
      throw Exception('Failed to load products');
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
                builder: (context) => ProductDetailScreen(product: products[index]),
              ),
            );
          },
          child: ListTile(
            leading: SizedBox(
              width: 100.0,
              height: 100.0,
              child: Image.network(
                'http://10.1.173.125:8000/server${products[index].image}',
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
          preferredSize: Size.fromHeight(80), // Increase the height of the app bar
          child: AppBar(

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




class ProductDetailScreen extends StatelessWidget {
  final Product product;

  ProductDetailScreen({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Details'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 200.0,
              height: 200.0,
              child: Image.network(
                'http://10.1.173.125:8000/server${product.image}',
                fit: BoxFit.cover,
              ),
            ),
            Text(
              product.productName,
              style: TextStyle(fontSize: 24.0),
            ),
            Text(
              'Price: \$${product.price.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 18.0),
            ),
            // You can display more details about the product here.
          ],
        ),
      ),
    );
  }
}