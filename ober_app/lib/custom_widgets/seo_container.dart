


import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ober_app/blocs/setting_bloc.dart';
import 'package:ober_app/states/setting_state.dart';

class SeoContainer extends Container {
   SeoContainer({this.decoration,super.alignment,super.padding,super.child,    this.width,
     this.height});
   double? width,height;
   @override
  BoxDecoration? decoration;
  @override
  Widget build(BuildContext context) {
    return  BlocBuilder<SettingBloc,SettingState>(
      builder: (context,state) {
        print("change decoration");
        return Container(
          // color: state.themeContainerBgColor,
          decoration:decoration?.copyWith(color: state.themeContainerBgColor),
          height: height,
          width: width,
          padding: padding,
          alignment: alignment,
          child: child,
        );
      }
    );
  }
}
