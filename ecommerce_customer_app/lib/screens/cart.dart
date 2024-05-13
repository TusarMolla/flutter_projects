import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:grostore/app_lang.dart';
import 'package:grostore/configs/style_config.dart';
import 'package:grostore/configs/theme_config.dart';
import 'package:grostore/custom_ui/BoxDecorations.dart';
import 'package:grostore/custom_ui/Button.dart';
import 'package:grostore/custom_ui/Image_view.dart';
import 'package:grostore/custom_ui/common_appbar.dart';
import 'package:grostore/helpers/device_info_helper.dart';
import 'package:grostore/helpers/route.dart';
import 'package:grostore/presenters/cart_presenter.dart';
import 'package:grostore/screens/check_out.dart';
import 'package:provider/provider.dart';

import '../helpers/common_functions.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeConfig.xxlightGrey,
      appBar: CommonAppbar.show(
          title: AppLang.local(context).cart, context: context),
      body: Container(
        height: getHeight(context),
        width: getWidth(context),
        child: Stack(
          children: [
            Container(
              child: Consumer<CartPresenter>(
                builder: (context, data, child) {
                  if(data.isCartResponseFetch && data.cartResponse.carts.isNotEmpty) {
                    return ListView.separated(
                      padding: EdgeInsets.only(top: 16, bottom: 200),
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.only(
                              left: StyleConfig.padding,
                              right: StyleConfig.padding,
                              bottom:
                                  index == data.cartResponse.carts.length - 1
                                      ? 80
                                      : 0),
                          decoration: BoxDecorations.shadow(),
                          width: getWidth(context),
                          child: Row(
                            children: [
                              Stack(
                                children: [
                                  ImageView(
                                    url: data
                                        .cartResponse.carts[index].thumbnailImage,
                                    width: 120,
                                    height: 100,
                                  ),
                                  /*Positioned(
                                    top: 10,
                                    left: 10,
                                    child: Button(
                                      shape: StyleConfig.buttonRadius(8),
                                      color: ThemeConfig.xlightGrey,
                                      padding: EdgeInsets.all(4),
                                      minWidth: 24,
                                      onPressed: () {
                                        data.updateCart(
                                            cartId: data.cartResponse.carts[index].id,
                                            action: "delete",
                                            context: context);
                                      },
                                      child: Image.asset(
                                        getAssetIcon('delete.png'),
                                        height: 24,
                                        width: 24,
                                        color: ThemeConfig.darkGrey,
                                      ),
                                    ),
                                  ),*/
                                ],
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Container(
                                width: getWidth(context) * 0.4,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      data.cartResponse.carts[index].category,
                                      style: StyleConfig.fs10,
                                      maxLines: 1,
                                    ),
                                    Text(
                                      data.cartResponse.carts[index].name,
                                      style: StyleConfig.fs14fwBold,
                                      maxLines: 1,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          data.cartResponse.carts[index].unit,
                                          style: StyleConfig.fs12,
                                          maxLines: 1,
                                        ),
                                        Text(
                                          ", ",
                                          style: StyleConfig.fs12,
                                          maxLines: 1,
                                        ),
                                        Text(
                                          showPrice(data.cartResponse.carts[index].price),
                                          style: StyleConfig.fs12,
                                          maxLines: 1,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              quantitySection(context, data, index),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        print(index);
                        return Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: StyleConfig.padding),
                          child: Divider(
                            height: 1,
                            color: ThemeConfig.grey,
                          ),
                        );
                      },
                      itemCount: data.cartResponse.carts.length);
                  } else {
                    return Center(child: Text(AppLang.local(context).empty,style: StyleConfig.fs16fwBold,));
                  }
                },
              ),
            ),
            Consumer<CartPresenter>(builder: (context, data, child) {
              return data.cartResponse.carts.isNotEmpty
                  ? Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Column(
                        children: [
                          Container(
                            height: 60,
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            margin: EdgeInsets.symmetric(
                                horizontal: StyleConfig.padding, vertical: 14),
                            decoration: BoxDecorations.customRadius(
                                radius: BorderRadius.circular(8)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: getWidth(context) * 0.6,
                                  child: TextField(
                                    controller: data.couponTxtController,
                                    decoration: InputDecoration.collapsed(
                                        hintText: AppLang.local(context)
                                            .promo_code_ucf),
                                  ),
                                ),
                                Button(
                                  minWidth: 40,
                                  shape: StyleConfig.buttonRadius(8),
                                  color: ThemeConfig.amber,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  onPressed: () {
                                    data.applyCoupon(context,
                                        data.couponTxtController.text.trim());
                                  },
                                  child: Text(
                                    AppLang.local(context).apply,
                                    style: StyleConfig.fs16cWhitefwBold,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            height: 200,
                            width: 400,
                            decoration: BoxDecorations.customRadius(
                                    radius: BorderRadius.only(
                                        topLeft: Radius.circular(24),
                                        topRight: Radius.circular(24)))
                                .copyWith(color: ThemeConfig.white),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 16,
                                ),
                                Text(
                                  AppLang.local(context).order_info_ucf,
                                  style: StyleConfig.fs16fwBold,
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: StyleConfig.padding,
                                      vertical: 5),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "${AppLang.local(context).subtotal}:",
                                        style: StyleConfig.fs14fwNormal,
                                      ),
                                      Text(
                                        "${showPrice(data.cartResponse.subTotal)}",
                                        style: StyleConfig.fs14fwNormal,
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: StyleConfig.padding,
                                      vertical: 5),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "${AppLang.local(context).coupon_discount_ucf}:",
                                        style: StyleConfig.fs14fwNormal,
                                      ),
                                      Text(
                                        "${showPrice(data.cartResponse.couponDiscount)}",
                                        style: StyleConfig.fs14fwNormal,
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: StyleConfig.padding,
                                      vertical: 5),
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
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: StyleConfig.padding,
                                      vertical: 5),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "${AppLang.local(context).total}:",
                                        style: StyleConfig.fs14fwNormal,
                                      ),
                                      Text(
                                        "${showPrice(data.cartResponse.total)}",
                                        style: StyleConfig.fs14fwNormal,
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: StyleConfig.padding,
                                      vertical: 10),
                                  child: Button(
                                    shape: StyleConfig.buttonRadius(4),
                                    color: ThemeConfig.accentColor,
                                    onPressed: () {
                                      MakeRoute.go(context, CheckOut());
                                    },
                                    padding: EdgeInsets.symmetric(vertical: 16),
                                    minWidth: getWidth(context),
                                    child: Text(
                                      AppLang.local(context)
                                          .review_n_payment_ucf,
                                      style: StyleConfig.fs16cWhitefwBold,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ))
                  : const SizedBox.shrink();
            })
          ],
        ),
      ),
    );
  }

  Container quantitySection(BuildContext context, CartPresenter data, index) {
    return Container(
      // padding: EdgeInsets.symmetric(horizontal: StyleConfig.padding),
      //height: 50,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Button(
            minWidth: 20,
            shape: CircleBorder(),
            color: ThemeConfig.fontColor,
            padding: EdgeInsets.all(8),
            onPressed: () {
              data.updateCart(
                  cartId: data.cartResponse.carts[index].id,
                  action: "decrease",
                  context: context);
            },
            child: Icon(
              Icons.remove,
              color: ThemeConfig.white,
              size: 10,
            ),
          ),
          Container(
              padding: EdgeInsets.symmetric(horizontal: 2),
              constraints: BoxConstraints(minWidth: 40),
              alignment: Alignment.center,
              child: Text(
                "${data.cartResponse.carts[index].quantity}",
                style: StyleConfig.fs14fwBold,
              )),
          Button(
            minWidth: 20,
            shape: CircleBorder(),
            color: ThemeConfig.accentColor,
            padding: EdgeInsets.all(8),
            onPressed: () {
              data.updateCart(
                  cartId: data.cartResponse.carts[index].id,
                  action: "increase",
                  context: context);
            },
            child: Icon(
              Icons.add,
              color: ThemeConfig.white,
              size: 10,
            ),
          ),
        ],
      ),
    );
  }
}
