import 'package:flutter/material.dart';
import 'package:my_flutter_demo/AppColors.dart';

class CustomNoticeDialog extends Dialog{
  final String noticeText,noticeTitle,posBtnText,negBtnText;
  final bool clickOutCancel,isShowOneBtn;
  final Function posPress,negPress;

  CustomNoticeDialog({
    Key key,
    this.noticeText,
    this.noticeTitle,
    this.clickOutCancel,//点击对话框外部 是否消失
    this.isShowOneBtn,//是否只显示一个按钮
    this.posBtnText,
    this.negBtnText,
    this.posPress,
    this.negPress,
  }):super(key:key);


  Text _getText(String text){

    return Text(text,
              style: TextStyle(
                color: Color(AppColors.appThemeColor),
                decoration: TextDecoration.none,
                fontSize: 18,
              ),
          );
  }
  ///按钮
  Widget _getBtn(BuildContext context){
    if(isShowOneBtn){//显示一个按钮
      return GestureDetector(
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
          decoration: BoxDecoration(
              border: Border(
                  top: BorderSide(
                    color: Color(AppColors.grey),
                    width: 1,
                  )
              )
          ),
          child: _getText(posBtnText),

        ),
        onTap: (){
          Navigator.pop(context);
          posPress();
        },
      );
    }else{
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          GestureDetector(
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
              width: MediaQuery.of(context).size.width*0.8*0.5,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Color(AppColors.grey),
                    width: 1,
                  ),
                  right:BorderSide(
                    color: Color(AppColors.grey),
                    width: 0.5,
                  ),
                )
              ),
              child: _getText(negBtnText),
            ),
            onTap: (){
              Navigator.pop(context);
              negPress();
            },
          ),
          GestureDetector(
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
              width: MediaQuery.of(context).size.width*0.8*0.5,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Color(AppColors.grey),
                    width: 1,
                  ),
                  left:BorderSide(
                    color: Color(AppColors.grey),
                    width: 0.5,
                  ),
                )
              ),
              child: _getText(posBtnText),
            ),
            onTap: (){
              Navigator.pop(context);
              posPress();
            },
          ),
        ],
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    
    return  GestureDetector(
      child: Container(
        color: Color(0x00000000),
        child:  Center(
          child: Container(
            width: MediaQuery.of(context).size.width*0.8,
            height: 240,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius:BorderRadius.all( Radius.circular(3)),
            ),
            child: Column(
              children: <Widget>[
                ///标题
                Padding(
                  padding: EdgeInsets.all(5),
                  child: Text(noticeTitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,

                    style: TextStyle(
                      decoration: TextDecoration.none,
                      color: Color(AppColors.appThemeColor),
                      fontSize: 20,

                    ),
                  ),
                ),
                //提示内容，正文内容
                Expanded(
                  child:Container(
                    alignment: Alignment.center,
                    child: Text(noticeText,style: TextStyle(
                      color: Colors.black87,
                      fontSize: 18,
                      decoration: TextDecoration.none,
                    ),),
                  )
                ),
                _getBtn(context),
              ],
            ),
          ),
        ),
      ),
      onTap: (){
        if(clickOutCancel){
          Navigator.pop(context);
        }
      },
    );
  }

}