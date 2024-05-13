import 'package:flutter/material.dart';
import 'package:grostore/app_lang.dart';
import 'package:grostore/helpers/device_info_helper.dart';


class NoData extends StatefulWidget {
  const NoData({super.key});

  @override
  State<NoData> createState() => _NoDataState();
}

class _NoDataState extends State<NoData> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: getHeight(context),
      child: Center(
        child: Text(AppLang.local(context).data_is_not_available),
      ),
    );
  }
}
