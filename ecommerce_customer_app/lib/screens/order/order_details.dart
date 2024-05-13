import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:grostore/app_lang.dart';
import 'package:grostore/configs/style_config.dart';
import 'package:grostore/configs/theme_config.dart';
import 'package:grostore/custom_ui/BoxDecorations.dart';
import 'package:grostore/custom_ui/common_appbar.dart';
import 'package:grostore/custom_ui/order_item.dart';
import 'package:grostore/helpers/device_info_helper.dart';
import 'package:grostore/presenters/order_details_presenter.dart';

import '../../helpers/common_functions.dart';

class OrderDetails extends StatefulWidget {
  final code;

  const OrderDetails({super.key, this.code});

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  OrderDetailsPresenter orderDetailsPresenter = OrderDetailsPresenter();

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      orderDetailsPresenter.initState(widget.code);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: ThemeConfig.xxlightGrey,
      appBar: CommonAppbar.show(
          title: AppLang.local(context).order_details, context: context),
      body: ListenableBuilder(
          listenable: orderDetailsPresenter,
          builder: (context, child) {
            return RefreshIndicator(
              onRefresh: (){return orderDetailsPresenter.onRefresh(widget.code);},
              child: SingleChildScrollView(
                child:orderDetailsPresenter.isInitDetails? Container(
                  padding: EdgeInsets.symmetric(horizontal: StyleConfig.padding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 24,
                      ),
                      Container(
                        width: getWidth(context),
                        decoration: BoxDecorations.shadow(radius: 8),
                        padding:const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Order Id: ${orderDetailsPresenter.orderInfo?.code ?? ''}",
                              style: StyleConfig.fs14fwBold,
                            ),
                            SizedBox(
                              height: 14,
                            ),
                            Text(
                              "Ordered at: ${orderDetailsPresenter.orderInfo?.date ?? ''}",
                              style: StyleConfig.fs14fwBold,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 14,
                      ),
                      Text(
                        "Billing Address",
                        style: StyleConfig.fs14fwBold,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Container(
                          padding:const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                          decoration: BoxDecorations.shadow(radius: 8),
                          child: buildBillingAddress(context)),
                      SizedBox(
                        height: 14,
                      ),
                      Text(
                        "Shipping Address",
                        style: StyleConfig.fs14fwBold,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Container(
                          decoration: BoxDecorations.shadow(radius: 8),
                          padding:const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                          child: buildShippingAddress(context)),
                      SizedBox(
                        height: 14,
                      ),
                      Text(
                        "Products",
                        style: StyleConfig.fs14fwBold,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Container(
                        //decoration: BoxDecorations.shadow(radius: 8),
                        padding:const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                        child: Column(
                          children: [
                            /*Row(

                              children: [
                                Container(
                                    width: getWidth(context)*0.35,
                                    child: Text("Product Name")),
                                Container(
                                    width: getWidth(context)*0.18,
                                    child: Text("Unit Price")),
                                Container(
                                    width: getWidth(context)*0.1,
                                    child: Text("QTY")),
                                Container(
                                    width: getWidth(context)*0.18,
                                    child: Text("Total Price")),
                              ],
                            ),
                            Divider(color: ThemeConfig.fontColor,),*/
                            GridView.builder(
                                //padding: EdgeInsets.only(left: StyleConfig.padding,right: StyleConfig.padding,bottom: 20),
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 16,
                                    mainAxisSpacing: 8,
                                    childAspectRatio: 0.62
                                ),
                                itemBuilder: (context, index) =>
                                    OrderItem(
                                      context: context,
                                        onReq: (value){
                                        if(value){
                                          orderDetailsPresenter.onRefresh(widget.code);
                                        }
                                        },
                                        item: orderDetailsPresenter.orderInfo!.items[index],
                                    )
                                    /*Container(
                                  child: Row(

                                    children: [
                                      Container(
                                        width: getWidth(context)*0.35,
                                          child: Text(orderDetailsPresenter.orderInfo?.items[index].product?.name??"")),
                                      Container(
                                        width: getWidth(context)*0.18,
                                          child: Text(showPrice(orderDetailsPresenter.orderInfo?.items[index].unitPrice??""))),
                                      Container(
                                          width: getWidth(context)*0.1,
                                          child: Text("${orderDetailsPresenter.orderInfo?.items[index].qty??''}")),
                                      Container(
                                          width: getWidth(context)*0.18,
                                          child: Text(showPrice(orderDetailsPresenter.orderInfo?.items[index].totalPrice??""))),
                                    ],
                                  ),
                                ),
                                ,
                                separatorBuilder: (context, index) => Column(
                                  children: [
                                    SizedBox(
                                          height: 15,
                                        ),
                                    Divider(color: ThemeConfig.fontColor,),
                                  ],
                                )*/,
                                itemCount:
                                    orderDetailsPresenter.orderInfo?.items.length ?? 0),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Payment Method",
                            style: StyleConfig.fs14fwBold,
                          ),
                          Text(
                            orderDetailsPresenter.orderInfo?.payment_method.toUpperCase()??"",
                            style: StyleConfig.fs14fwNormal,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Sub Total",
                            style: StyleConfig.fs14fwBold,
                          ),
                          Text(
                            showPrice(orderDetailsPresenter.orderInfo?.subTotalAmount??""),
                            style: StyleConfig.fs14fwNormal,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Tips",
                            style: StyleConfig.fs14fwBold,
                          ),
                          Text(
                            showPrice(orderDetailsPresenter.orderInfo?.totalTips??""),
                            style: StyleConfig.fs14fwNormal,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Shipping Cost",
                            style: StyleConfig.fs14fwBold,
                          ),

                          Text(
                            showPrice(orderDetailsPresenter.orderInfo?.totalShippingCost ?? ""),
                            style: StyleConfig.fs14fwNormal,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Coupon Discount",
                            style: StyleConfig.fs14fwBold,
                          ),

                          Text(
                            showPrice(orderDetailsPresenter.orderInfo?.couponDiscountAmount ?? ""),
                            style: StyleConfig.fs14fwNormal,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      DottedLine(),
                      const SizedBox(
                        height: 14,
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Total Price",
                            style: StyleConfig.fs14fwBold,
                          ),
                          Text(
                            showPrice(orderDetailsPresenter.orderInfo?.totalPrice ?? ""),
                            style: StyleConfig.fs14fwBold.copyWith(color: ThemeConfig.accentColor),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                    ],
                  ),
                ):SizedBox(
                  height: getHeight(context),
                    child: Center(child: CircularProgressIndicator())),
              ),
            );
          }),
    );
  }

  Column buildBillingAddress(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          orderDetailsPresenter.orderInfo?.billingAddress?.address ?? "",
          style: StyleConfig.fs14fwNormal,
          maxLines: 1,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 5.0),
          child: Row(
            children: [
              Text(
                "${AppLang.local(context).city}: ",
                style: StyleConfig.fs14fwBold,
              ),
              Text(
                orderDetailsPresenter.orderInfo?.billingAddress?.cityName ?? "",
                style: StyleConfig.fs14fwNormal,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 5.0),
          child: Row(
            children: [
              Text(
                "${AppLang.local(context).state}: ",
                style: StyleConfig.fs14fwBold,
              ),
              Text(
                orderDetailsPresenter.orderInfo?.billingAddress?.stateName ?? "",
                style: StyleConfig.fs14fwNormal,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 5.0),
          child: Row(
            children: [
              Text(
                "${AppLang.local(context).country}: ",
                style: StyleConfig.fs14fwBold,
              ),
              Text(
                orderDetailsPresenter.orderInfo?.billingAddress?.countryName ??
                    "",
                style: StyleConfig.fs14fwNormal,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Column buildShippingAddress(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          orderDetailsPresenter.orderInfo?.shippingAddress?.address ?? "",
          style: StyleConfig.fs14fwNormal,
          maxLines: 1,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 5.0),
          child: Row(
            children: [
              Text(
                "${AppLang.local(context).city}: ",
                style: StyleConfig.fs14fwBold,
              ),
              Text(
                orderDetailsPresenter.orderInfo?.shippingAddress?.cityName ?? "",
                style: StyleConfig.fs14fwNormal,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 5.0),
          child: Row(
            children: [
              Text(
                "${AppLang.local(context).state}: ",
                style: StyleConfig.fs14fwBold,
              ),
              Text(
                orderDetailsPresenter.orderInfo?.shippingAddress?.stateName ??
                    "",
                style: StyleConfig.fs14fwNormal,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 5.0),
          child: Row(
            children: [
              Text(
                "${AppLang.local(context).country}: ",
                style: StyleConfig.fs14fwBold,
              ),
              Text(
                orderDetailsPresenter.orderInfo?.shippingAddress?.countryName ??
                    "",
                style: StyleConfig.fs14fwNormal,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
