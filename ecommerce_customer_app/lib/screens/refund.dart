import 'package:flutter/material.dart';
import 'package:grostore/app_lang.dart';
import 'package:grostore/configs/style_config.dart';
import 'package:grostore/configs/theme_config.dart';
import 'package:grostore/custom_ui/BoxDecorations.dart';
import 'package:grostore/custom_ui/common_appbar.dart';
import 'package:grostore/custom_ui/no_data.dart';
import 'package:grostore/custom_ui/shimmers.dart';
import 'package:grostore/helpers/common_functions.dart';
import 'package:grostore/helpers/device_info_helper.dart';
import 'package:grostore/presenters/refund_presenter.dart';
import 'package:grostore/presenters/wallet_presenter.dart';
import 'package:provider/provider.dart';


class Refund extends StatefulWidget {
  const Refund({super.key});

  @override
  State<Refund> createState() => _RefundState();
}

class _RefundState extends State<Refund> {

  @override
  void initState() {
    // TODO: implement initState

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      print("object11");
      Provider.of<RefundPresenter>(context,listen: false).initState();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppbar.show(title: AppLang.local(context).refund_history_ucf, context: context),
      body: Consumer<RefundPresenter>(
          builder: (context,data,child) {
            return RefreshIndicator(
              onRefresh: data.onRefresh,
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: data.isRefundInit && data.refundHistory.isEmpty?const NoData():data.isRefundInit?ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: EdgeInsets.symmetric(horizontal: StyleConfig.padding),
                    itemBuilder: (context,index)=>Container(
                      padding: EdgeInsets.symmetric(horizontal: 14,vertical: 10),
                      decoration: BoxDecorations.shadow(radius: 10),
                      child: Row(
                        children: [
                          SizedBox(
                            width: getWidth(context)*0.4,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(data.refundHistory[index].date),
                                SizedBox(height: 8,),
                                Text(data.refundHistory[index].orderCode),
                                SizedBox(height: 8,),
                                Text(data.refundHistory[index].productName),
                              ],
                            ),
                          ),
                          Spacer(),
                          SizedBox(
                            width: getWidth(context)*0.4,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(data.refundHistory[index].status.toUpperCase(),style: StyleConfig.fs14cSecondryfwBold.copyWith(color: data.refundHistory[index].status=="refunded"?ThemeConfig.fontColor:null),),
                                SizedBox(height: 8,),
                                Text(showPrice(data.refundHistory[index].amount),style: StyleConfig.fs14fwNormal),
                              ],
                            ),
                          ),

                        ],
                      ),
                    ),
                    separatorBuilder: (context,index)=>SizedBox(height: StyleConfig.padding,), itemCount: data.refundHistory.length):
                Padding(padding: EdgeInsets.symmetric(horizontal: StyleConfig.padding),
                  child: Shimmers.list(15, getWidth(context), 55.0),
                ),
              ),
            );
          }
      ),

    );
  }
}
