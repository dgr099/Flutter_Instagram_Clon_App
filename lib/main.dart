import 'package:flutter/material.dart';
import 'package:instagram/responsive/responsive_layout_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Instagram',
      theme: ThemeData.dark(
          //primarySwatch: Colors.blue,
          ),
      home: const ResponsiveLayout(webScreenLayout: webScreenLayout, mobileScreenLayout: mobileScreenLayout),
    );
  }
}
