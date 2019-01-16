import 'package:flutter/material.dart';

class MePage extends StatefulWidget{
  MePage({Key key, this.mePageTitle}) : super(key: key);
  final String mePageTitle;
  @override
  _MePageState createState() {
    // TODO: implement createState
    return _MePageState();
  }

}
class _MePageState extends State<MePage>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  Scaffold(
        body: new Center(child:new Text(widget.mePageTitle)),
    );
  }

}