import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pvsquare/constants/spaces.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var image;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Scan Image"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () async {
                var temp =
                    await ImagePicker().pickImage(source: ImageSource.camera);
                if (temp != null) {
                  setState(() {
                    image = File(temp.path);
                  });
                }
              },
              child: const Text('Click Here To Scan'),
            ),
            image == null
                ? const Text("Your Image will be shown here")
                : Image.file(
                    image,
                    width: space_46,
                    height: space_46,
                    fit: BoxFit.cover,
                  )
          ],
        ),
      ),
    );
  }
}
