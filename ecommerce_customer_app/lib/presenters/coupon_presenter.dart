import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:grostore/apis/coupons_api.dart';
import 'package:grostore/apis/order_api.dart';
import 'package:grostore/app_lang.dart';
import 'package:grostore/models/coupon_response.dart';
import 'package:grostore/models/order/orders_response.dart';

class CouponPresenter extends ChangeNotifier {
  static BuildContext? context;
  List<CountdownTimerController> controller=[];
  setContext(BuildContext context) {
    CouponPresenter.context = context;
  }

  List<CouponInfo> coupons = [];
  bool isCouponsInit = false;

  DateTime convertTimeStampToDateTime(int timeStamp) {
    var dateToTimeStamp = DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);
    return dateToTimeStamp;
  }


  getCoupons() async {
    var response = await CouponsApi.getCoupons();
    if (response.statusCode == 200) {
      coupons.addAll(response.object.data);
      isCouponsInit=true;
      coupons.forEach((element) {

        DateTime end = convertTimeStampToDateTime(
            int.parse(element.endDate)); // YYYY-mm-dd
        DateTime now = DateTime.now();
        int diff = end.difference(now).inMilliseconds;
        int endTime = diff + now.millisecondsSinceEpoch;


        print(element.endDate);
        controller.add( CountdownTimerController(endTime:endTime , onEnd: (){}));
      });
      notifyListeners();
    }
  }

  fetchAll() {
    getCoupons();
  }

  clearAll() {
    isCouponsInit=false;
    coupons.clear();
  }

  initState() {
    clearAll();
    fetchAll();
  }
}
