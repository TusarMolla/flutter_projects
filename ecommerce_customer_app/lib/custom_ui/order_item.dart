import 'package:flutter/material.dart';
import 'package:grostore/app_lang.dart';
import 'package:grostore/configs/style_config.dart';
import 'package:grostore/configs/theme_config.dart';
import 'package:grostore/custom_ui/BoxDecorations.dart';
import 'package:grostore/custom_ui/Button.dart';
import 'package:grostore/custom_ui/Image_view.dart';
import 'package:grostore/helpers/common_functions.dart';
import 'package:grostore/helpers/device_info_helper.dart';
import 'package:grostore/models/order/order_details_response.dart';
import 'package:grostore/presenters/refund_presenter.dart';
import 'package:provider/provider.dart';

class OrderItem extends StatelessWidget {
  Item item;
  RefundResult? onReq;
  BuildContext context;

  OrderItem({super.key, required this.item, required this.context,this.onReq});

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      //width: (getWidth(context)*0.5)-24,
      height: 160,
      decoration: BoxDecorations.shadow(radius: 8),
      //padding: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              width: 160,
              // height: 50,
              // padding: EdgeInsets.only(top: 10),
              alignment: Alignment.center,
              child: ImageView(
                url: item.product?.thumbnailImage ?? "",
                width: 134,
                height: 92,
              )),
          Padding(
            padding: const EdgeInsets.only(left: 12.0, top: 12),
            child: Text(
              item.product?.categories.first.name ?? "",
              style: StyleConfig.fs10,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12.0, top: 4),
            child: Text(
              item.product?.name ?? "",
              style: StyleConfig.fs14fwBold,
              maxLines: 1,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12.0, top: 8),
            child: Text(
              "${item.qty} x ${showPrice(item.product?.price ?? '')}",
              style: StyleConfig.fs14cRedfwBold,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12.0, top: 8),
            child: Text(
              showPrice(item.totalPrice ?? ""),
              style: StyleConfig.fs14cRedfwBold,
            ),
          ),
          if(item.refund_status!="off")
          Container(
            margin: EdgeInsets.only(top: 5),
            alignment: Alignment.center,
            child: Button(
              onPressed:  item.refund_status == "request"
                  ? (){
                refundDialog();
              }:null,
                shape: StyleConfig.buttonRadius(5),
                padding: EdgeInsets.symmetric(horizontal: 10),
                color: item.refund_status == "request"
                    ? ThemeConfig.accentColor
                    : null,
                child: Text(
                  "Refund ${item.refund_status.toString()}".toUpperCase(),
                  style: item.refund_status == "request"
                      ? StyleConfig.fs12cWhite
                      : StyleConfig.fs12,
                )),
          )
        ],
      ),
    );
  }

  refundDialog() {
  return  showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Refund Reason"),
              content: Container(
                padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                decoration: BoxDecorations.basic().copyWith(border: Border.all(color: ThemeConfig.grey)),
                height: 100,
                width: getWidth(context) * 0.5,
                child: TextField(
                  controller: controller,
                  decoration: InputDecoration.collapsed(hintText: "reason"),
                ),
              ),
              actions: [
                Button(
                  color: ThemeConfig.accentColor,
                    onPressed:() {
                    Navigator.pop(context);
                            Provider.of<RefundPresenter>(context, listen: false)
                                .refundReq(this.context,item.id,controller.text.trim()).then((value) => onReq != null?onReq!(value):null);
                          },
                    child: Text(AppLang.local(context).submit,style: StyleConfig.fs12cWhite,))
              ],
            ));
  }
}
typedef RefundResult =  Function(bool value);




