import 'package:flutter/material.dart';
import 'package:grostore/configs/theme_config.dart';

class Button extends StatelessWidget {
 final Color? color;
 final OutlinedBorder? shape;
 final Widget child;
 final EdgeInsetsGeometry? padding;
 final dynamic? minWidth;
 final dynamic? minHeight;
 final dynamic? onPressed;
 final AlignmentGeometry alignment;

   const Button({Key? key, this.color = const Color.fromARGB(0, 0, 0, 0),
  this.shape = const RoundedRectangleBorder(),
     required this.child,
     this.alignment = Alignment.center,
     this.padding = EdgeInsets.zero,
     this.minHeight,
   this.minWidth,

   this.onPressed}) : super(key: key);




  @override
  Widget build(BuildContext context) {
    return _basic();
  }


   Widget _basic() {
    //if (width != null && height != null)
    return TextButton(
      style: TextButton.styleFrom(
          foregroundColor: ThemeConfig.fontColor,
          padding: padding,
          backgroundColor: color,
          minimumSize: minWidth == null ? null : Size(minWidth.toDouble(),minHeight?? 10),
          alignment: alignment,
          shape: shape),
      onPressed: onPressed,
      child: child,
    );
  }

  static Widget minSize(
      {required width,
        required double height,
        color,
        shape,
        child,
        EdgeInsetsGeometry padding=EdgeInsets.zero,
        dynamic onPressed}) {
    return TextButton(
      style: TextButton.styleFrom(
        padding: padding,
          foregroundColor: ThemeConfig.noColor,
          minimumSize: Size(width.toDouble(), height.toDouble()),
          backgroundColor: onPressed != null ? color : ThemeConfig.grey,
          shape: shape,
          disabledForegroundColor: Colors.blue),
      child: child,
      onPressed: onPressed,
    );
  }

  static Widget maxSize(
      {width, height, color, shape, child, dynamic onPressed}) {
    return TextButton(
      style: TextButton.styleFrom(
          foregroundColor: ThemeConfig.noColor,
          maximumSize: Size(width, height),
          backgroundColor: color,
          shape: shape),
      child: child,
      onPressed: onPressed,
    );
  }
}
