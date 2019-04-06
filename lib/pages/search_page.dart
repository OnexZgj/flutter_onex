import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget{

  @override
  _homePage createState() => _homePage();

}

class _homePage extends State<SearchPage>{

  
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body:new Center(
        child: Text("Search"),
      )
    );
  }
}