

import 'package:flutter/material.dart';
import 'package:my_flutter_demo/LoadDialog.dart';

class NewsDetail extends StatefulWidget{
  NewsDetail({Key key, this.title,this.newsId}) : super(key: key);
  final String title;
  final String newsId;
  @override
  _NewsDetailState createState() {
    // TODO: implement createState
    return _NewsDetailState();
  }

}
class _NewsDetailState extends State<NewsDetail>{
  bool _isLoadSuccess = false;
  WidgetsBinding widgetsBinding;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((callback){
       _showLoadDialog();
    });
  }

  _showLoadDialog(){
      print('显示对话框');
      showDialog(context: context,builder: (BuildContext context){
          return LoadDialog();
      });
  }
  @override
  void dispose() {
    // TODO: 组件就要被销毁了，这个函数一般会移除监听，清理环境。
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return WillPopScope(
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(icon: Image.asset('img/back.png',width: 30,height: 30,), onPressed: (){
              //返回，并返回参数给上一页面
              Navigator.pop(context,'点击返回按钮返回${widget.newsId}');
            }),
            title: Text(widget.title),
            centerTitle: true,
          ),
          body: _isLoadSuccess ? Text(''):new Center(child:new Text('${widget.title} : ${widget.newsId}')),
        ),
        onWillPop: (){
            Navigator.pop(context,'点击android返回键返回${widget.newsId}');
        },
    );
  }

}