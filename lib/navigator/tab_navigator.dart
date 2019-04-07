import 'package:flutter/material.dart';
import 'package:flutter_onex/pages/home_page.dart';
import 'package:flutter_onex/pages/me_page.dart';
import 'package:flutter_onex/pages/search_page.dart';
import 'package:flutter_onex/pages/travel_page.dart';
import 'package:flutter_onex/pages/welfare_page.dart';

class TabNavigator extends StatefulWidget {
  @override
  _tabNavigator createState() => _tabNavigator();
}

class _tabNavigator extends State<TabNavigator> {
  final PageController _pageController = new PageController(initialPage: 0);

  final default_color = Colors.grey;
  final select_color = Colors.lightBlue;

  int _current_index = 1;

  @override
  Widget build(BuildContext context) {


    _pageChange(int index) {
      if(_current_index!=index){
        setState(() {
          _current_index=index;

        });
      }
    }

    return new Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: _pageChange,
        children: <Widget>[
          HomePage(),
          SearchPage(),
          TravelPage(),
          MePage(),
          WelfarePage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _current_index,
          type: BottomNavigationBarType.fixed, //将底部的文字都固定显示出来
          onTap: (index) {
            _pageController.jumpToPage(index);
            setState(() {
              _current_index = index;
            });
          },
          items: [
            new BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  color: default_color,
                ),
                activeIcon: Icon(
                  Icons.home,
                  color: select_color,
                ),
                title: Text(
                  "首页",
                  style: TextStyle(
                    color: _current_index != 0 ? default_color : select_color,
                  ),
                )),
            new BottomNavigationBarItem(
                icon: Icon(
                  Icons.camera,
                  color: default_color,
                ),
                activeIcon: Icon(
                  Icons.camera,
                  color: select_color,
                ),
                title: Text(
                  "旅行",
                  style: TextStyle(
                    color: _current_index != 1 ? default_color : select_color,
                  ),
                )),
            new BottomNavigationBarItem(
                icon: Icon(
                  Icons.search,
                  color: default_color,
                ),
                activeIcon: Icon(
                  Icons.search,
                  color: select_color,
                ),
                title: Text(
                  "搜索",
                  style: TextStyle(
                    color: _current_index != 2 ? default_color : select_color,
                  ),
                )),
            new BottomNavigationBarItem(
                icon: Icon(
                  Icons.account_circle,
                  color: default_color,
                ),
                activeIcon: Icon(
                  Icons.account_circle,
                  color: select_color,
                ),
                title: Text(
                  "我",
                  style: TextStyle(
                    color: _current_index != 3 ? default_color : select_color,
                  ),
                )),


            new BottomNavigationBarItem(
                icon: Icon(
                  Icons.audiotrack,
                  color: default_color,
                ),
                activeIcon: Icon(
                  Icons.audiotrack,
                  color: select_color,
                ),
                title: Text(
                  "福利",
                  style: TextStyle(
                    color: _current_index != 4 ? default_color : select_color,
                  ),
                )),
          ]),
    );
  }


}
