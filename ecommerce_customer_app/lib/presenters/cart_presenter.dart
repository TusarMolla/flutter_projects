
import 'package:flutter/material.dart';
import 'package:grostore/apis/cart_api.dart';
import 'package:grostore/apis/order_api.dart';
import 'package:grostore/custom_classes/system_data.dart';
import 'package:grostore/custom_ui/toast_ui.dart';
import 'package:grostore/models/cart_response.dart';
import 'package:grostore/models/order/order_summery_response.dart';

class CartPresenter extends ChangeNotifier{
  static BuildContext? context;
  setContext(BuildContext context){
    CartPresenter.context=context;
  }
  TextEditingController couponTxtController = TextEditingController();
  OrderSummeryResponse orderSummery = OrderSummeryResponse(subTotal: "", tax: "", shippingCharge: "", isFreeShipping:false, couponDiscount: "", total: "");

  CartResponse cartResponse=CartResponse(result: false, message: '', carts: [], cartCount: 0, subTotal: '0.0', total: "0.0",couponDiscount: '');
  bool isCartResponseFetch=false;


  fetchCart()async{
    var res = await CartApi.carts();
    if(res.object.result) {
      cartResponse = res.object;
      isCartResponseFetch=true;
      notifyListeners();
    }
  }
   addToCart(variantId,qty,BuildContext context)async{
    var res = await CartApi.addToCart(variantId: variantId, qty: qty);
    if(res.object.result) {
      cartResponse = res.object;
      isCartResponseFetch=true;
      notifyListeners();
    }
      ToastUi.show(context, res.object.message);
  }

   applyCoupon(BuildContext context,code)async{
    var res = await CartApi.couponApply(code:code );
    if(res.object.result) {
      SystemData.couponCode=code;
      cartResponse = res.object;
      isCartResponseFetch=true;
      notifyListeners();
    }
      ToastUi.show(context, res.object.message);
  }

   updateCart({required cartId,required BuildContext context,required String action})async{
    var res = await CartApi.cartUpdate(id: cartId, action: action);
    if(res.object.result) {
      cartResponse = res.object;
      isCartResponseFetch=true;
      ToastUi.show(context, res.object.message);
      notifyListeners();
    }
  }

   getOrderSummery({String logistic_zone_id="0"})async{
    var res = await OrderApi.getSummery(logistic_zone_id: logistic_zone_id);
    orderSummery =res.object;
    notifyListeners();
  }

  clearAll(){
     couponTxtController = TextEditingController();
     orderSummery = OrderSummeryResponse(subTotal: "", tax: "", shippingCharge: "", isFreeShipping:false, couponDiscount: "", total: "");
     cartResponse=CartResponse(result: false, message: '', carts: [], cartCount: 0, subTotal: '0.0', total: "0.0",couponDiscount: '');
     isCartResponseFetch=false;

  }

  init(){

  }

}