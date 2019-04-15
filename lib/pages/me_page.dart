//import 'package:flutter/material.dart';
//import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
//
//class  extends StatefulWidget {
//  @override
//  _mePage createState() => _mePage();
//}
//
//class  extends State<MePage> {
//  @override
//  Widget build(BuildContext context) {
//    return new WebviewScaffold(
//      url: "http://www.baidu.com",
//
//      appBar: new AppBar(
//        title: Text(
//          "百度",
//          style: TextStyle(color: Colors.white),
//        ),
//      ),
//    );
//  }
//}

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_onex/manager/api_manager.dart';
import 'package:flutter_onex/model/ProjectItem.dart';
import 'package:flutter_onex/model/ProjectTab.dart';
import 'package:flutter_onex/pages/ProjectArticleListView.dart';


const APPBAR_SCROLL_MAX_OFFECT = 100;

class MePage extends StatefulWidget {
  @override
  _mePage createState() => _mePage();
}

class _mePage extends State<MePage> {
  List<ProjectItem> articles = List();

  List<ProjectTabItem> myTabs = List();



  TabController _tabController;

  int _index = 1;

  ScrollController _loadmore = new ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getProjectTab();

  }


  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {

      return Scaffold(
      appBar: AppBar(
        title: Text("微信公众号"),
        bottom: TabBar(
          isScrollable:true,
          controller: _tabController,
          tabs: myTabs.map((ProjectTabItem item) {
            return new Tab(
              text: item.name,
              icon: new Icon(Icons.ac_unit),
            );
          }).toList(),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: myTabs.map((ProjectTabItem item) {
          return new Padding(
            padding: const EdgeInsets.all(16.0),
            child: new ProjectArticlePage(choiceId : item.id),
          );
        }).toList(),
      ),
    );



//    return new Scaffold(
//        //进行适配iPhoneX和刘海屏的操作，沉浸式状态栏
//        appBar: new AppBar(
//          title: Text(
//            "项目",
//            style: TextStyle(color: Colors.white),
//          ),
//          backgroundColor: Colors.lightBlue,
//        ),
//        body: Stack(
//          children: <Widget>[
//            MediaQuery.removePadding(
//              context: context,
//              removeTop: true,
//              child: articles.length == 0 ? new ProgressView() : listView,
//            ),
//          ],
//        ));
  }

  void _getProjectTab() async{

    Response response = await ApiManager().getHomeBanner();
    var projectTab = ProjectTab.fromJson(response.data);
    setState(() {
      myTabs.clear();
      myTabs.addAll(projectTab.data);
    });

  }




}
