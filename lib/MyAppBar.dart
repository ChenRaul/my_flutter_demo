
import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget{
  MyAppBar({Key key,this.title,this.retObject}):super(key:key);
  final String title;
  final dynamic retObject;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return AppBar(
      leading: IconButton(icon: Image.asset('img/back.png',width: 30,height: 30,), onPressed: (){
        //返回，并返回参数给上一页面
        Navigator.pop(context,retObject);
      }),
      title: Text(title),
      centerTitle: true,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

}