
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SplashPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SplashPageState();
  }

}

class _SplashPageState extends State<SplashPage>{
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('SplashPage initState');
    Future.delayed(Duration(seconds: 3),()=> _jump());
  }
  void _jump(){
    print('SplashPage 跳转');
    Navigator.of(context).pushReplacementNamed('/main');
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    print('SplashPage build');
    return Image.asset('img/launch.png',
            fit: BoxFit.fill,
            height: double.infinity,
            width: double.infinity,);
  }

}