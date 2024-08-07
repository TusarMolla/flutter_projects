
import 'package:flutter/material.dart';
import 'package:ober_app/config/style_config.dart';
import 'package:ober_app/config/theme_config.dart';
import 'package:ober_app/helpers/device_info.dart';
import 'package:ober_app/helpers/main_helper.dart';
import 'package:ober_app/others/seo_route.dart';
import 'package:ober_app/ui/pages/tickets/create_ticket.dart';


class Buttons extends StatelessWidget {
  const Buttons({Key? key, this.color = const Color.fromARGB(0, 0, 0, 0),
    this.shape = const RoundedRectangleBorder(),
    required this.child,
    this.alignment = Alignment.center,
    this.padding = EdgeInsets.zero,
    this.minHeight,
    this.minWidth,
    this.onPressed}):super(key:key);
  final Color? color;
  final OutlinedBorder? shape;
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final dynamic minWidth;
  final dynamic minHeight;
  final dynamic onPressed;
  final AlignmentGeometry alignment;
  @override
  Widget build(BuildContext context) {
    return _basic();
  }


  Widget _basic() {
    //if (width != null && height != null)
    return TextButton(
      style: TextButton.styleFrom(
          foregroundColor: themeTxtColor,
          padding: padding,
          backgroundColor: color,
          minimumSize: minWidth == null ? null : Size(
              minWidth.toDouble(), minHeight ?? 10),
          alignment: alignment,
          shape: shape),
      onPressed: onPressed,
      child: child,
    );
  }

  static Widget   round({required VoidCallback? onPress, required Widget child,double? width,double height = 46, EdgeInsetsGeometry? padding, double radius = 200,Color bColor = ThemeConfig.accentColor})=> TextButton(
    style: TextButton.styleFrom(
        foregroundColor: ThemeConfig.fontColor,
        padding: padding,
        backgroundColor: bColor,
        disabledBackgroundColor: ThemeConfig.grey,
        // fixedSize: Size( minWidth,minHeight),
        fixedSize: Size(width??DeviceInfo.width, height),
        alignment: Alignment.center,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius))),
    onPressed: onPress,
    child: child,
  );

  static gotoTicket(BuildContext context){
    return Buttons.round(onPress: (){
      SEORoute.go(context, const CreateTicket());
    }, child: Text(getLocal(context).create_a_ticket,style: StyleConfig.fs18.copyWith(color: themeBoxColor),),bColor: themeTxtColor,radius: 10,);
  }

}
