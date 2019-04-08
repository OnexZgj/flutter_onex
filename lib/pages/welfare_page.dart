import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_onex/manager/gank_api_manager.dart';
import 'package:flutter_onex/model/WelfareBean.dart';
import 'package:flutter_onex/widget/ProgressView.dart';

/**
 * 福利页面
 * @author by OnexZgj
 */
class WelfarePage extends StatefulWidget {
  @override
  _welfarePage createState() => _welfarePage();
}

class _welfarePage extends State<WelfarePage> {
  List<Results> imgs = List();

  ScrollController _scrollController =new ScrollController();

  int _index = 1;

  Widget _getGridViewItemUI(Results result) {
    return new Image.network(
      result.url,
      fit: BoxFit.fill,
    );
  }



  Widget _buildGrid() {


      return new GridView.count(
        //      横轴数量 这里的横轴就是x轴 因为方向是垂直的时候 主轴是垂直的
        crossAxisCount: 2,
        controller: _scrollController,
        padding: const EdgeInsets.all(4.0),
        //主轴间隔
        mainAxisSpacing: 20.0,
        //横轴间隔
        crossAxisSpacing: 4.0,
        children: imgs.map((Results url) {
          return _getGridViewItemUI(url);
        }).toList(),
      );

  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Text("福利"),
      ),
      body: _bodyWeidget(),


    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }


  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      var position = _scrollController.position;
      // 小于50px时，触发上拉加载；
      if (position.maxScrollExtent - position.pixels < 50) {
        this._index++;
        this._getWelfare(_index);
      }
    });

    _getWelfare(_index);

  }

  void _getWelfare(int index) async {
    Response response = await GnakApiManager().getWelfare(index);
    var welfare = Welfare.fromJson(response.data);
    setState(() {
      imgs.addAll(welfare.results);
    });
  }

  Future<Null> _onRefresh() async {
    Response response = await GnakApiManager().getWelfare(_index);
    var welfare = Welfare.fromJson(response.data);
    setState(() {
      _index=1;
      imgs.clear();
      imgs.addAll(welfare.results);
    });
    return null;
  }


  Widget _bodyWeidget() {
//    return RefreshIndicator(child: _buildGrid(), onRefresh: _onRefresh);

    if(imgs.length!=0) {
      return RefreshIndicator(child: _buildGrid(), onRefresh: _onRefresh);
    }else{
      return ProgressView();
    }
  }


}

