import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_onex/manager/api_manager.dart';

class TravelPage extends StatefulWidget {
  @override
  _travelPage createState() => _travelPage();
}

class _travelPage extends State<TravelPage> {
  @override
  void initState() {
    super.initState();

    _getArtilcle();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, index) {
          return _buildRow(index);
        });
  }

  Widget _buildRow(int) {
    return new ListTile(
      title: new Text(""),
    );
  }

  void _getArtilcle() async {
    Response response = await ApiManager().getWechatArticle(408, 1);
  }
}
