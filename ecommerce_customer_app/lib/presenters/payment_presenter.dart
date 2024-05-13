import 'package:flutter/material.dart';
import 'package:grostore/apis/order_api.dart';
import 'package:grostore/apis/page_api.dart';
import 'package:grostore/apis/refund_api.dart';
import 'package:grostore/apis/wallet_api.dart';
import 'package:grostore/app_lang.dart';
import 'package:grostore/configs/app_config.dart';
import 'package:grostore/helpers/shared_value_helper.dart';
import 'package:grostore/models/order/orders_response.dart';
import 'package:grostore/models/page_response.dart';
import 'package:grostore/models/refund_response.dart';
import 'package:grostore/models/wallet_history_response.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentPresenter extends ChangeNotifier {
  static BuildContext? context;

  setContext(BuildContext context) {
    PaymentPresenter.context = context;
  }

  WebViewController controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted);

  loadUrl(code, method) async {
    controller.loadRequest(
        Uri.parse(
            "${AppConfig.apiUrl}/order/online-payment?code=$code&payment_method=$method"),
        headers: {"Authorization": "Bearer ${access_token.$}"});

    notifyListeners();


  }
  initState(code, method) {
    loadUrl(code, method);
  }
}
