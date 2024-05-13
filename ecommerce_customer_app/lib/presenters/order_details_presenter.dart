

import 'package:flutter/cupertino.dart';
import 'package:grostore/apis/order_api.dart';
import 'package:grostore/models/order/order_details_response.dart';

class OrderDetailsPresenter extends ChangeNotifier{
  static BuildContext? context;

  setContext(BuildContext context) {
    OrderDetailsPresenter.context = context;
  }

  bool isInitDetails = false;
  OrderDetailsInfo? orderInfo ;
static  var orderCode=0;


  getDetails(code) async {
    print(code);
    var response = await OrderApi.getDetails(code:  code);
    if (response.statusCode == 200) {
      orderInfo=response.object.data;
      isInitDetails = true;
      notifyListeners();
    }
  }

  fetchAll(code) async {
    getDetails(code);
  }

  Future<void>onRefresh(code) {
    clearAll();
    return fetchAll(code);
  }

  clearAll() {
    orderInfo=null;
    isInitDetails = false;
    notifyListeners();
  }

  initState(code) {
    fetchAll(code);
    orderCode = code;
    notifyListeners();
  }
}