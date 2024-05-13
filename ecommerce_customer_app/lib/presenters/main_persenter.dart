import 'package:flutter/material.dart';
import 'package:grostore/custom_classes/system_data.dart';
import 'package:grostore/helpers/shared_value_helper.dart';
import 'package:grostore/screens/auth/login.dart';
import 'package:grostore/screens/categories.dart';
import 'package:grostore/screens/home.dart';
import 'package:grostore/screens/order/orders.dart';
import 'package:grostore/screens/profile.dart';
import 'package:route_transitions/route_transitions.dart';

class MainPresenter extends ChangeNotifier {
  static BuildContext? context;

  setContext(BuildContext context) {
    MainPresenter.context = context;
  }

  int bottomAppbarIndex = 0;

  // BottomAppbarIndex bottomAppbarIndex = BottomAppbarIndex();

  var bottomAppbarChildren = [Home(), Categories(), Orders(), Account()];

  fetchAll() {
    getCartCount();
  }

  void onTapped(int i) {
    if ((i == 2)) {
      if ((!SystemData.isLogIn)) {
        Navigator.push(
            context!, MaterialPageRoute(builder: (context) => Login()));
        return;
      }
    }

    if (i == 3) {
      language_is_rtl.$
          ? slideLeftWidget(newPage: Account(), context: context!)
          : slideRightWidget(newPage: Account(), context: context!);
      return;
    }

    bottomAppbarIndex = i;

    notifyListeners();
    //print("i$i");
  }

  getCartCount() async {
    // Provider.of<Cart>(context, listen: false).getCount();
  }
}
