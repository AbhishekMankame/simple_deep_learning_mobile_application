import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart';
import 'package:hello_mnist/dl_model/classifier.dart';
import 'package:hello_mnist/utils/constants.dart';
import 'dart:io';

class UploadImage extends StatefulWidget {
  //const UploadImage({super.key});
  @override
  _UploadImageState createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  final picker = ImagePicker();
  Classifier classifier = Classifier();
  PickedFile image; //PickedFile image; --> old API
  int digit = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        child: Icon(Icons.camera_alt_outlined),
        onPressed: () async {
          image = await picker.getImage(source: ImageSource.gallery);
          digit = await classifier.classifyImage(image);
          setState(() {});
        },
      ),
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: Text(
          "Best digit recognizer in the world",
          style: TextStyle(fontSize: 20),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 40,
            ),
            Text("Image will be shown below"),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 300,
              width: 300,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.black, width: 2.0),
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: digit == -1
                      ? AssetImage('assets/white_background.jpg')
                      : FileImage(File(image.path)),
                ),
              ),
            ),
            SizedBox(
              height: 45,
            ),
            Text("Current Prediction:",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
            SizedBox(
              height: 20,
            ),
            Text(digit == -1 ? "" : "$digit",
                style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
