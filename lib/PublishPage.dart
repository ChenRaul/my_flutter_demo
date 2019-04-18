import 'package:flutter/material.dart';

class PublishPage extends StatefulWidget{
  PublishPage({Key key, this.publishPageTitle}) : super(key: key);
  final String publishPageTitle;
  @override
  _PublishPageState createState() {
    // TODO: implement createState
    return _PublishPageState();
  }

}
class _PublishPageState extends State<PublishPage> with AutomaticKeepAliveClientMixin{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    super.build(context);
    return  Scaffold(
        body: new Center(child:new Text(widget.publishPageTitle)),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

}