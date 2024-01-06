import 'package:flutter/material.dart';
import 'package:untitled2/complexJsonApi.dart';
import 'package:untitled2/get_api_example_02.dart';
import 'package:untitled2/shorcutApi.dart';

import 'home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ExampleThree(),
    );
  }
}
