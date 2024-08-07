



import 'package:flutter/cupertino.dart';
import 'package:ober_app/config/style_config.dart';
import 'package:ober_app/config/theme_config.dart';
import 'package:ober_app/helpers/main_helper.dart';

class Dialogs{
  static  yesNo({required BuildContext context,required String title,required String content,required void Function() yesOnClick, void Function()? noOnClick}){
    showCupertinoDialog(context: context, builder:(context)=>CupertinoAlertDialog(
      title: Text(title,style: StyleConfig.fs14fwBold.copyWith(color: ThemeConfig.black),),
      content: Text(content,style: StyleConfig.fs14.copyWith(color: ThemeConfig.black),),

      actions: [

        CupertinoDialogAction(
            onPressed: (){
              Navigator.pop(context);

              yesOnClick();
            },

            // color: Colors.grey,
            child: Text("Yes",style: StyleConfig.fs14cWhitefwNormal.copyWith(color: ThemeConfig.red),)),

        CupertinoDialogAction(
            onPressed: (){
              Navigator.pop(context);

              if(noOnClick !=null)
                noOnClick() ;
            },
            // color: Colors.grey,
            child: Text("NO",style: StyleConfig.fs14cWhitefwNormal.copyWith(color: ThemeConfig.darkThemeColor),)),
      ],
    ));
  }

  static  dynamicYesNo({required BuildContext context,required String title,required String content,required void Function() yesOnClick, void Function()? noOnClick,String? yes,String? no}){
    showCupertinoDialog(context: context, builder:(context)=>CupertinoAlertDialog(
      title: Text(title,style: StyleConfig.fs14fwBold.copyWith(color: ThemeConfig.black),),
      content: Text(content,style: StyleConfig.fs14.copyWith(color: ThemeConfig.black),),

      actions: [

        CupertinoDialogAction(
            onPressed: (){
              Navigator.pop(context);

              yesOnClick();
            },

            // color: Colors.grey,
            child: Text(yes??getLocal(context).yes,style: StyleConfig.fs14cWhitefwNormal.copyWith(color: ThemeConfig.red),)),

        CupertinoDialogAction(
            onPressed: (){
              Navigator.pop(context);

              if(noOnClick !=null)
                noOnClick() ;
            },
            // color: Colors.grey,
            child: Text(no??getLocal(context).no,style: StyleConfig.fs14cWhitefwNormal.copyWith(color: ThemeConfig.darkThemeColor),)),
      ],
    ));
  }
  static  info({required BuildContext context,required String content,VoidCallback? onClickOk}){
    showCupertinoDialog(context: context,

        builder:(context)=>

        CupertinoAlertDialog(

      content: Text(content,style: StyleConfig.fs14.copyWith(color: ThemeConfig.black),),
      actions: [
        CupertinoDialogAction(
            onPressed: (){
              Navigator.pop(context);
              if(onClickOk !=null) {
                        onClickOk();
                      }
                    },

            // color: Colors.grey,
            child: Text("OK",style: StyleConfig.fs14cWhitefwNormal.copyWith(color: ThemeConfig.accentColor),)),
      ],
    ));
  }

  static  yesNoWithWidget({required BuildContext context,required String title,required String content,required void Function() yesOnClick, void Function()? noOnClick,String yesTxt = "Yes",String noTxt = "No",required Widget contentWidget}){
    showCupertinoDialog(context: context, builder:(context)=>CupertinoAlertDialog(
      title: Text(title,style: StyleConfig.fs14fwBold.copyWith(color: ThemeConfig.black),),
      content: Column(
        children: [
          Text(content,style: StyleConfig.fs14.copyWith(color: ThemeConfig.black),),
          contentWidget

        ],
      ),
      actions: [
        CupertinoDialogAction(
            onPressed: (){
              Navigator.pop(context);
              yesOnClick();
            },

            // color: Colors.grey,
            child: Text(yesTxt,style: StyleConfig.fs14cWhitefwNormal.copyWith(color: ThemeConfig.red),)),

        CupertinoDialogAction(
            onPressed: (){
              Navigator.pop(context);

              if(noOnClick !=null)
                noOnClick() ;
            },
            // color: Colors.grey,
            child: Text(noTxt,style: StyleConfig.fs14cWhitefwNormal.copyWith(color: ThemeConfig.darkThemeColor),)),
      ],
    ));
  }

}