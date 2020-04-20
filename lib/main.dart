import 'package:flutter/material.dart';
import 'Global.dart';

import 'MyHomePage.dart';

void main() => runApp(Myapp());

class Myapp extends StatefulWidget {
  @override
  _MyappState createState() => _MyappState();
}

class _MyappState extends State<Myapp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Doto",
      theme: ThemeData(
        primaryColor: Colors.blueGrey,
        primarySwatch: Colors.blueGrey,
        textTheme: TextTheme(
          title: titleTheme,
        ),
      ),
      home: MyHomepage(),
    );
  }
}
