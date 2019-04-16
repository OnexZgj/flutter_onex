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
import 'package:flutter_onex/widget/ProgressView.dart';

const APPBAR_SCROLL_MAX_OFFECT = 100;

class ProjectPage extends StatefulWidget {
  @override
  _projectPage createState() => _projectPage();
}

class _projectPage extends State<ProjectPage> with SingleTickerProviderStateMixin {
  List<ProjectItem> articles = List();

  final List<ProjectTabItem> myTabs = List();

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _getProjectTab();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("完整项目"),
        bottom: _buildBottomBar(),
      ),
      body: TabBarView(
        controller: _tabController,
        children: myTabs.map((ProjectTabItem item) {
          return new Padding(
            padding: const EdgeInsets.all(16.0),
            child: myTabs.length == 0
                ? new ProgressView()
                : new ProjectArticlePage(choiceId: item.id),
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

  void _getProjectTab() async {
    Response response = await ApiManager().getProjectClassify();
    var projectTab = ProjectTab.fromJson(response.data);
    setState(() {
      myTabs.addAll(projectTab.data);
    });
  }

  _buildBottomBar() {
    if (myTabs.length <= 0) {
      return Text('正在加载标签...');
    } else {
      if (_tabController == null) {
        _tabController = TabController(vsync: this, length: myTabs.length);
      }

      return TabBar(
        isScrollable: true,
        controller: _tabController,
        tabs: myTabs.map((ProjectTabItem choice) {
          return new Tab(
            text: choice.name,
            icon: new Icon(Icons.language),
          );
        }).toList(),
      );
    }
  }
}

class Tabx {
  const Tabx({this.title});

  final String title;
}
