import 'package:flutter/material.dart';
import 'package:grostore/app_lang.dart';
import 'package:grostore/configs/style_config.dart';
import 'package:grostore/configs/theme_config.dart';
import 'package:grostore/custom_classes/system_data.dart';
import 'package:grostore/custom_ui/BoxDecorations.dart';
import 'package:grostore/custom_ui/Button.dart';
import 'package:grostore/custom_ui/common_appbar.dart';
import 'package:grostore/custom_ui/input_decorations.dart';
import 'package:grostore/helpers/device_info_helper.dart';
import 'package:grostore/presenters/order_presenter.dart';

class TrackOrder extends StatefulWidget {
  const TrackOrder({super.key});

  @override
  State<TrackOrder> createState() => _TrackOrderState();
}

class _TrackOrderState extends State<TrackOrder> {
  OrderPresenter orderPresenter = OrderPresenter();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppbar.show(
          title: AppLang.local(context).track_my_order_ucf, context: context),
      body: ListenableBuilder(
          listenable: orderPresenter,
          builder: (context, child) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: StyleConfig.padding),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecorations.shadow(),
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: ThemeConfig.grey,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(6),
                                bottomLeft: Radius.circular(6),
                              )),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child:
                              Text(SystemData.settings?.orderCodePrefix ?? ""),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          width: getWidth(context) * 0.5,
                          child: TextField(
                              onSubmitted: (text) {
                                orderPresenter.trackOrder(text.trim(), context);
                              },
                              controller: orderPresenter.trackOrderController,
                              decoration: const InputDecoration.collapsed(
                                  hintText: "123456")),
                        ),
                        Spacer(),
                        SizedBox(
                            width: 40,
                            height: 40,
                            child: Button(
                                onPressed: () {
                                  orderPresenter.trackOrder(
                                      orderPresenter.trackOrderController.text
                                          .trim(),
                                      context);
                                },
                                child: Icon(Icons.search))),
                      ],
                    ),
                  ),
                  SizedBox(height: 24,),

                  if(orderPresenter.trackInfo!=null)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(AppLang.local(context).order_tracking,style: StyleConfig.fs16fwBold,),
                      SizedBox(height: 14,),
                      Container(
                        decoration: BoxDecorations.shadow(radius: 5)
                            .copyWith(border: Border.all(color: ThemeConfig.grey)),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 8),
                              child: Row(
                                children: [
                                  SizedBox(
                                      width: getWidth(context) * 0.25,
                                      child: Text(
                                        AppLang.local(context).date,
                                        style: StyleConfig.fs14fwBold,
                                      )),
                                  SizedBox(
                                      width: getWidth(context) * 0.55,
                                      child: Text(
                                        AppLang.local(context).note,
                                        style: StyleConfig.fs14fwBold,
                                      )),
                                ],
                              ),
                            ),
                            Container(
                              width: getWidth(context),
                              height: 1,
                              color: ThemeConfig.grey,
                            ),
                            Column(
                              children: List.generate(
                                orderPresenter.trackInfo?.orderUpdates.length ?? 0,
                                (index) => Column(
                                  children: [
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                      child: Row(
                                        children: [
                                          SizedBox(
                                              width: getWidth(context) * 0.25,
                                              child: Text(orderPresenter.trackInfo
                                                      ?.orderUpdates[index].date ??
                                                  "")),
                                          SizedBox(
                                              width: getWidth(context) * 0.55,
                                              child: Text(orderPresenter.trackInfo
                                                      ?.orderUpdates[index].note ??
                                                  "")),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      width: getWidth(context),
                                      height: 1,
                                      color: ThemeConfig.grey,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Column(
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                          width: getWidth(context) * 0.25,
                                          child: Text(orderPresenter.trackInfo?.createdDate ??
                                              "")),
                                      SizedBox(
                                          width: getWidth(context) * 0.55,
                                          child: Text(AppLang.local(context).order_has_been_placed)),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            );
          }),
    );
  }
}
