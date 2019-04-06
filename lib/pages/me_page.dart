import 'package:flutter/material.dart';

class MePage extends StatefulWidget{

  @override
  _homePage createState() => _homePage();

}

class _homePage extends State<MePage>{

  
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body:new Center(
        child: Text("me"),
      )
    );
  }
}