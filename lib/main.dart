// @dart=2.9
import 'package:flutter/material.dart';
import 'package:graph_swipe/pages/HomePage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tinder cards demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomePage(),
    );
  }
}
