import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_flutter_demo/AppColors.dart';
import 'package:my_flutter_demo/CustomNoticeDialog.dart';
import 'package:my_flutter_demo/DateTimeFormat.dart';
import 'package:my_flutter_demo/DioUtil.dart';
import 'dart:core';

import 'package:my_flutter_demo/NewsData.dart';

import 'package:my_flutter_demo/NewsDetail.dart';

class NewsPage extends StatefulWidget {
  //构造函数
  NewsPage({Key key, this.url, this.index}) : super(key: key);
  final String url;
  final int index;
  @override
  _NewsPageState createState() {
    // TODO: implement createState
    return _NewsPageState();
  }
}

///AutomaticKeepAliveClientMixin 能够保持页面不重新运行initState，保持原来的状态
class _NewsPageState extends State<NewsPage>
    with AutomaticKeepAliveClientMixin {
  ///定义一个RefreshIndicatorState的全局key，以便来获取它的实例来调用一些方法，比如说通过RefreshIndicatorState来主动显示下拉刷新的UI效果
  ///由于GlobalKey的泛型T类型只能是继承State的类，所以不能使用GlobalKey<RefreshIndicator>而是GlobalKey<RefreshIndicatorState>
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();
  ScrollController listController = new ScrollController();

  List<NewsList> dataList = new List();
  Color itemBackground = Colors.white;
  int itemCurrentClickIndex = -1;
  int page = 1;
  int limit = 10;
  bool isLoadMore = false;
  Dio dio;
  @override
  void initState() {
    // TODO: 这个函数在生命周期中只调用一次。

    super.initState();
    _initDio();
    listController.addListener(() {
      if (listController.position.pixels ==
          listController.position.maxScrollExtent) {
        ///isLoadMore为true表明还在上拉加载获取更多的数据过程中，避免重复加载
        if (!isLoadMore) {
          setState(() {
            isLoadMore = true;
            page += 1;
            _getData();
          });
        }
      }
    });
    WidgetsBinding.instance.addPostFrameCallback((callback) {
      //主动调用下拉刷新 onRefresh以便获取数据
      _refreshIndicatorKey.currentState.show(atTop: true);
    });
  }

  _initDio() {
    dio = new Dio();
    dio.interceptor.request.onSend = (Options options) {
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
    dio.interceptor.response.onError = (DioError e) {
      // 当请求失败时做一些预处理
      print('请求失败：' + e.message);
      return e; //continue
    };
    dio.options = new Options(
      connectTimeout: 10000,
      receiveTimeout: 3000,
    );
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

  void _getData() async {
    await Future(
        () => DioUtil().dioGet('${widget.url}&page=$page&limit=$limit', (data) {
              NewsData newsData = NewsData.fromJson(data);
              setState(() {
                //这样才能更新ListView的适配数据
                //下拉刷新需要清除所有数据获取最新的
                if (isLoadMore) {
                  dataList = new List.from(dataList);
                  dataList.removeAt(dataList.length - 1);
                  dataList.addAll(newsData.data);
                  dataList.add(null); //添加一个空数据，用来当做footer
                  isLoadMore = false;
                } else {
                  dataList.clear();
                  //复制之前的数据，重新创建一个list集合
                  dataList = new List.from(dataList);
                  dataList.addAll(newsData.data);
                  dataList.add(null); //添加一个空数据，用来当做footer
                }
                print(dataList.length);
              });
            }, () {
              setState(() {
                isLoadMore = false;
              });
              _showNoticeDialog('请求数据错误,请稍后重试');
            }));
  }

  ///显示自定义的dialog，全部重写,posPress在{}内，所以是可选参数
  void _showNoticeDialog(String loadText, {Function posPress}) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomNoticeDialog(
            noticeText: loadText,
            noticeTitle: '提示',
            isShowOneBtn: true,
            clickOutCancel: true,
            posBtnText: '确定',
            negBtnText: '取消',
            posPress: () {
              posPress();
            },
          );
        });
  }

  //显示SnackBar
  void _showSnackBar(String content) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text('取消前往"$content"'),
      backgroundColor: Colors.blue,
      duration: Duration(seconds: 2),
      action: SnackBarAction(
          label: '好的',
          textColor: Colors.red,
          onPressed: () {
            _showDialog("点击SnackBar的action");
          }),
    ));
  }

  //显示对话框,newsId可要可不要，某些地方需要，某些地方不需要
  void _showDialog(String content, {String newsId, int ss}) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('提示'),
            content: Text('消息："$content"'),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop(); //消失对话框显示
                    _showSnackBar(content);
                  },
                  child: Text('取消')),
              RaisedButton(
                onPressed: () {
                  Navigator.of(context).pop(); //消失对话框显示
                  //TODO 使用构建路由而不是命名路由跳转到详情页面,页面返回时会返回一个string参数
//                            Navigator.pushNamed<String>(context, '/newsDetail')
//                                //TODO 在then里面接收页面返回的参数，pushNamed返回的是Future对象
//                                .then((pageRetParam){
//                                  //TODO pageRetParam返回的参数类型是由pushNamed<T>的泛型T决定
//                                  _showDialog(pageRetParam);
//                            });
                  //构建路由
                  Navigator.push<String>(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                    return new NewsDetail(
                      title: '详情',
                      newsId: newsId,
                    );
                  })).then((ret) {
                    //返回时的回调
                    _showDialog(ret);
                  });
                },
                child: Text('确定'),
                textColor: Colors.white,
              ),
            ],
          );
        });
  }

  Widget _getItemWidget(int index) {
    if (dataList[index] == null) {
      return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ///该组件能够强迫子组件有一个固定的高度，一般在子组件无法设置宽高的时候相结合
            SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 1,
              ),
            ),
            Text(
              ' 加载更多...',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            )
          ],
        ),
      );
    } else {
      return GestureDetector(
        child: Container(
          color: itemCurrentClickIndex == index ? Colors.white70 : Colors.white,
          margin: EdgeInsets.fromLTRB(4, 4, 4, 4),
          child: Padding(
            padding: EdgeInsets.all(5),
            child: Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(right: 5),
                  child: Image.network(
                      dataList[index].author.avatarUrl.startsWith("http")
                          ? dataList[index].author.avatarUrl
                          : 'http:${dataList[index].author.avatarUrl}',
                      width: ScreenUtil().setWidth(240),
                      height: ScreenUtil().setWidth(240)),
                ),
                Expanded(
                  child: Container(
                      height: ScreenUtil().setWidth(240),
                      child: Column(
                        //前面两个属性与flex布局一样
                        mainAxisAlignment:
                            MainAxisAlignment.spaceBetween, //主轴方向
                        crossAxisAlignment:
                            CrossAxisAlignment.start, //交叉轴方向，与Row相反
                        children: <Widget>[
                          Text(
                            dataList[index].title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                dataList[index].author.loginname,
                                style: TextStyle(
                                    color: Color(0xff1296db), fontSize: 14),
                              ),
                              Text(
                                dataList[index].reply_count.toString() +
                                    '/' +
                                    dataList[index].visit_count.toString(),
                                style: TextStyle(
                                    color: Color(0xff1296db), fontSize: 14),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                DateTimeFormat.getFormatDate(
                                    dataList[index].create_at),
                                style: TextStyle(fontSize: 11),
                              ),
                              Text(
                                DateTimeFormat.getFormatDate(
                                    dataList[index].last_reply_at),
                                style: TextStyle(fontSize: 11),
                              ),
                            ],
                          ),
                        ],
                      )),
                ),
              ],
            ),
          ),
        ),
        onTap: () {
          print('onTap');

          _showDialog(dataList[index].title, newsId: dataList[index].id);
        },
        onTapDown: (details) {
          print('onTapDown');
          //使用itemCurrentClickIndex
          setState(() {
            itemCurrentClickIndex = index;
          });
        },
        onTapCancel: () {
          print('onTapCancel');
          setState(() {
            itemCurrentClickIndex = -1;
          });
        },
        onTapUp: (details) {
          print('onTapUp');
          setState(() {
            itemCurrentClickIndex = -1;
          });
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    super.build(context);

    return Container(
      color: Colors.black12,
      padding: EdgeInsets.all(0),
      margin: EdgeInsets.all(0),
      //ListView顶部有空白时，需要设置paddingTop为0
      child: RefreshIndicator(
          key: _refreshIndicatorKey, //全局变量，可以在其他地方引用改组件实例
          child: ListView.builder(
              controller: listController,
              itemCount: dataList.length,
              padding: EdgeInsets.only(top: 0),
              itemBuilder: (BuildContext context, int index) {
                return _getItemWidget(index);
              }),
          onRefresh: () {
            //TODO onRefresh是返回一个Future对象，需要重点关注这个Future，可以像ES6一样使用then链式依次完成异步任务
//             Future(()=> print('RefreshIndicator: '+widget.index.toString()))
//                //value是前面的任务设置的值
//                 .then((value)=> print('RefreshIndicator: '+widget.allUrl))
//                 .timeout(Duration(seconds: 3));
            //延时0秒在获取数据
//             Future(()=>  _getData());
            return Future.delayed(Duration(seconds: 0), () => _getData());
          }),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
