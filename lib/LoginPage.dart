
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter_demo/CustomNoticeDialog.dart';
import 'package:my_flutter_demo/LoadDialog.dart';
import 'package:my_flutter_demo/MyAppBar.dart';
import 'package:my_flutter_demo/AppColors.dart';

class LoginPage extends StatefulWidget{
  @override
  _LoginPageState createState() {
    // TODO: implement createState
    return _LoginPageState();
  }

}

class _LoginPageState extends State<LoginPage>{
  bool isLoginSuccess = false;
  String password='';
  CupertinoButton login;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
//显示对话框
  void _showLoadDialog(){
    showDialog(context: context,builder: (BuildContext context){
      return LoadDialog(loadText: '登录中...',);
    });
  }

  void _showNoticeDialog(){
    showDialog(context: context,builder: (BuildContext context){
      return CustomNoticeDialog();
    });
  }
  //登录
  void _onLogin(){
    _showLoadDialog();
    //Futuer，delayed的回调函数只能是一句语句，其他可能也是
    Future.delayed(Duration(seconds: 3),()=> _loginOver());
  }
  void _loginOver(){
    Navigator.of(context).pop();
    print('登录结束');
    _showNoticeDialog();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
        child: Scaffold(
          appBar: MyAppBar(title:'登录',retObject: isLoginSuccess,),
          body: Container(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(40, 60, 40, 20),
                  child: TextField(
                    textAlign: TextAlign.start,
                    keyboardType: TextInputType.number,
                    cursorWidth: 1,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black87

                    ),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(10) ,
                      hintText: '请输入密码',
                      hintStyle: TextStyle(color: Colors.grey,fontSize: 16),
                      icon: Icon(Icons.https,size: 30,),
                      border:OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        borderSide: BorderSide(
                          color: Color(AppColors.grey),
                        ),
                        gapPadding: 0,
                      ),
                    ),
                    onChanged:(String text){
                        setState(() {
                          password = text;
                        });
                    }
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(40),
                  child: login = CupertinoButton(
                      disabledColor: Colors.grey,
                      color: Color(AppColors.appThemeColor),
                      pressedOpacity: 0.9,
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      child:Text('登录',style: TextStyle(color: Colors.white,fontSize: 18,),),
                    ///  onPressed为null，按钮就会自动不能点击
                    onPressed: password.length > 0 ?(){
                        _onLogin();
                      }:null,
                  )
                )

              ],
            ),
          ),
        ),
        onWillPop: (){
          Navigator.pop(context,isLoginSuccess);
        }
    );
  }

}