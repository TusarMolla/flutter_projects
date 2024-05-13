import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grostore/custom_ui/toast_ui.dart';
import 'package:grostore/helpers/common_functions.dart';
import 'package:grostore/screens/main.dart';

import 'middleware.dart';

class BannedMiddleware extends MiddleWare{

  BuildContext context;

  BannedMiddleware(this.context);

  @override
  bool next(String response) {
    var jsonResponse = jsonDecode(response);

    if(!jsonResponse['result'] && jsonResponse['is_banned'] !=null && jsonResponse['is_banned']){
      ToastUi.show(context, jsonResponse['message']);
      resetApp(context);
      return false;
    }
  return true;

  }

}