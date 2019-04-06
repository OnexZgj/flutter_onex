import 'package:flutter/material.dart';

class HomePage extends StatefulWidget{

  @override
  _homePage createState() => _homePage();

}

class _homePage extends State<HomePage>{


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body:new Center(
        child: Text("Home"),
      )
    );
  }
}