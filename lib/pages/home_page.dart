import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

const APPBAR_SCROLL_MAX_OFFECT = 100;

class HomePage extends StatefulWidget {
  @override
  _homePage createState() => _homePage();
}

class _homePage extends State<HomePage> {
  List _imageUrl = [
    'https://icweiliimg6.pstatp.com/weili/l/57428162342159102.jpg',
    'https://weiliicimg9.pstatp.com/weili/l/363357239782146052.jpg',
    'https://icweiliimg1.pstatp.com/weili/l/57428205291836382.jpg',
  ];

  double _appBarAlpha = 0;

  _onScroll(offect) {
    _appBarAlpha = offect / APPBAR_SCROLL_MAX_OFFECT;
    if (_appBarAlpha < 0) {
      _appBarAlpha = 0;
    } else if (_appBarAlpha > 1) {
      _appBarAlpha = 1;
    }
    setState(() {
      _appBarAlpha = _appBarAlpha;
    });
    print(offect);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        //进行适配iPhoneX和刘海屏的操作，沉浸式状态栏
        body: Stack(
      children: <Widget>[
        MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: NotificationListener(
                //监听滚动，只有监听listview的滚动
                onNotification: (scrollNotification) {
                  if (scrollNotification is ScrollUpdateNotification &&
                      scrollNotification.depth == 0) {
                    _onScroll(scrollNotification.metrics.pixels);
                  }
                },
                child: new ListView(
                  children: <Widget>[
                    Container(
                      height: 180,
                      child: Swiper(
                        itemCount: _imageUrl.length,
                        autoplay: true,
                        pagination: new SwiperPagination(),
                        viewportFraction: 0.8,
                        scale: 0.9,
                        itemBuilder: (BuildContext context, int index) {
                          return new Image.network(
                            _imageUrl[index],
                            fit: BoxFit.fill,
                          );
                        },
                      ),
                    ),
                    Container(
                      height: 800,
                      child: ListTile(
                        title: Text("哈哈哈哈"),
                      ),
                    )
                  ],
                ))),
        Opacity(
          opacity: _appBarAlpha,
          child: Container(
            height: 80,
            decoration: BoxDecoration(color: Colors.white),
            child: new Center(
              child: Padding(
                padding: EdgeInsets.only(top: 20),
                child: Text("首页"),
              ),
            ),
          ),
        )
      ],
    ));
  }
}
