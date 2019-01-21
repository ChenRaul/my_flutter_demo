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
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
        body: new Center(child:new Text(widget.messagePageTitle)),
      );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

}