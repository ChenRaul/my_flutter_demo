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
class _MePageState extends State<MePage> with AutomaticKeepAliveClientMixin{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    print('MePage build');
    super.build(context);
    return  Scaffold(
        body: new Center(child:new Text(widget.mePageTitle)),
    );
  }
  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
    print('MePage deactivate');
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    print('MePage deactivate');
  }
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

}