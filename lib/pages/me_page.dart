import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class MePage extends StatefulWidget {
  @override
  _mePage createState() => _mePage();
}

class _mePage extends State<MePage> {
  @override
  Widget build(BuildContext context) {
    return new WebviewScaffold(
      url: "http://www.baidu.com",
      
      appBar: new AppBar(
        title: Text(
          "百度",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
