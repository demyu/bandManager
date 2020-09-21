import 'package:flutter/material.dart';
import 'homescreen.dart';
void main() {
  runApp(MyApp());
}


class MyApp extends StatefulWidget {
  
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: "BandManager",
      home: HomeScreen()
    );
  }
}
