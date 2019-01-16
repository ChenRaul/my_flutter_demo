
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:core';

import 'package:my_flutter_demo/NewsData.dart';
import 'dart:convert';

class NewsPage extends StatefulWidget{
  //构造函数
  NewsPage({Key key, this.allUrl,this.index}) : super(key: key);
  final String allUrl;
  final int index;
  @override
  _NewsPageState createState() {
    // TODO: implement createState
    return _NewsPageState();
  }
}

class _NewsPageState extends State<NewsPage>{
  List<NewsList> dataList = new List();
  Color itemBackground = Colors.white;
  int itemCurrentClickIndex = -1;
  @override
  void initState() {
    // TODO: 这个函数在生命周期中只调用一次。

    super.initState();
    print('NewsPage initState'+widget.index.toString()+':'+widget.allUrl);
  }
  @override
  void didChangeDependencies() {
    // TODO:在initState()之后立刻调用
    super.didChangeDependencies();
  }
  @override
  void didUpdateWidget(NewsPage oldWidget) {
    // TODO: 组件的状态改变的时候就会调用didUpdateWidget,比如调用了setState.
//    //这个函数一般用于比较新、老Widget，看看哪些属性改变了，并对State做一些调整。
//    需要注意的是，涉及到controller的变更，需要在这个函数中移除老的controller的监听，并创建新controller的监听。
//    比如TabBar:
    super.didUpdateWidget(oldWidget);
  }

  @override
  void deactivate() {
    // TODO:组件开始移除 在dispose之前，会调用这个函数
    super.deactivate();
  }

  @override
  void dispose() {
    // TODO: 组件就要被销毁了，这个函数一般会移除监听，清理环境。
    super.dispose();
  }

  void _getData() async{
      Dio dio = new Dio();
      dio.interceptor.request.onSend = (Options options){
        // 在请求被发送之前做一些事情
        print('请求发送之前');
        return options; //continue
        // 如果你想完成请求并返回一些自定义数据，可以返回一个`Response`对象或返回`dio.resolve(data)`。
        // 这样请求将会被终止，上层then会被调用，then中返回的数据将是你的自定义数据data.
        //
        // 如果你想终止请求并触发一个错误,你可以返回一个`DioError`对象，或返回`dio.reject(errMsg)`，
        // 这样请求将被中止并触发异常，上层catchError会被调用。
      };
      dio.interceptor.response.onSuccess = (Response response) {
        // 在返回响应数据之前做一些预处理
        print('请求成功：');
        return response; // continue
      };
      dio.interceptor.response.onError = (DioError e){
        // 当请求失败时做一些预处理
        print('请求失败：'+e.message);
        return e;//continue
      };
      dio.options = new Options(connectTimeout:10000,receiveTimeout: 3000,);
      Response response = await dio.get('https://cnodejs.org/api/v1/topics?tab=all',data: {'page':1,'limit':10});
      if(response.statusCode == 200){
          //转换成Json数据
          NewsData newsData =  NewsData.fromJson(response.data);
          setState(() {
            //这样才能更新ListView的适配数据
            //下拉刷新需要清除所有数据获取最新的
            dataList.clear();
            //复制之前的数据，重新创建一个list集合
            dataList = new List.from(dataList);
            dataList.addAll(newsData.data);
          });
          print(newsData.data.length);
      }else{
          print('请求发生错误');
      }
  }
  //格式化日期。// yyyy-MM-dd HH:mm:ss
  String _getFormatDate(String date){
      DateTime d = DateTime.parse(date);
     //日期格式化
      return '${d.year}-${d.month.toString().padLeft(2,'0')}-${d.day.toString().padLeft(2,'0')} ${d.hour.toString().padLeft(2,'0')}:${d.minute.toString().padLeft(2,'0')}:${d.second.toString().padLeft(2,'0')}';

  }
  //显示SnackBar
  void _showSnackBar(String content){
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text('取消前往"$content"'),
      backgroundColor: Colors.blue,
      duration: Duration(seconds: 2),
      action: SnackBarAction(label: '好的', textColor:Colors.red,onPressed: (){
          _showDialog("SnackBar的action");
      }),
    ));
  }
  //显示对话框
  void _showDialog(String content){
      showDialog(
          context: context,
          builder: (BuildContext context){
              return AlertDialog(
                    title: Text('提示'),
                    content: Text('点击了"$content"'),
                    actions: <Widget>[
                        FlatButton(onPressed: (){
                            Navigator.of(context).pop();//消失对话框显示
                            _showSnackBar(content);
                        }, child: Text('取消')),
                        RaisedButton(onPressed: (){


                        },child: Text('确定'),textColor: Colors.white,),

                    ],
               );
          }
      );
  }
  Widget _getItemWidget(int index){
      return GestureDetector(
          child: Container(
            color: itemCurrentClickIndex == index ?Colors.white70 : Colors.white,
            margin: EdgeInsets.fromLTRB(4,4,4,4),
            child: Padding(
              padding: EdgeInsets.all(5),
              child: Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(right: 5),
                    child: Image.network(dataList[index].author.avatar_url.startsWith("http") ? dataList[index].author.avatar_url : 'http:${dataList[index].author.avatar_url}',
                        width: 90,height: 90
                    ),
                  ),
                  Expanded(
                    child:  Container(
                        height: 90,
                        child:Column(
                            //前面两个属性与flex布局一样
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,//主轴方向
                            crossAxisAlignment: CrossAxisAlignment.start,//交叉轴方向，与Row相反
                            children: <Widget>[
                                Text(dataList[index].title,maxLines:1,overflow: TextOverflow.ellipsis,
                                    style: TextStyle(color: Colors.black87,fontSize: 15,fontWeight: FontWeight.bold),
                                ),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                        Text(dataList[index].author.loginname,style: TextStyle(color: Color(0xff1296db),fontSize: 14),),
                                        Text(dataList[index].reply_count.toString()+'/'+dataList[index].visit_count.toString(),style: TextStyle(color: Color(0xff1296db),fontSize: 14),),
                                    ],
                                ),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                        Text(_getFormatDate(dataList[index].create_at),style: TextStyle(fontSize: 11),),
                                        Text(_getFormatDate(dataList[index].last_reply_at),style: TextStyle(fontSize: 11),),
                                    ],
                                ),
                            ],
                        )
                    ),
                  ),
                ],
              ),

            ),
          ),
        onTap: (){
            print('onTap');
            setState(() {
              itemCurrentClickIndex = -1;
            });
            _showDialog(dataList[index].title);
       },
        onTapDown: (details){
          print('onTapDown');
            //使用itemCurrentClickIndex
            setState(() {
                itemCurrentClickIndex = index;
            });
        },
        onTapUp: (details){
          print('onTapUp');
        },
      );
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
       color: Colors.black12,
       padding: EdgeInsets.all(0),
       margin: EdgeInsets.all(0),
       //ListView顶部有空白时，需要设置paddingTop为0
       child: RefreshIndicator(
           child:  ListView.builder(
               itemCount: dataList.length,
               padding: EdgeInsets.only(top: 0),
               itemBuilder: (BuildContext context, int index){
                  return _getItemWidget(index);
               }),
           onRefresh: (){
         //TODO onRefresh是返回一个Future对象，需要重点关注这个Future，可以像ES6一样使用then链式依次完成异步任务
//             Future(()=> print('RefreshIndicator: '+widget.index.toString()))
//                //value是前面的任务设置的值
//                 .then((value)=> print('RefreshIndicator: '+widget.allUrl))
//                 .timeout(Duration(seconds: 3));
           //延时1秒在获取数据
            return Future.delayed(Duration(seconds: 1),()=> _getData());
       }),
    );
  }

}

