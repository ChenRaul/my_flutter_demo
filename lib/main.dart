
import 'package:flutter/material.dart';
import 'package:my_flutter_demo/LoginPage.dart';
import 'package:my_flutter_demo/HomePage.dart';
import 'package:my_flutter_demo/MePage.dart';
import 'package:my_flutter_demo/MessagePage.dart';
import 'package:my_flutter_demo/NewsDetail.dart';
import 'package:my_flutter_demo/PublishPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      //路由列表，需要跳转的页面填写在此处
      initialRoute: '/',//最开始进入的界面，具体界面咋routes属性里面注册
      routes: <String, WidgetBuilder>{
          '/':(BuildContext context)=> Main(title:'Flutter Demo Home Page'),//根目录
        //这种方式是命名路由，不能动态传递参数，只能传递一些固定的参数，
        // 如需要传递动态参数，则需要使用构建路由，所以在NewsPage页面里面使用构建路由跳转到NewsDetail页面，因为需要传递每一条新闻的id
          '/newsDetail':(BuildContext context)=> NewsDetail(title:'详情'),
          '/login':(BuildContext context)=> LoginPage(),
      },
      theme: ThemeData(
        //这种方式只能固定选择MaterialColor系统中定义的几种颜色来设置主题颜色，所以使用下面的方式来自定主题颜色
        primarySwatch: Colors.blue,
        primaryColor:const Color(0xff1296db),
        accentColor:const Color(0xff2296db),
      ),
//TODO      设置了initialRoute需要把下面的home屏蔽掉
//      home: Main(title: 'Flutter Demo Home Page'),
    );
  }
}

class Main extends StatefulWidget {
  Main({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MainState createState()  {
    print('title:'+title);
    return _MainState();
  }
}

class _MainState extends State<Main> with AutomaticKeepAliveClientMixin{
  int _currentIndex = 0;
  final List<String> titles=['首页','发表','消息','我的'];
  List<StatefulWidget> _pages= List<StatefulWidget>();
  PageController _pageController = PageController(initialPage: 0);

  Image _getTabImageIcon(imagePath){
      return Image.asset(imagePath,width: 30,height: 30,);
  }
  Text _getTabText(index){
    if(_currentIndex == index){
      return Text(titles[index],style: TextStyle(color:const Color(0xff2296db),fontSize: 14));
    }else{
      return Text(titles[index],style: TextStyle(color: const Color(0xffbfbfbf),fontSize: 14));
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      _pages.add(HomePage(mainPageTitle:'哈哈哈哈哈'));
      _pages.add(PublishPage(publishPageTitle:'槐花几时开'));
      _pages.add(MessagePage(messagePageTitle:'桂花几时落'));
      _pages.add(MePage(mePageTitle:'槐花几时开'));
    });
    print('Main initstate');
  }
  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
    print('Main deactivate');
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    print('Main deactivate');
  }
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    print('Main build');
    return Scaffold(
      appBar: _currentIndex == 0 ? null :AppBar(
          title: Text(titles[_currentIndex]),
          centerTitle:true,
      ),
      body: PageView.builder(
          controller:_pageController,
          onPageChanged: (index){
            setState(() {
              _currentIndex=index;
            });
          },
          itemBuilder: (BuildContext context, int index){
              return _pages[index];
      }),
//      floatingActionButton: FloatingActionButton(
//        tooltip: 'Increment',
//        child: Icon(Icons.add),
//      ), // This trailing comma makes auto-formatting nicer for build methods.
      //底部Tab
       bottomNavigationBar: BottomNavigationBar(
           items: [
                BottomNavigationBarItem(icon:_getTabImageIcon('img/main_normal.png'),title: _getTabText(0),activeIcon:_getTabImageIcon('img/main_select.png') ),
                BottomNavigationBarItem(icon:_getTabImageIcon('img/publish_normal.png'),title: _getTabText(1),activeIcon: _getTabImageIcon('img/publish_select.png')),
                BottomNavigationBarItem(icon:_getTabImageIcon('img/message_normal.png'),title: _getTabText(2),activeIcon: _getTabImageIcon('img/message_select.png')),
                BottomNavigationBarItem(icon:_getTabImageIcon('img/me_normal.png'),title: _getTabText(3),activeIcon: _getTabImageIcon('img/me_select.png')),
           ],
         type: BottomNavigationBarType.fixed,
         //设置当前的索引,
         currentIndex: _currentIndex,
          onTap: (index){
            if(index == 3){
              Navigator.push<bool>(context, MaterialPageRoute(builder: (BuildContext context){
                return LoginPage();
              })).then((ret){
                if(ret){
                  print('登录成功');
                  _pageController.jumpToPage(index);
                }else{
                  print('登录失败');
                }
              });
            }else{
              _pageController.jumpToPage(index);
            }
          },
       ),

    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

}
