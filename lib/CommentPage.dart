import 'package:flutter/material.dart';
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.replyList);
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
          body: Container(
            child: HtmlTextView(data: widget.replyList[0].content),
          ),
        ),
        
        onWillPop: (){
          Navigator.pop(context);
        });
  }

}