import 'package:flutter/material.dart';
import 'package:my_flutter_demo/NewsPage.dart';

class HomePage extends StatefulWidget{
  //从父组件实例化的地方接收参数mainPageTitle
  HomePage({Key key, this.mainPageTitle}) : super(key: key);
  final String mainPageTitle;


  @override
  _HomePageState createState() {
    // TODO: implement createState
    print('maintitle:'+mainPageTitle);
    return _HomePageState();
  }
}
class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin{
  final List<String> tabTitleList = ['全部','精华','分享','问答','招聘'];
  final NewsPage all = NewsPage(url:'https://cnodejs.org/api/v1/topics?tab=all',index:0);
  final NewsPage good = NewsPage(url:'https://cnodejs.org/api/v1/topics?tab=good',index:1);
  final NewsPage share = NewsPage(url:'https://cnodejs.org/api/v1/topics?tab=share',index:2);
  final NewsPage ask = NewsPage(url:'https://cnodejs.org/api/v1/topics?tab=ask',index:3);
  final NewsPage job = NewsPage(url:'https://cnodejs.org/api/v1/topics?tab=job',index:4);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('HomePage initState');

  }
  List<Widget> _getTabList(){
    List<Widget> textList= List<Widget>();
    tabTitleList.forEach((item){
        textList.add(Text(item));
    });
    return textList;
  }
  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
    print('HomePage deactivate');
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    print('HomePage dispose');
  }
  @override
  Widget build(BuildContext context) {
    print('MainPage build');
    return new MaterialApp(
      theme: new ThemeData(
        primaryColor:const Color(0xff1296db),
      ),
      //使用TabBar，TabBarView
      home: new DefaultTabController(length: tabTitleList.length, child: new Scaffold(
        backgroundColor:Color(0xff1296db),
        body: new Column(
            children: <Widget>[
               SafeArea(
                   top: true,
                   bottom: false,
                 //标题栏，使用SafeArea,top为true避免标题栏被状态栏给遮住
                   child:  Container(
                       child: TabBar(tabs:_getTabList(),
                           isScrollable:false,
                           indicatorColor:Colors.white,
                           indicatorSize: TabBarIndicatorSize.tab,
                           indicatorWeight:4.0,
                           labelStyle:TextStyle(color: Colors.white,fontSize: 16),
                           unselectedLabelStyle: TextStyle(color: Colors.grey,fontSize: 16),
                      ),

                       height: 50,
                       color: Color(0xff1296db),
                   ),
                ),
                Expanded(
                  child:  Container(
                    child:TabBarView(
                        children: [all,good,share,ask,job]
                    ),
                     color: Colors.white,)
                ),
            ],
        ),
      ),
      ),);
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

}