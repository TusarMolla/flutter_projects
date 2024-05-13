import 'package:flutter/material.dart';
import 'package:grostore/apis/order_api.dart';
import 'package:grostore/apis/wallet_api.dart';
import 'package:grostore/app_lang.dart';
import 'package:grostore/models/order/orders_response.dart';
import 'package:grostore/models/wallet_history_response.dart';

class WalletPresenter extends ChangeNotifier {
  static BuildContext? context;

  setContext(BuildContext context) {
    WalletPresenter.context = context;
  }

  bool isWalletInit = false;
  List<WalletInfo> walletHistory = [];
  int page = 1;


  getWalletHistory() async {
    var response = await WalletApi.getWalletHistory(page);
    if (response.statusCode == 200) {
      walletHistory.addAll(response.object.data);
      page++;
      isWalletInit = true;
      notifyListeners();
    }
  }

  fetchAll() async {
    getWalletHistory();
  }

Future<void>  onRefresh()async {
    clearAll();
    return fetchAll();
  }

  clearAll() {
    page = 1;
    walletHistory.clear();
    isWalletInit = false;
    notifyListeners();
  }

  initState() {
    fetchAll();
  }
}
