import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_flutter_demo/HomePage.dart';
import 'package:my_flutter_demo/LoginPage.dart';
import 'package:my_flutter_demo/MePage.dart';
import 'package:my_flutter_demo/MessagePage.dart';
import 'package:my_flutter_demo/PublishPage.dart';

class MainPage extends StatefulWidget {
  MainPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MainState createState()  {
    print('title:'+title);
    return _MainState();
  }
}

class _MainState extends State<MainPage> with AutomaticKeepAliveClientMixin{
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
    //TODO 切记
    ///放在BottomNavigationBar+PageView的框架中时，需要再其所有的子组件(需要保存状态)中的Widget build(BuildContext context){}方法里面添加super.build(context);
    ///这样可以解决左右切换界面没有问题，跳转新界面后，当第一页跳转新的界面再返回，再切第二、三页发现重置了，再切回第一页发现页被重置了的问题
    setState(() {
      _pages.add(HomePage(mainPageTitle:'哈哈哈哈哈'));
      _pages.add(PublishPage(publishPageTitle:'okokokokok'));
      _pages.add(MessagePage(messagePageTitle:'呵呵呵呵呵呵'));
      _pages.add(MePage(mePageTitle:'COCOCOCOCOCO'));
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

    // ScreenUtil.instance =  ScreenUtil(width: 1080, height: 2248)..init(context); 等同于下面两句
    ScreenUtil.instance =  ScreenUtil(width: 1080, height: 2248);
    ScreenUtil.instance.init(context);
    ///放在BottomNavigationBar+PageView的框架中时，需要再其所有的子组件(需要保存状态)中的Widget build(BuildContext context){}方法里面添加super.build(context);
    ///这样可以解决左右切换界面没有问题，跳转新界面后，当第一页跳转新的界面再返回，再切第二、三页发现重置了，再切回第一页发现页被重置了的问题
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
            ///点击消息时需要作登陆判断
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