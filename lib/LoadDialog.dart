
import 'package:flutter/material.dart';

class LoadDialog extends SimpleDialog{
  final loadText;

  LoadDialog({Key key,this.loadText}):super(key:key);

  @override
  Widget build(BuildContext context) {
      return Material(
          type:MaterialType.transparency,
          child: Center(
              child:Container(
                  width: 100,
                  height: 100,
//                  color: Colors.white,
                  //一般这样来增加shape，也就是所谓的边框 圆角等,此属性不能与前面的color一起使用
                  decoration: BoxDecoration(
                      color:Colors.white ,
                      border: Border.all(width: 1.0,color: Colors.white),
                      borderRadius: BorderRadius.circular(5),
                  ),
                  child:
                      Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                              Padding(padding: EdgeInsets.all(10),
                                child:  CircularProgressIndicator(
                                    strokeWidth: 3,
                                )
                              ),
                              Padding(padding: EdgeInsets.all(5),
                                  child:  Text(loadText),
                              )
                          ],
                      ),
              ) ,),
      );
  }

}