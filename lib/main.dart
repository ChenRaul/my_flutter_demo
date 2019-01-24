
import 'package:flutter/material.dart';
import 'package:my_flutter_demo/LoginPage.dart';
import 'package:my_flutter_demo/HomePage.dart';
import 'package:my_flutter_demo/MainPage.dart';
import 'package:my_flutter_demo/MePage.dart';
import 'package:my_flutter_demo/MessagePage.dart';
import 'package:my_flutter_demo/NewsDetail.dart';
import 'package:my_flutter_demo/PublishPage.dart';
import 'package:my_flutter_demo/SplashPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      routes: <String, WidgetBuilder>{
          '/main':(BuildContext context)=> MainPage(title:'Flutter Demo Home Page'),//根目录
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
      home: SplashPage(),
    );
  }
}


