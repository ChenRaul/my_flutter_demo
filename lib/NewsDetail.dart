

import 'package:flutter/material.dart';
import 'package:my_flutter_demo/AppColors.dart';
import 'package:my_flutter_demo/CommentPage.dart';
import 'package:my_flutter_demo/CustomNoticeDialog.dart';
import 'package:my_flutter_demo/DateTimeFormat.dart';
import 'package:my_flutter_demo/DioUtil.dart';
import 'package:my_flutter_demo/LoadDialog.dart';
import 'package:my_flutter_demo/NewsDetailResponse.dart';
import 'package:flutter_inappbrowser/flutter_inappbrowser.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
  NewsDetailResponse newDetailData;
  WidgetsBinding widgetsBinding;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("https://cnodejs.org/api/v1/topic/${widget.newsId}");
    WidgetsBinding.instance.addPostFrameCallback((callback){
       _showLoadDialog();
       new DioUtil().dioGet("https://cnodejs.org/api/v1/topic/${widget.newsId}",
         (responseData){
           setState(() {
             newDetailData = NewsDetailResponse.fromJson(responseData);
             ///此处是关闭dialog
             Navigator.pop(context);
             print(newDetailData);
           });
         },(){
           print('请求error');
           ///此处是关闭dialog
           Navigator.pop(context);
           _showNoticeDialog("请求数据发生错误");
         }
       );
    });
  }
  ///显示自定义的dialog，全部重写,posPress在{}内，所以是可选参数
  void _showNoticeDialog(String loadText,{Function posPress}) {
    showDialog(context: context, builder: (BuildContext context) {
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
  _showLoadDialog(){
    print('显示对话框');
    showDialog(context: context,builder: (BuildContext context){
      return LoadDialog(loadText: '加载中...',);
    });
  }
  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
    print('NewsDetail deactivate');
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    print('NewsDetail deactivate');
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    print('NewsDetail build');
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
          body: newDetailData == null ? Text(''):
          Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(5),
                child: Row(
                  children: <Widget>[
                    CircleAvatar(
                      radius:ScreenUtil.getInstance().setHeight(120),
                      backgroundColor: Color(AppColors.grey),
                      backgroundImage: NetworkImage(newDetailData.data.author.avatarUrl),
                    ),
                    Expanded(
                      child:Container(
                        height:ScreenUtil.getInstance().setHeight(260),
                        padding: EdgeInsets.all(ScreenUtil.getInstance().setWidth(10)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text('${newDetailData.data.author.loginName}',style: TextStyle(color: Colors.blue,fontSize: 16),),
                                Text('#楼主',style: TextStyle(color: Colors.black87,fontSize: 14),),
                              ],
                            ),
                            Text('阅读：${newDetailData.data.visitCount}      回复: ${newDetailData.data.replyCount}',style: TextStyle(color: Colors.grey,fontSize: 14),),
                            Text('创建时间：${DateTimeFormat.getFormatDate(newDetailData.data.createAt)}',style: TextStyle(color: Colors.grey,fontSize: 14),),
                          ],
                        ),
                      )
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                color: Color(0xffe4e4e4),
                margin: EdgeInsets.only(bottom: 10),
                child: Padding(padding: EdgeInsets.all(10),
                  child: Text(newDetailData.data.title,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.black87),),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(5),
                  child: InAppWebView(
                    initialData:InAppWebViewInitialData(newDetailData.data.content),
                    initialOptions:{
                      'javaScriptCanOpenWindowsAutomatically':true,
                    },
                  ),
                ),
              ),
              GestureDetector(
                child: Container(
                  color: Colors.blue,
                  alignment: Alignment.center,
                  padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                  child: Text("评论",style: TextStyle(color: Colors.white,fontSize: 16,),),
                ),
                onTap: (){
                  //构建路由
                  Navigator.push<String>(context, MaterialPageRoute(builder: (BuildContext context){
                    return new CommentPage(title: '评论',replyList: newDetailData.data.replies,contentTitle:newDetailData.data.title);
                  }));
                },
              )
            ],
          ),
        ),
        onWillPop: (){
            Navigator.pop(context,'点击android返回键返回${widget.newsId}');
        },
    );

  }

}