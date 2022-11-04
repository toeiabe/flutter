import 'package:flutter/material.dart';
import 'package:flutter_test_imagegallery/gallery_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Scroll To Index Demo',
      theme: ThemeData(
          splashColor: Colors.transparent,
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: Color(0xFFFFFFFF)),
      home: GalleryScreen(),
    );
  }
}
