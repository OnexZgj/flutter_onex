import 'package:flutter/material.dart';
import 'package:flutter_onex/widget/ProgressView.dart';

class SearchPage extends StatefulWidget{

  @override
  _searchPage createState() => _searchPage();

}

class _searchPage extends State<SearchPage>{

  
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body:new Center(
        child:new ProgressView(),
      )
    );
  }
}