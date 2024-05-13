import 'package:flutter/material.dart';
import 'package:grostore/apis/order_api.dart';
import 'package:grostore/apis/user_api.dart';
import 'package:grostore/custom_classes/system_data.dart';
import 'package:grostore/custom_ui/loading.dart';
import 'package:grostore/custom_ui/toast_ui.dart';
import 'package:grostore/helpers/route.dart';
import 'package:grostore/models/logistics_response.dart';
import 'package:grostore/models/order/order_summery_response.dart';
import 'package:grostore/models/payment_types_response.dart';
import 'package:grostore/models/time_slote_response.dart';
import 'package:grostore/models/user/addresses_response.dart';
import 'package:grostore/screens/order/orders.dart';
import 'package:grostore/screens/payment.dart';

class CheckOutPresenter extends ChangeNotifier {
  static BuildContext? context;

  setContext(BuildContext context) {
    CheckOutPresenter.context = context;
  }

  TextEditingController phoneTxt=TextEditingController(text: SystemData.userInfo.phone);
  TextEditingController additionalPhoneTxt=TextEditingController();
  TextEditingController additionalInfoTxt=TextEditingController();
  TextEditingController tipsTxt=TextEditingController(text: "0");

  int billingAddressId = 0;
  AddressInfo selectedShippingAddress = AddressInfo(
      id: 0,
      userId: 0,
      countryId: 0,
      countryName: "",
      stateId: 0,
      stateName: "",
      cityId: 0,
      cityName: "",
      address: "",
      isDefault: 0);
  List<AddressInfo> addresses = [];
  List<LogisticInfo> logistics = [];
  List<PaymentTypesResponse> paymentTypes = [];
  LogisticInfo selectedLogistic =
      LogisticInfo(id: 0, name: "", logisticId: 0, price: "", image: "");
  PaymentTypesResponse? selectedPaymentMethod;
  List<TimeSlot> timeSlots = [];
  TimeSlot? selectedTimeslot;
 // bool isFetchLogistic= false;
  bool isFetchDeliveryAddress= false;
  bool isFetchBillingAddress= false;
  bool isFetchTimeSlot= false;

  OrderSummeryResponse orderSummeryResponse = OrderSummeryResponse(
      subTotal: "",
      tax: "",
      shippingCharge: "",
      isFreeShipping: false,
      couponDiscount: "",
      total: "");

  var firstDate;
  var lastDate;
  DateTime? selectedDate;
  String shipping_delivery_type = "regular";

  fetchAddresses(BuildContext context) async {
    var res = await UserApi.getAddresses();
    addresses.clear();
    addresses.addAll(res.data);
    if(addresses.isNotEmpty) {
      onChangeShippingAddress(addresses.first);
      billingAddressId = addresses.first.id;
    }
    isFetchDeliveryAddress = true;
    notifyListeners();
  }

  fetchOrderSummery(id) async {
    var res = await OrderApi.getSummery(logistic_zone_id: id);
    orderSummeryResponse = res.object;
    notifyListeners();
  }

  fetchLogistic(cityId) async {
    var res = await OrderApi.getLogistics(cityId: cityId);
    logistics.clear();
    logistics.addAll(res.object.data);
    if(logistics.isNotEmpty) {
      onChangeLogistic(logistics.first);
    }
    notifyListeners();
  }

  fetchPaymentTypes() async {
    var res = await OrderApi.getPaymentTypes();
    paymentTypes.clear();
    paymentTypes.addAll(res.object);
    onChangePaymentMethod(paymentTypes.first);
    notifyListeners();
  }

  fetchTimeSlots() async {
    firstDate = DateTime.now();

    var res = await OrderApi.getTimeSlot();
    timeSlots.clear();
    lastDate =
        DateTime.now().add(Duration(days: int.parse(res.object.days.toString())));
    timeSlots.addAll(res.object.timeSlots);
    selectedTimeslot = timeSlots.first;
    selectedDate = firstDate;
    isFetchTimeSlot=true;
    notifyListeners();
  }

  onChangeBillingAddress(id) {
    billingAddressId = id;
    notifyListeners();
  }

  onChangeShippingAddress(AddressInfo info) {
    selectedShippingAddress = info;
    fetchLogistic(selectedShippingAddress.cityId);
    notifyListeners();
  }

  onChangeLogistic(LogisticInfo info) {
    selectedLogistic = info;
    fetchOrderSummery(info.logisticId);
    notifyListeners();
  }

  onChangeTimeSlot(TimeSlot timeSlot) {
    selectedTimeslot = timeSlot;
    notifyListeners();
  }

  onChangeDate(date) {
    selectedDate = date;
    notifyListeners();
  }

  onChangeDeliveryType(type) {
    shipping_delivery_type = type;
    notifyListeners();
  }

  onChangePaymentMethod(PaymentTypesResponse method) {
    selectedPaymentMethod = method;
    notifyListeners();
  }

  clearAll(){
     billingAddressId = 0;
     selectedShippingAddress = AddressInfo(
        id: 0,
        userId: 0,
        countryId: 0,
        countryName: "",
        stateId: 0,
        stateName: "",
        cityId: 0,
        cityName: "",
        address: "",
        isDefault: 0);
    addresses = [];
     logistics = [];
     paymentTypes = [];
     selectedLogistic =
    LogisticInfo(id: 0, name: "", logisticId: 0, price: "", image: "");
    timeSlots = [];
     selectedTimeslot=null;
    // bool isFetchLogistic= false;
     isFetchDeliveryAddress= false;
     isFetchBillingAddress= false;
     isFetchTimeSlot= false;

     orderSummeryResponse = OrderSummeryResponse(
        subTotal: "",
        tax: "",
        shippingCharge: "",
        isFreeShipping: false,
        couponDiscount: "",
        total: "");

     firstDate=null;
     lastDate=null;
     selectedDate=null;
     tipsTxt.text="";
     shipping_delivery_type = "regular";
  }

  init(context){
    fetchAddresses(context);
    fetchTimeSlots();
    fetchPaymentTypes();
  }


  _store(BuildContext context)async{
    Loading.show(context);
    var response = await OrderApi.createOrder(shippingId: selectedShippingAddress.id, billingId: billingAddressId, phone: phoneTxt.text.trim(), alternativePhone: additionalPhoneTxt.text.trim(), logisticZoneId: selectedLogistic.logisticId, tips: tipsTxt.text.trim(), shippingDeliveryType: shipping_delivery_type, timeslot: selectedTimeslot!.id, scheduledData: selectedDate!.microsecond);
    Loading.close();
    if(response.object.result) {
      SystemData.couponCode="";
      MakeRoute.go(
          context,
          Payment(
              code: response.object.orderCode,
              title: selectedPaymentMethod?.name ?? "",
              payment_method: selectedPaymentMethod?.key ?? ""));
    }
    ToastUi.show(context, response.object.message);
  }
  _byCOD(BuildContext context)async{
    Loading.show(context);
    var response = await OrderApi.createOrderByCOD(shippingId: selectedShippingAddress.id, billingId: billingAddressId, phone: phoneTxt.text.trim(), alternativePhone: additionalPhoneTxt.text.trim(), logisticZoneId: selectedLogistic.logisticId, tips: tipsTxt.text.trim(), shippingDeliveryType: shipping_delivery_type, timeslot: selectedTimeslot!.id, scheduledData: selectedDate!.microsecond);
    Loading.close();
    if(response.object.result){
      SystemData.couponCode="";
    MakeRoute.go(context, Orders(fromBottomBar: false,fromCheckOut: true,));
    }
    ToastUi.show(context, response.object.message);
  }
  _byWallet(BuildContext context)async{
    Loading.show(context);
    var response = await OrderApi.createOrderByCOD(shippingId: selectedShippingAddress.id, billingId: billingAddressId, phone: phoneTxt.text.trim(), alternativePhone: additionalPhoneTxt.text.trim(), logisticZoneId: selectedLogistic.logisticId, tips: tipsTxt.text.trim(), shippingDeliveryType: shipping_delivery_type, timeslot: selectedTimeslot!.id, scheduledData: selectedDate!.microsecond);
    Loading.close();
    if(response.object.result){
      SystemData.couponCode="";
    MakeRoute.go(context, Orders(fromBottomBar: false,fromCheckOut: true,));
    }
    ToastUi.show(context, response.object.message);
  }



  placeOrder(BuildContext context)async{
    if(selectedLogistic.id==0){
      ToastUi.show(context, "Logistic not founded!");
      return;
    }

    if(selectedPaymentMethod!.key=="cod"){
      _byCOD(context);
      return;
    }
    if(selectedPaymentMethod!.key=="wallet"){
      _byWallet(context);
      return;
    }
    if(selectedPaymentMethod!.key=="paypal"||selectedPaymentMethod!.key=="stripe"||selectedPaymentMethod!.key=="paytm"||selectedPaymentMethod!.key=="razorpay"||selectedPaymentMethod!.key=="iyzico"){
      _store(context);
      return;
    }
    ToastUi.show(context, "Not implemented Payment Method");
  }

}
