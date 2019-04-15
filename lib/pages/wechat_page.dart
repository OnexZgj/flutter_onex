import 'package:flutter/material.dart';
import 'package:flutter_onex/pages/WechatArticleListView.dart';
import 'package:flutter_onex/pages/home_page.dart';
import 'package:flutter_onex/pages/welfare_page.dart';
import 'package:flutter_onex/widget/ProgressView.dart';

class WechatPageC extends StatefulWidget {
  @override
  _searchPage createState() => _searchPage();
}

class _searchPage extends State<WechatPageC>
    with SingleTickerProviderStateMixin {

  final List<Choice> myTabs = const <Choice>[
    const Choice(title: '鸿洋', icon: Icons.blur_on, id: 408),
    const Choice(title: '郭霖', icon: Icons.blur_on, id: 409),
    const Choice(title: '玉刚说', icon: Icons.blur_on, id: 410),
    const Choice(title: '承香墨影', icon: Icons.blur_on, id: 411),
    const Choice(title: 'Android群英传', icon: Icons.blur_on, id: 413),
    const Choice(title: 'code小生', icon: Icons.blur_on, id: 414),
    const Choice(title: '谷歌开发者', icon: Icons.blur_on, id: 415),
    const Choice(title: '奇卓社', icon: Icons.blur_on, id: 416),
    const Choice(title: '美团技术团队', icon: Icons.blur_on, id: 417),
    const Choice(title: '互联网侦察', icon: Icons.blur_on, id: 421),
    const Choice(title: 'Android达摩院', icon: Icons.blur_on, id: 434),
  ];

  TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("微信公众号"),
        bottom: TabBar(
          isScrollable:true,
          controller: _tabController,
          tabs: myTabs.map((Choice choice) {
            return new Tab(
              text: choice.title,
              icon: new Icon(choice.icon),
            );
          }).toList(),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
//        children: myTabs.map((Tab tab) {
//          return Center(child: Text(tab.text));
//        }).toList(),
//        children: <Widget>[
//          new WeChatArticlePage(),
//          new WeChatArticlePage(),
//        ],
        children: myTabs.map((Choice choice) {
          return new Padding(
            padding: const EdgeInsets.all(16.0),
            child: new WeChatArticlePage(choiceId : choice.id),
          );
        }).toList(),


      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: myTabs.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}

class Choice {
  const Choice({this.title, this.icon, this.id});

  final String title;
  final IconData icon;
  final int id;
}
