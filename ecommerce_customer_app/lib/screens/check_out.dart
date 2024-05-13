import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:grostore/app_lang.dart';
import 'package:grostore/configs/style_config.dart';
import 'package:grostore/configs/theme_config.dart';
import 'package:grostore/custom_ui/BoxDecorations.dart';
import 'package:grostore/custom_ui/Button.dart';
import 'package:grostore/custom_ui/Image_view.dart';
import 'package:grostore/custom_ui/common_appbar.dart';
import 'package:grostore/custom_ui/input_decorations.dart';
import 'package:grostore/custom_ui/loading.dart';
import 'package:grostore/custom_ui/shimmers.dart';
import 'package:grostore/helpers/common_functions.dart';
import 'package:grostore/helpers/device_info_helper.dart';
import 'package:grostore/models/payment_types_response.dart';
import 'package:grostore/models/time_slote_response.dart';
import 'package:grostore/presenters/check_out_presenter.dart';
import 'package:grostore/presenters/user_presenter.dart';
import 'package:grostore/screens/main.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CheckOut extends StatefulWidget {
  const CheckOut({Key? key}) : super(key: key);

  @override
  State<CheckOut> createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
  @override
  void initState() {
    // TODO: implement initState
    Provider.of<CheckOutPresenter>(context, listen: false)
        .init(context);


    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeConfig.xxlightGrey,
      appBar: CommonAppbar.show(
          title: AppLang.local(context).check_out_ucf, context: context),
      body: SingleChildScrollView(
        child: Consumer<CheckOutPresenter>(builder: (context, data, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 24,
              ),
              buildShippingAddress(context, data),
              SizedBox(
                height: 24,
              ),
              buildBillingAddress(context, data),
              SizedBox(
                height: 24,
              ),
              if (data.logistics.isNotEmpty)
                buildLogistic(context, data)
              else
                Container(

                  margin: EdgeInsets.symmetric(horizontal: StyleConfig.padding),
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecorations.shadow(radius: 8).copyWith(color: ThemeConfig.red),
                    child: Text("We are not shipping to your city now. ",style: StyleConfig.fs14cWhitefwNormal,)),
              SizedBox(
                height: 24,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: StyleConfig.padding),
                child: Text(
                  "Preferred Delivery Time",
                  style: StyleConfig.fs16fwBold,
                ),
              ),
              data.isFetchTimeSlot?
              buildDeliveryTime(context, data):timeSlotShimmer()
              ,
              SizedBox(
                height: 24,
              ),
              buildPersonalInfo(context,data),
              SizedBox(
                height: 24,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: StyleConfig.padding),
                child: Text(
                  "Payment Method",
                  style: StyleConfig.fs16fwBold,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 100,
                decoration: BoxDecorations.shadow(radius: 8),
                margin: EdgeInsets.symmetric(horizontal: StyleConfig.padding),
                padding:
                    EdgeInsets.symmetric(horizontal: StyleConfig.padding14),
                child: Button(
                  onPressed: ()async{
                    PaymentTypesResponse? type= await showPaymentMethods(data);
                    if(type!=null){
                      data.onChangePaymentMethod(type);
                    }
                  },
                  alignment: Alignment.centerLeft,
                  minWidth: getWidth(context),
                  child: Row(
                    children: [
                      Container(
                          width: getWidth(context)*0.38,
                          child: Text(data.selectedPaymentMethod?.name??'',style: StyleConfig.fs16fwBold,)),
                      Container(
                        width: getWidth(context)*0.3,
                        padding: EdgeInsets.all(8),
                        child: ImageView.svg(url: data.selectedPaymentMethod?.image??"",height:50,width: 50),
                      )       ,
                      Spacer(),
                      Image.asset(getAssetIcon("next.png"),width: 16,height: 16,),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 24,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: StyleConfig.padding),
                child: Text(
                  "Add Tips For Deliveryman",
                  style: StyleConfig.fs16fwBold,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: StyleConfig.padding),
                padding: EdgeInsets.symmetric(
                    horizontal: StyleConfig.padding, vertical: 10),
                decoration: BoxDecorations.shadow(radius: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Tips",
                      style: StyleConfig.fs14fwBold,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: data.tipsTxt,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecorations.phone(hint_text: "Tips"),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 24,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: StyleConfig.padding),
                child: Text(
                  "Order Summary",
                  style: StyleConfig.fs16fwBold,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: getWidth(context),
                decoration: BoxDecorations.shadow(radius: 8),
                margin: EdgeInsets.symmetric(horizontal: StyleConfig.padding),
                padding: EdgeInsets.symmetric(
                    horizontal: StyleConfig.padding14,
                    vertical: StyleConfig.padding14),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${AppLang.local(context).subtotal} :",
                          style: StyleConfig.fs14fwNormal,
                        ),
                        Text(
                          showPrice(data.orderSummeryResponse.subTotal),
                          style: StyleConfig.fs14fwNormal,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${AppLang.local(context).delivery_fee_ucf} :",
                          style: StyleConfig.fs14fwNormal,
                        ),
                        Text(
                          showPrice(data.orderSummeryResponse.shippingCharge),
                          style: StyleConfig.fs14fwNormal,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${AppLang.local(context).tax} :",
                          style: StyleConfig.fs14fwNormal,
                        ),
                        Text(
                          showPrice(data.orderSummeryResponse.tax),
                          style: StyleConfig.fs14fwNormal,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${AppLang.local(context).coupon_discount_ucf} :",
                          style: StyleConfig.fs14fwNormal,
                        ),
                        Text(
                          showPrice(data.orderSummeryResponse.couponDiscount),
                          style: StyleConfig.fs14fwNormal,
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: DottedLine(
                        direction: Axis.horizontal,
                        lineLength: double.infinity,
                        lineThickness: 1.0,
                        dashLength: 4.0,
                        dashColor: ThemeConfig.grey,
                        //dashGradient: [Colors.red, Colors.blue],
                        dashRadius: 0.0,
                        dashGapLength: 4.0,
                        dashGapColor: Colors.transparent,
                        //dashGapGradient: [Colors.red, Colors.blue],
                        dashGapRadius: 0.0,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${AppLang.local(context).total} :",
                          style: StyleConfig.fs14fwNormal,
                        ),
                        Text(
                          "${showPrice(data.orderSummeryResponse.total)}",
                          style: StyleConfig.fs14fwNormal,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 24,
              ),
              Button(
                minWidth: getWidth(context),
                color: ThemeConfig.accentColor,
                onPressed: (){
                  data.placeOrder(context);
                },
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  "Place Order",
                  style: StyleConfig.fs16cWhitefwBold,
                ),
              )
            ],
          );
        }),
      ),
    );
  }

  Widget timeSlotShimmer(){

    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: StyleConfig.padding,vertical: 5),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            decoration: BoxDecorations.shadow(radius: 8),
            child: Shimmers(
              height: 40,
              width: getWidth(context),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            decoration: BoxDecorations.shadow(radius: 8),
            child: Shimmers(
              height: 40,
              width: getWidth(context),
            ),
          )
        ],
      ),
    );
  }

  Column buildPersonalInfo(BuildContext context,CheckOutPresenter data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: StyleConfig.padding),
          child: Text(
            "Personal Information",
            style: StyleConfig.fs16fwBold,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: StyleConfig.padding),
          padding: EdgeInsets.symmetric(
              horizontal: StyleConfig.padding, vertical: 10),
          decoration: BoxDecorations.shadow(radius: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLang.local(context).phone,
                style: StyleConfig.fs14fwBold,
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller:data.phoneTxt ,
                keyboardType: TextInputType.phone,
                decoration: InputDecorations.phone(hint_text: "Phone"),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                AppLang.local(context).alternative_phone_ucf,
                style: StyleConfig.fs14fwBold,
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: data.additionalPhoneTxt,
                keyboardType: TextInputType.phone,
                decoration: InputDecorations.phone(
                    hint_text: AppLang.local(context).alternative_phone_ucf),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                AppLang.local(context).additional_info_ucf,
                style: StyleConfig.fs14fwBold,
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.all(8),
                constraints: BoxConstraints(minHeight: 80),
                width: getWidth(context),
                decoration: BoxDecorations.basic().copyWith(
                    border: Border.all(color: ThemeConfig.grey, width: 1)),
                child: TextField(
                  controller: data.additionalInfoTxt,
                  decoration: InputDecoration.collapsed(
                      hintText: AppLang.local(context).additional_info_ucf),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Column buildDeliveryTime(BuildContext context, CheckOutPresenter data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        SizedBox(
          height: 10,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: StyleConfig.padding),
          child: Button(
            minWidth: getWidth(context),
            onPressed: () {
              data.onChangeDeliveryType("regular");
            },
            child:Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    decoration: BoxDecorations.shadow(radius: 8).copyWith(
                        border: data.shipping_delivery_type == "regular"
                            ? Border.all(
                                color: ThemeConfig.accentColor, width: 2)
                            : null),
                    child: Row(
                      children: [
                        Icon(
                          Icons.local_shipping_outlined,
                          size: 54,
                          color: ThemeConfig.grey,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Regular Delivery",
                              style: StyleConfig.fs14fwNormal,
                            ),
                            Text(
                              "We will deliver your products soon.",
                              style: StyleConfig.fs14fwNormal,
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                 ,
          ),
        ),
        Button(
          minWidth: getWidth(context),
          onPressed: () {
            data.onChangeDeliveryType("scheduled");
          },
          child: Container(
            margin: EdgeInsets.symmetric(
                horizontal: StyleConfig.padding, vertical: 10),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            decoration: BoxDecorations.shadow(radius: 8).copyWith(
                border: data.shipping_delivery_type == "scheduled"
                    ? Border.all(color: ThemeConfig.accentColor, width: 2)
                    : null),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: getWidth(context) * 0.35,
                  child: Button(
                    minWidth: getWidth(context) * 0.35,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "${DateFormat(
                        "d MMM",
                      ).format(data.selectedDate!)}",
                      style: StyleConfig.fs14fwNormal,
                    ),
                    onPressed: () async {
                      var date = await chooseDate(data);
                      if (date != null) {
                        data.onChangeDate(date);
                        data.onChangeDeliveryType("scheduled");
                      }
                    },
                  ),
                ),
                SizedBox(
                  width: getWidth(context) * 0.35,
                  child: Button(
                    minWidth: getWidth(context),
                    child: SizedBox(
                      width: getWidth(context) * 0.35,
                      child: buildTimeDropDown(data),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  chooseDate(CheckOutPresenter data) async {
    return await showDatePicker(
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      context: context,
      lastDate: data.lastDate,
      firstDate: data.firstDate,
      initialDate: data.selectedDate!,
    );
  }

  Column buildShippingAddress(BuildContext context, CheckOutPresenter data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: StyleConfig.padding),
          child: Text(
            AppLang.local(context).delivery_address_ucf,
            style: StyleConfig.fs16fwBold,
          ),
        ),
        SizedBox(
          //color: Colors.red,
          height: 150,
          width: getWidth(context),
          child: data.isFetchDeliveryAddress?ListView.separated(
            itemCount: data.addresses.length,
            padding: EdgeInsets.symmetric(
                horizontal: StyleConfig.padding, vertical: 10),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecorations.shadow(radius: 8).copyWith(
                    border: Border.all(
                        width: 2,
                        color:
                            data.selectedShippingAddress.id == data.addresses[index].id
                                ? ThemeConfig.accentColor
                                : ThemeConfig.grey)),
                child: Button(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  shape: StyleConfig.buttonRadius(8),
                  minWidth: getWidth(context) * 0.5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data.addresses[index].countryName,
                        style: StyleConfig.fs14fwNormal,
                      ),
                      Text(
                        data.addresses[index].stateName,
                        style: StyleConfig.fs14fwNormal,
                      ),
                      Text(
                        data.addresses[index].cityName,
                        style: StyleConfig.fs14fwNormal,
                      ),
                      Text(
                        data.addresses[index].address,
                        style: StyleConfig.fs14fwNormal,
                        maxLines: 1,
                      ),
                    ],
                  ),
                  onPressed: () {
                    data.onChangeShippingAddress(data.addresses[index]);
                  },
                ),
              );
            },
            separatorBuilder: (context, index) {
              return SizedBox(
                width: 10,
              );
            },
          ):Shimmers.horizontalList(10,  getWidth(context) * 0.5, 100),
        )
      ],
    );
  }

  Column buildBillingAddress(BuildContext context, CheckOutPresenter data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: StyleConfig.padding),
          child: Text(
            AppLang.local(context).billing_address_ucf,
            style: StyleConfig.fs16fwBold,
          ),
        ),
        SizedBox(
          //color: Colors.red,
          height: 150,
          width: getWidth(context),
          child: data.isFetchDeliveryAddress?ListView.separated(
            itemCount: data.addresses.length,
            padding: EdgeInsets.symmetric(
                horizontal: StyleConfig.padding, vertical: 10),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecorations.shadow(radius: 8).copyWith(
                    border: Border.all(
                        width: 2,
                        color: data.billingAddressId == data.addresses[index].id
                            ? ThemeConfig.accentColor
                            : ThemeConfig.grey)),
                child: Button(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  shape: StyleConfig.buttonRadius(8),
                  minWidth: getWidth(context) * 0.5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        data.addresses[index].countryName,
                        style: StyleConfig.fs14fwNormal,
                      ),
                      Text(
                        data.addresses[index].stateName,
                        style: StyleConfig.fs14fwNormal,
                      ),
                      Text(
                        data.addresses[index].cityName,
                        style: StyleConfig.fs14fwNormal,
                      ),
                      Text(
                        data.addresses[index].address,
                        style: StyleConfig.fs14fwNormal,
                      ),
                    ],
                  ),
                  onPressed: () {
                    data.onChangeBillingAddress(data.addresses[index].id);
                  },
                ),
              );
            },
            separatorBuilder: (context, index) {
              return SizedBox(
                width: 10,
              );
            },
          ):Shimmers.horizontalList(10,  getWidth(context) * 0.5, 100),
        ),
      ],
    );
  }

  Column buildLogistic(BuildContext context, CheckOutPresenter data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: StyleConfig.padding),
          child: Text(
            AppLang.local(context).available_logistics_ucf,
            style: StyleConfig.fs16fwBold,
          ),
        ),
        SizedBox(
          //color: Colors.red,
          height: 150,
          width: getWidth(context),
          child:ListView.separated(
            itemCount: data.logistics.length,
            padding: EdgeInsets.symmetric(
                horizontal: StyleConfig.padding, vertical: 10),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecorations.shadow(radius: 8).copyWith(
                    border: Border.all(
                        width: 2,
                        color:
                            data.selectedLogistic.id == data.logistics[index].id
                                ? ThemeConfig.accentColor
                                : ThemeConfig.grey)),
                child: Button(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  shape: StyleConfig.buttonRadius(8),
                  minWidth: getWidth(context) * 0.5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        data.logistics[index].name,
                        style: StyleConfig.fs14fwNormal,
                      ),
                      ImageView(
                        url: data.logistics[index].image,
                        height: 40,
                        width: getWidth(context) * 0.4,
                      ),
                      Text(
                        showPrice(data.logistics[index].price),
                        style: StyleConfig.fs12,
                      ),
                    ],
                  ),
                  onPressed: () {
                    data.onChangeLogistic(data.logistics[index]);
                  },
                ),
              );
            },
            separatorBuilder: (context, index) {
              return SizedBox(
                width: 10,
              );
            },
          ),
        ),
      ],
    );
  }

  Widget buildTimeDropDown(CheckOutPresenter data) {
    return DropdownButton<TimeSlot>(
      menuMaxHeight: 300,
      isDense: true,
      underline: Container(),
      isExpanded: true,
      onChanged: (TimeSlot? value) {
        data.onChangeTimeSlot(value!);
      },
      icon: const Icon(Icons.arrow_drop_down),
      value: data.selectedTimeslot,
      items: data.timeSlots
          .map(
            (value) => DropdownMenuItem<TimeSlot>(
              value: value,
              child: Text(
                value.timeline,
              ),
            ),
          )
          .toList(),
    );
  }

 Future<PaymentTypesResponse?> showPaymentMethods(CheckOutPresenter data)async{
   return showDialog<PaymentTypesResponse>(context: context, builder: (context){
      return AlertDialog(
        titlePadding: EdgeInsets.zero,
        title: Container(
          alignment: Alignment.center,
          color: ThemeConfig.accentColor,
          padding: EdgeInsets.symmetric(horizontal: 14,vertical: 24),
          child: Text("Choose Payment Method",style: StyleConfig.fs16cWhitefwBold,),
        ),

        content:Column(
          children: List.generate(data.paymentTypes.length, (index) {
            return Column(
              children: [
                Button(
                  minWidth: getWidth(context),
                    onPressed: (){
                      Navigator.pop(context,data.paymentTypes[index]);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            width: getWidth(context)*0.3,
                            child: Text(data.paymentTypes[index].name,style: StyleConfig.fs14fwBold,)),
                        Container(
                          width: getWidth(context)*0.3,
                          padding: EdgeInsets.all(8),
                          child: ImageView.svg(url: data.paymentTypes[index].image,height:50,width: 50),
                        ),
                      ],
                    ))
              ],
            );
          }),
        ) ,
        actions: [
          Button(
            minWidth:getWidth(context),
            padding: EdgeInsets.symmetric(vertical: 20),
            color: ThemeConfig.red,
            onPressed: (){
            Navigator.pop(context);
            },
            child: Text("Close",style: StyleConfig.fs14cWhitefwNormal,),

          )
        ],
      );

    });
  }

}
