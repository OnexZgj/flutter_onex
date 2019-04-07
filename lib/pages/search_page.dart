import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget{

  @override
  _searchPage createState() => _searchPage();

}

class _searchPage extends State<SearchPage>{

  
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body:new Center(
        child: Text("Search"),
      )
    );
  }
}