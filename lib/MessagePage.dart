import 'package:flutter/material.dart';

class MessagePage extends StatefulWidget{
  MessagePage({Key key, this.messagePageTitle}) : super(key: key);
  final String messagePageTitle;
  @override
  _MessagePageState createState() {
    // TODO: implement createState
    return _MessagePageState();
  }

}
class _MessagePageState extends State<MessagePage> with AutomaticKeepAliveClientMixin{

  String text='' ;
  int count=0;
  Future future ;
  bool stopFuture=false;
 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('MessagePage init');
    setStateText();
  }
  void setText(){
    future = Future.delayed(Duration(seconds: 1,),()=> _delayFun());
  }
  void _delayFun(){
    if(stopFuture){

    }else{
      count++;
      if(count >10){
        count = 1;
      }
      setStateText();
    }
  }
  void setStateText(){
   print('${widget.messagePageTitle}$count');
    setState(() {
      text = '${widget.messagePageTitle}$count';
      setText();
    });
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
    print('MessagePage deactivate');
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    stopFuture = true;
    print('MessagePage deactivate');
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    print('MessagePage build');
    super.build(context);
    return Scaffold(
        body: new Center(child:new Text(text)),
      );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

}