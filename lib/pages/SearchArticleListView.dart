import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_onex/model/HomeArticle.dart';
import 'package:flutter_onex/model/WechartItem.dart';
import 'package:flutter_onex/pages/webview_page.dart';
import 'package:flutter_onex/widget/ProgressView.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_onex/manager/api_manager.dart';
import 'package:flutter_onex/model/HomeBanner.dart';


class SearchArticlePage extends StatefulWidget {
  String searchKey;

  SearchArticlePage({Key key, this.searchKey}) : super(key: key);

  @override
  _searchPage createState() => _searchPage();
}

class _searchPage extends State<SearchArticlePage> {
  List<Article> articles = List();

  int _index = 0;

  ScrollController _loadmore = new ScrollController();

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    Widget listView = ListView.builder(
        controller: _loadmore,
        itemCount: articles.length,
        itemBuilder: (context, index) {
          return createHomeArticleItem(articles[index]);
        });

    return new Scaffold(
        body: Stack(children: <Widget>[
      articles.length == 0 ? new ProgressView() : listView,
    ]));
  }

  @override
  void initState() {
    super.initState();

    _loadmore.addListener(() {
      var position = _loadmore.position;
      // 小于50px时，触发上拉加载；
      if (position.maxScrollExtent - position.pixels < 50) {
        this._index++;
        this._getWechatArticle(_index,widget.searchKey);
      }
    });

    if (widget.searchKey != '') {
      _getWechatArticle(_index,widget.searchKey);
    }
  }

  void _getWechatArticle(int index,String key) async {
    Response response =
        await ApiManager().searchArticle(index,key);
    var article = HomeArticleBean.fromJson(response.data);
    setState(() {
      articles.addAll(article.data.datas);
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
}
