import 'package:flutter/material.dart';

class TravelPage extends StatefulWidget{

  @override
  _homePage createState() => _homePage();

}

class _homePage extends State<TravelPage>{


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body:new Center(
        child: Text("TravelPage"),
      )
    );
  }
}