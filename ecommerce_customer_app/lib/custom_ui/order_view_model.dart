import 'package:flutter/material.dart';
import 'package:grostore/configs/style_config.dart';
import 'package:grostore/custom_ui/BoxDecorations.dart';
import 'package:grostore/custom_ui/Button.dart';
import 'package:grostore/custom_ui/Image_view.dart';
import 'package:grostore/helpers/device_info_helper.dart';
import 'package:grostore/helpers/route.dart';
import 'package:grostore/models/order/orders_response.dart';
import 'package:grostore/screens/order/order_details.dart';


class OrderViewModel extends StatelessWidget {
   OrderViewModel({Key? key ,required this.orderInfo,required this.context}) : super(key: key);
  OrderInfo orderInfo;
  BuildContext context;

  @override
  Widget build(BuildContext context) {
    return  Container(
      width: getWidth(this.context),
      height: 100,
      padding: EdgeInsets.symmetric(horizontal: StyleConfig.padding),
      decoration: BoxDecorations.shadow(radius: 2),
      child: Button(
        onPressed: (){
          MakeRoute.go(this.context, OrderDetails(code: orderInfo.id,));
        },
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: ImageView(
                url:orderInfo.item.product?.thumbnailImage??"",
                width: getWidth(this.context)*0.2,
                height: 100,
              ),
            ),
            Expanded(
              flex:3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                      width: getWidth(this.context)*0.50,
                      child: Text(orderInfo.item.product?.categories.first.name??"",style: StyleConfig.fs14fwNormal,)),
                  SizedBox(
                    width: getWidth(this.context)*0.50,
                      child: Text(orderInfo.item.product?.name??"",style: StyleConfig.fs14fwBold,)),
                  SizedBox(
                    width: getWidth(this.context)*0.50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(orderInfo.status.replaceAll("_", " "),style: StyleConfig.fs12,maxLines: 1,),
                        Flexible(
                          flex: 1,
                            child: Text("${orderInfo.date}",style: StyleConfig.fs11,maxLines: 1,textAlign: TextAlign.right,)),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
