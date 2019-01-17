import 'package:flutter/material.dart';
import 'package:my_flutter_demo/NewsPage.dart';

class MainPage extends StatefulWidget{
  //从父组件实例化的地方接收参数mainPageTitle
  MainPage({Key key, this.mainPageTitle}) : super(key: key);
  final String mainPageTitle;


  @override
  _MainPageState createState() {
    // TODO: implement createState
    print('maintitle:'+mainPageTitle);
    return _MainPageState();
  }
}
class _MainPageState extends State<MainPage>{
  final List<String> tabTitleList = ['全部','精华','分享','问答','招聘'];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('MainPage initState');

  }
  List<Widget> _getTabList(){
    List<Widget> textList= List<Widget>();
    tabTitleList.forEach((item){
        textList.add(Text(item));
    });
    return textList;
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
                        children: [NewsPage(allUrl:'桂花几时落',index:0),NewsPage(allUrl:'槐花几时开',index:1),NewsPage(allUrl:'桂花几时落',index:2),NewsPage(allUrl:'槐花几时开',index:3),NewsPage(allUrl:'桂花几时落',index:4),]
                    ),
                     color: Colors.white,)
                ),
            ],
        ),
      ),
      ),);
  }

}