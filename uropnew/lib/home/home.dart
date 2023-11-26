import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:uropnew/home/all_products.dart';
import 'package:uropnew/selling/products.dart';
import 'package:uropnew/home/mycart.dart';

class home extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _homeState();
}

class _homeState extends State<home>{

  int _currentIndex = 0;
  final List<Widget> _pages = [
    all(),
    mycart(),
    sell_products(), 
  ];

  Widget build(BuildContext context){
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home' ),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart),label: 'cart'),
          BottomNavigationBarItem(icon: Icon(Icons.add),label: 'addproducts'),
        ],
        selectedItemColor: Colors.black,
      ) ,
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Home Page'),
    );
  }
}

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('About Page'),
    );
  }
}

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Settings Page'),
    );
  }
}






