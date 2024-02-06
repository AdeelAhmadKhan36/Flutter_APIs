import 'package:flutter/material.dart';
import 'package:untitled2/PostAPi/Register.dart';
import 'package:untitled2/PostAPi/uploadimage.dart';
import 'package:untitled2/verycomplexJson.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: UploadImage(),
    );
  }
}
