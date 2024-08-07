






import 'package:flutter/material.dart';
import 'package:ober_app/custom_widgets/images.dart';
import 'package:ober_app/helpers/main_helper.dart';

class SeoNoData extends StatelessWidget {
  const SeoNoData({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(getAssetImage("nodata.png"),color: themeTxtColor,);
  }
}
