import 'package:flutter/material.dart';
import 'package:grostore/configs/style_config.dart';
import 'package:grostore/configs/theme_config.dart';
import 'package:grostore/custom_ui/Boxdecorations.dart';
import 'package:grostore/custom_ui/Button.dart';
import 'package:grostore/helpers/route.dart';
import 'package:grostore/screens/main.dart';

class CommonAppbar {
  static AppBar show(
      {required String title,
      required BuildContext context,
      bool showBackButton = true,
      bool gotoMain = false,
      PreferredSizeWidget? bottom}) {
    return AppBar(
      backgroundColor: ThemeConfig.white,
      elevation: 0,
      title: Text(
        title,
        style: StyleConfig.fs16fwBold,
      ),
      centerTitle: true,
      leading: showBackButton
          ? Button(
              minWidth: 60,
              onPressed: () {
                if (gotoMain) {
                  MakeRoute.goAndRemoveAll(context, Main());
                } else {
                  Navigator.pop(context);
                }
              },
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecorations.shadow(radius: 20),
                child: Icon(
                  Icons.arrow_back_outlined,
                  size: 26,
                  color: ThemeConfig.darkGrey,
                ),
              ),
            )
          : const SizedBox.shrink(),
      bottom: bottom,
    );
  }
}
