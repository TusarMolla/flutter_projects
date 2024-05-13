import 'package:flutter/material.dart';
import 'package:grostore/configs/app_config.dart';
import 'package:grostore/custom_ui/common_appbar.dart';
import 'package:grostore/helpers/route.dart';
import 'package:grostore/helpers/shared_value_helper.dart';
import 'package:grostore/presenters/page_presenter.dart';
import 'package:grostore/presenters/payment_presenter.dart';
import 'package:grostore/screens/order/orders.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Payment extends StatefulWidget {
  final int code;
  final String payment_method;
  final String title;

  const Payment(
      {super.key,
      required this.code,
      required this.payment_method,
      required this.title});

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  PaymentPresenter paymentPresenter = PaymentPresenter();

  @override
  void initState() {
    // TODO: implement initState

    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   paymentPresenter.initState(widget.code, widget.payment_method);
    // });
    paymentPresenter.controller.loadRequest(
        Uri.parse(
            "${AppConfig.apiUrl}/order/online-payment?code=${widget.code}&payment_method=${widget.payment_method}"),
        headers: {"Authorization": "Bearer ${access_token.$}"});

    paymentPresenter.controller.setNavigationDelegate(NavigationDelegate(
      onPageFinished: (page){
        if(page.contains('checkout-complete')||page.contains('success')||page.contains("cancel")||page.contains("callback")){
          MakeRoute.go(context, Orders(fromBottomBar: false,fromCheckOut: true,));
        }
      }
    ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
        listenable: paymentPresenter,
        builder: (context, child) {
          return Scaffold(
            appBar: CommonAppbar.show(title: widget.title, context: context),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: WebViewWidget(
                controller: paymentPresenter.controller,
              ),
            ),
          );
        });
  }
}
