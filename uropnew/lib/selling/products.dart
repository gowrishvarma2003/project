import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';

class products extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _productsstate();
}

String? product_name;
String? quanteaty;

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
    margin: EdgeInsets.only(top: 15,left:5,right: 5),
    child: Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      child: TextFormField(
        onChanged: (name) {
          product_name = name;
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
            quanteaty= number;
          },
          keyboardType: TextInputType.number,
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

class _productsstate extends State<products> {
  Future<void> _addImage() async {
    final picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        imageList.add(File(image.path));
      });
    }
  }

  Widget build(BuildContext context) {

    void _register(){
      
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
        body: Column(
      children: [
        slider(),
        ElevatedButton(
            onPressed: _addImage,
            child: Text("add image",style: TextStyle(color: Colors.white),),
            style: ButtonStyle(backgroundColor:  MaterialStateProperty.all<Color>(Colors.black)),
          ),
        name(),
        quantety(),
        button()
      ],
    ));
  }
}