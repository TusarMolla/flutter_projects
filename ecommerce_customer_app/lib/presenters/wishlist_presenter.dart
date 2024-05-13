import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:grostore/apis/coupons_api.dart';
import 'package:grostore/apis/order_api.dart';
import 'package:grostore/apis/wishlist_api.dart';
import 'package:grostore/app_lang.dart';
import 'package:grostore/custom_ui/loading.dart';
import 'package:grostore/custom_ui/toast_ui.dart';
import 'package:grostore/models/coupon_response.dart';
import 'package:grostore/models/order/orders_response.dart';
import 'package:grostore/models/product_mini_response.dart';
import 'package:grostore/models/wishlist_response.dart';

class WishlistPresenter extends ChangeNotifier {
  static BuildContext? context;
  setContext(BuildContext context) {
    WishlistPresenter.context = context;
  }

  List<WishlistInfo> wishlists = [];
  bool isWishlistInit = false;
  bool isAddedWishlist = false;


  fetchWishlistProducts() async {
    var productResponse = await WishlistApi.getWishlist();
    if(productResponse.statusCode==200) {
      wishlists.addAll(productResponse.object.data);
      isWishlistInit = true;
      notifyListeners();
    }else{
      ToastUi.show(context!, AppLang.local(context!).something_went_wrong);
    }

  }



  addWishlist(id,BuildContext context) async {
    var response = await WishlistApi.addWishlist(id);
    if(response.statusCode==200) {
      ToastUi.show(context, response.object.message);
      isAddedWishlist = true;
      notifyListeners();
    }else{
      ToastUi.show(context, AppLang.local(context).something_went_wrong);
    }

  }

  deleteWishlist(id,BuildContext context) async {

    Loading.show(context);
    var response = await WishlistApi.deleteWishlist(id);
    Loading.close();
    if(response.statusCode==200) {
      ToastUi.show(context, response.object.message);
      isAddedWishlist = false;
      initState();
      notifyListeners();
    }else{
      ToastUi.show(context, AppLang.local(context).something_went_wrong);
    }
  }
  checkWishlist(id) async {
    var response = await WishlistApi.checkWishlist(id);
    if(response.statusCode==200) {
      isAddedWishlist=response.object.result;
      print("isAddedWishlist");
      print(isAddedWishlist);
      notifyListeners();
    }else{
      ToastUi.show(context!, AppLang.local(context!).something_went_wrong);
    }
  }

  fetchAll() async{
  await  fetchWishlistProducts();
  }

  clearAll() {
    isWishlistInit=false;
    wishlists.clear();
    notifyListeners();
  }

  Future<void> reFresh(){
    clearAll();
    return fetchAll();
  }

  initState() {
    clearAll();
    fetchAll();
  }
}
