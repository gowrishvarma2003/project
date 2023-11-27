import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/widgets.dart';
import 'dart:convert';
import '../main.dart' as mainfile;
import 'package:firebase_auth/firebase_auth.dart';

class sell_products extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _productsstate();
}

String product_name = "";
String quanteaty = "";
String price = "";

// Future<void> _captureImage() async {
//   final picker = ImagePicker();
//   final XFile? image = await picker.pickImage(source: ImageSource.camera);

//   // if (image != null) {
//   //   // Do something with the captured image, like displaying it or saving it.
//   //   // 'image' is the File containing the captured image.
//   // }
// }

List<File> imageList = [];

// Future<void> _pickImageFromGallery() async {
//   final picker = ImagePicker();
//   final XFile? image = await picker.pickImage(source: ImageSource.gallery);

//   // if (image != null) {
//   //   // Do something with the selected image, like displaying it or saving it.
//   //   // 'image' is the File containing the selected image.
//   // }

Widget slider() {
  return Container(
    margin: EdgeInsets.only(top: 10),
    child: CarouselSlider(
      items: imageList.map((imageFile) {
        return Image.file(imageFile);
      }).toList(),
      options: CarouselOptions(
          // height: 200, // Adjust the height as needed
          // aspectRatio: 16 / 9, // Adjust the aspect ratio as needed
          // viewportFraction: 0.8,
          // autoPlay: true, // Set to true for auto-play
          // autoPlayInterval: Duration(seconds: 2), // Adjust the interval
          // autoPlayAnimationDuration: Duration(milliseconds: 800), // Animation duration
          // autoPlayCurve: Curves.fastOutSlowIn, // Animation curve
          ),
    ),
  );
}

Widget name() {
  return Container(
    margin: EdgeInsets.only(top: 15, left: 5, right: 5),
    child: Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      child: TextFormField(
        onChanged: (name) {
          product_name = name;
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter product name';
          }
          return null;
        },
        decoration: const InputDecoration(
          fillColor: Colors.black,
          border: OutlineInputBorder(),
          labelText: 'Product name',
          labelStyle: TextStyle(color: Colors.black),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
            color: Colors.black,
            width: 1.5,
          )),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
            color: Colors.black,
            width: 1.5,
          )),
          // errorText: validate && (phonenumber?.isEmpty ?? true)
          //   ? "This Field cannot be empty"
          //   :null      ),
        ),
      ),
    ),
  );
}

Widget quantety() {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 5),
    child: Container(
      // height: 100,
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      child: TextFormField(
        onChanged: (number) {
          quanteaty = number;
        },
        keyboardType: TextInputType.number,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter quantity';
          }
          return null;
        },
        decoration: InputDecoration(
          labelText: "quanteaty",
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
          // errorText: validate && (phonenumber?.isEmpty ?? true)
          //     ? "This Field cannot be empty"
          //     :null
        ),
      ),
    ),
  );
}

Widget price_container() {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 5),
    child: Container(
      // height: 100,
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      child: TextFormField(
        onChanged: (number) {
          price = number;
        },
        keyboardType: TextInputType.number,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter price';
          }
          return null;
        },
        decoration: InputDecoration(
          labelText: "Price",
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
          // errorText: validate && (phonenumber?.isEmpty ?? true)
          //     ? "This Field cannot be empty"
          //     :null
        ),
      ),
    ),
  );
}

class _productsstate extends State<sell_products> {
  Future<void> _addImage() async {
    final picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        imageList.add(File(image.path));
      });
    }
  }

  // Future<void> _uploadImages() async {
  //   final uri = Uri.parse('http://' + mainfile.ip + '/server/products/');
  //   final request = http.MultipartRequest('POST', uri);

  //   request.fields['name'] = 'apple';

  //   for (var image in imageList) {
  //     request.files
  //         .add(await http.MultipartFile.fromPath('image_paths', image.path));
  //   }

  //   final response = await request.send();

  //   if (response.statusCode == 201) {
  //     print('Images uploaded successfully');
  //   } else {
  //     print('Failed to upload images. Status code: ${response.statusCode}');
  //   }
  // }

// Future<void> uploadImages(List<File> imageList) async {
//   // var uri = Uri.parse('http://' + mainfile.ip + '/server/products/');

//   // var request = http.MultipartRequest('POST', uri);

//   var uri = Uri.parse('http://' + mainfile.ip + '/server/products/');

//   var request = http.MultipartRequest('POST', uri);
//   // request.headers['X-CSRFToken'] = 'your-csrf-token'; // Replace with your CSRF token

//   for (var image in imageList) {
//     request.files.add(await http.MultipartFile.fromPath('images', image.path));
//   }

//   var response = await request.send();
//   if (response.statusCode == 200) {
//     print('Images uploaded successfully');
//   } else {
//     print('Failed to upload images');
//   }
// }

// import 'package:http/http.dart' as http;

  Future<String> fetchCSRFToken() async {
    final response = await http.get(Uri.parse(
        'http://' + mainfile.ip + '/server/get-csrf-token/')); // Replace with your Django server URL

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final csrfToken = data['csrfToken'];
      return csrfToken;
    } else {
      throw Exception('Failed to fetch CSRF token');
    }
  }

  Future<void> uploadImages(List<File> images) async {

      var user = FirebaseAuth.instance.currentUser!.phoneNumber;
      if (user != null) {
        user = user.replaceFirst("+91", ""); // Modify user data as needed
        print(user);
      } else {
        print('User data not available.');
        return; // Return if user data is not available
      }

    final csrfToken = await fetchCSRFToken();
    print(csrfToken);

    for (File imageFile in images) {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('http://' + mainfile.ip + '/server/products/'),
      );
      request.headers['X-CSRFToken'] = csrfToken;
      request.fields['product_name'] = product_name;
      request.fields['quanteaty'] = quanteaty;
      request.fields['price'] = price;
      request.fields['seller'] = user;
      

      var file = await http.MultipartFile.fromPath('image', imageFile.path);
      request.files.add(file);

      var response = await request.send();
      if (response.statusCode == 201) {
        print('Image uploaded successfully');
      } else {
        print('Failed to upload image');
        print(response);
      }
    }
  }

  Widget button() {
    return Container(
        margin: EdgeInsets.only(left: 5, right: 5, top: 20),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: TextButton(
              style: TextButton.styleFrom(
                  // padding: EdgeInsets.symmetric(horizontal: 200),
                  backgroundColor: Colors.black),
              onPressed: () {
                uploadImages(imageList);
                // if (agree) {
                //   _register();
                //   // Navigator.push(context, MaterialPageRoute(builder: (context)=>getbike()));
                // }
              },
              child: Text(
                "Add product",
                style: TextStyle(
                  backgroundColor: Colors.black,
                  color: Colors.white,
                ),
              )),
        ));
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // elevation: 0.5,
          backgroundColor: Colors.white,
          title: Container(
            // padding: EdgeInsets.only(bottom: 20),
            // margin: EdgeInsets.only(top: 10),
            child: Text(
              "Add product",
              style: TextStyle(color: Colors.black),
            ),
          ),
          leading: Container(
            // padding: EdgeInsets.only(bottom: 20),
            // margin: EdgeInsets.only(top: 10),
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              iconSize: 25.0,
              color: Colors.black,
              onPressed: () {
                // Navigator.push(context, MaterialPageRoute(builder: (context) => Vachileowner()),);
              },
            ),
          )),
      body: SingleChildScrollView(
        child: Column(
          children: [
            slider(),
            ElevatedButton(
              onPressed: _addImage,
              child: Text(
                "add image",
                style: TextStyle(color: Colors.white),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
              ),
            ),
            name(),
            quantety(),
            price_container(),
            button(),
          ],
        ),
      ),
    );
  }
}
