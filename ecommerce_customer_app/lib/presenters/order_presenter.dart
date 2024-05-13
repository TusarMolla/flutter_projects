import 'package:flutter/material.dart';
import 'package:grostore/apis/order_api.dart';
import 'package:grostore/app_lang.dart';
import 'package:grostore/custom_ui/loading.dart';
import 'package:grostore/models/order/orders_response.dart';
import 'package:grostore/models/order/track_order_response.dart';

class OrderPresenter extends ChangeNotifier {
  static BuildContext? context;

  setContext(BuildContext context) {
    OrderPresenter.context = context;
  }

  Map<String, String> searchKey = {};
  int keySelectedIndex = 0;
  bool isOrdersInit = false;
  List<OrderInfo> orders = [];
  int page = 1;

  TrackInfo? trackInfo;

  TextEditingController trackOrderController = TextEditingController();

  insetSearchKeys() {
    searchKey = {
      "all": AppLang.local(context!).all_order,
      "order_placed": AppLang.local(context!).pending,
      "processing": AppLang.local(context!).processing,
      "delivered": AppLang.local(context!).delivered,
      "cancelled": AppLang.local(context!).cancelled,
    };
    notifyListeners();
  }

  getOrders() async {
    var response = await OrderApi.getOrders(
        searchKey.keys.elementAt(keySelectedIndex), page);

    if (response.statusCode == 200) {
      orders.addAll(response.object.data);
      page++;
      isOrdersInit = true;
      notifyListeners();
    }
  }

  trackOrder(id,BuildContext context) async {
    Loading.show(context);
    var response = await OrderApi.trackOrder(id);
    Loading.close();
    if (response.statusCode == 200) {
      trackInfo=response.object.data;
      notifyListeners();
    }
  }

  onChangeIndex(int index) {
    if (index != keySelectedIndex) {
      keySelectedIndex = index;

      orders.clear();
      page = 1;
      isOrdersInit = false;
      notifyListeners();
      getOrders();
    }
  }

  fetchAll() async {
    getOrders();
  }

  onRefresh() {
    clearAll();
    return fetchAll();
  }

  clearAll() {
    page = 1;
    orders.clear();
    keySelectedIndex = 0;
    isOrdersInit = false;
    notifyListeners();
  }

  initState() {
    insetSearchKeys();
    fetchAll();
  }
}
