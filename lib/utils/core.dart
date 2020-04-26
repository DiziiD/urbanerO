import 'package:flutter/material.dart';
import 'package:urbaner/utils/screen/main.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    //TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Urbaner',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
       // home: MyHomePage(title: 'Uber clone'),
    );
  }
}

//const Color black = Colors.black;
//const Color white = Colors.white;