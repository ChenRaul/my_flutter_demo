import 'package:flutter/material.dart';
import 'package:my_flutter_demo/AppColors.dart';
import 'package:my_flutter_demo/DateTimeFormat.dart';
import 'package:my_flutter_demo/LoginPage.dart';
import 'package:my_flutter_demo/NewsDetailResponse.dart';
import 'package:flutter_html_textview/flutter_html_textview.dart';

class CommentPage extends StatefulWidget{
  CommentPage({Key key,this.title,this.replyList,this.contentTitle}):super(key:key);
  final List<Reply> replyList;
  final String title;
  final String contentTitle;
  @override
  _CommentPageState createState() {
    // TODO: implement createState
    return _CommentPageState();
  }

}
class _CommentPageState extends State<CommentPage>{

  bool isLoginSuccess=false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  Widget _getItem(int index){
    return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(bottom: BorderSide(
              color: Color(AppColors.grey),
              width: 1,
            )),
          ),
          child: Padding(
            padding: EdgeInsets.all(5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                CircleAvatar(
                  radius:20,
                  backgroundColor: Color(AppColors.grey),
                  backgroundImage: NetworkImage(widget.replyList[index].author.avatarUrl),
                ),
                Expanded(child:
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(text: '${widget.replyList[index].author.loginName}  ',style: TextStyle(color: Colors.blue)),
                                TextSpan(text: DateTimeFormat.getFormatDate(widget.replyList[index].createAt),style: TextStyle(color: Colors.black87)),
                              ]
                            ),
                          ),
                          Text('#${index+1}')
                        ],
                      ),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.all(5),
                      child: HtmlTextView(data:widget.replyList[index].content),
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.fromLTRB(5, 5, 10, 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Image.asset('img/like.png',width: 15,height: 15,),
                          Text(widget.replyList[index].ups.length > 0 ?' ${widget.replyList[index].ups.length}':'',style: TextStyle(
                            fontSize: 12,color: Colors.grey
                          ),textAlign: TextAlign.right,
                          ),
                        ],
                      )

                    ),
                  ],
                ))
              ],
            ),
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(icon: Image.asset('img/back.png',width: 30,height: 30,), onPressed: (){
              //返回，
              Navigator.pop(context,);
            }),
            title: Text(widget.title),
            centerTitle: true,
          ),
          body:  Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                //跟屏幕的宽度一样
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.fromLTRB(0,30,0,30),
                child: isLoginSuccess ?
                     Text('登录成功')
                    :
                    GestureDetector(
                      child: Text('您未登录，请先登录再评论',style: TextStyle( color: Colors.blue,fontSize: 18,),),
                      onTap: (){
                        Navigator.push<bool>(context, MaterialPageRoute(builder: (BuildContext context){
                          return LoginPage();
                        })).then((ret){
                          //是否登陆成功的判断
                          setState(() {
                            isLoginSuccess = ret;
                          });
                          if(ret){
                            print('登录成功');

                          }else{
                            print('登录失败');
                          }
                        });
                      },
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Color(AppColors.grey),
                  border: Border(left: BorderSide(
                    color: Colors.blue,
                    width: 10
                  ))
                ),

                child: Text('共${widget.replyList.length}条回复'),
              ),
              ///ListView在Column里面使用需要在外面包含Expaned组件
              Expanded(
                  child:ListView.builder(
                    itemCount: widget.replyList.length,
                    itemBuilder: (BuildContext context,int index){
                      return _getItem(index);
                    },
                  )
              )
            ],
          ),
        ),
        
        onWillPop: (){
          Navigator.pop(context);
        });
  }

}