import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_onex/model/HomeArticle.dart';
import 'package:flutter_onex/pages/webview_page.dart';
import 'package:flutter_onex/widget/ProgressView.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_onex/manager/api_manager.dart';
import 'package:flutter_onex/model/HomeBanner.dart';

const APPBAR_SCROLL_MAX_OFFECT = 100;

class HomePage extends StatefulWidget {
  @override
  _homePage createState() => _homePage();
}

class _homePage extends State<HomePage> {
  // 首页banner列表
  List<HomeBannerItem> banners = List();

  // 首页文章列表
  List<Article> articles = List();

  double _appBarAlpha = 0;

  int _index = 0;

  ScrollController _loadmore = new ScrollController();

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
//    print(offect);
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    Widget listView = ListView.builder(
        controller: _loadmore,
        itemCount: articles.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return createBannerItem();
          } else {
            if (index - 1 < articles.length) {
              return createHomeArticleItem(articles[index - 1]);
            } else {
              return Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    "正在加载中...",
                    style: TextStyle(fontSize: 18.0, color: Colors.grey),
                  ));
            }
          }
        });

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
              child: articles.length == 0 ? new ProgressView() : listView,
            )),
        Opacity(
          opacity: _appBarAlpha,
          child: Container(
            height: 80,
            decoration: BoxDecoration(color: Colors.white),
            child: new Center(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: new TextField(
                  autofocus: false,
                  enabled: false,
                  decoration: new InputDecoration(
                    labelText: '搜索',
                    icon: Icon(Icons.search),
                    enabledBorder: OutlineInputBorder(
                      /*边角*/
                      borderRadius: BorderRadius.all(
                        Radius.circular(30), //边角为30
                      ),
                      borderSide: BorderSide(
                        color: Colors.lightBlue, //边线颜色为黄色
                        width: 2, //边线宽度为2
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    ));
  }

  @override
  void initState() {
    super.initState();

    _loadmore.addListener(() {
      var position = _loadmore.position;
      // 小于50px时，触发上拉加载；
      if (position.maxScrollExtent - position.pixels < 50) {
        this._index++;
        this._getHomeArticle(_index);
      }
    });

    _getBanner();

    _getHomeArticle(_index);
  }

  void _getBanner() async {
    /// 获取首页banner数据
    Response response = await ApiManager().getHomeBanner();
    var homeBannerBean = HomeBanner.fromJson(response.data);
    setState(() {
      banners.clear();
      banners.addAll(homeBannerBean.data);
    });
  }

  void _getHomeArticle(int index) async {
    Response response = await ApiManager().getHomeArticle(index);
    var homeArticle = HomeArticleBean.fromJson(response.data);
    setState(() {
      articles.addAll(homeArticle.data.datas);
    });
  }

  @override
  void dispose() {
    _loadmore.dispose();
    super.dispose();
  }

  Widget createHomeArticleItem(Article article) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (ctx) =>
                    WebViewPage(title: article.title, url: article.link)));
      },
      child: Card(
          margin: EdgeInsets.fromLTRB(2, 5, 2, 0),
          child: Container(
            padding: EdgeInsets.fromLTRB(18, 10, 18, 10),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.child_care,
                      color: Colors.blueAccent,
                      size: 18,
                    ),
                    Expanded(
                        flex: 1,
                        child: Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            article.author,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: Colors.blueAccent),
                          ),
                        ))
                  ],
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: Text(
                      article.title
                          .replaceAll("&rdquo;", "")
                          .replaceAll("&ldquo;", ""),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.black, fontSize: 16.0),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                ),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.access_time,
                      color: Colors.grey,
                      size: 15,
                    ),
                    Expanded(
                        flex: 1,
                        child: Padding(
                          padding: EdgeInsets.only(left: 8),
                          child: Text(
                            article.niceDate,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: Colors.grey),
                          ),
                        ))
                  ],
                )
              ],
            ),
          )),
    );
  }

  Widget createBannerItem() {
    return new Container(
      height: 180,
      child: Swiper(
        itemCount: banners.length,
        autoplay: true,
        pagination: new SwiperPagination(),
        viewportFraction: 0.8,
        scale: 0.9,
        itemBuilder: (BuildContext context, int index) {
          return new InkWell(
            onTap: () {
              Navigator.push(
                context,
                new MaterialPageRoute(
                  builder: (context) => new WebViewPage(
                      title: banners[index].title, url: banners[index].url),
                ),
              );
            },
            child: new Image.network(
              banners[index].imagePath,
              fit: BoxFit.fill,
            ),
          );
        },
      ),
    );
  }
}
