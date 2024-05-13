import 'package:flutter/material.dart';
import 'package:grostore/app_lang.dart';
import 'package:grostore/configs/style_config.dart';
import 'package:grostore/custom_ui/BoxDecorations.dart';
import 'package:grostore/custom_ui/common_appbar.dart';
import 'package:grostore/custom_ui/shimmers.dart';
import 'package:grostore/helpers/device_info_helper.dart';
import 'package:grostore/presenters/wallet_presenter.dart';
import 'package:provider/provider.dart';


class Wallet extends StatefulWidget {
  const Wallet({super.key});

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {

  @override
  void initState() {
    // TODO: implement initState

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<WalletPresenter>(context,listen: false).initState();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppbar.show(title: AppLang.local(context).wallet_history_ucf, context: context),
    body: Consumer<WalletPresenter>(
      builder: (context,data,child) {
        return RefreshIndicator(
          onRefresh: data.onRefresh,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: data.isWalletInit && data.walletHistory.isEmpty?
                SizedBox(
                  height: getHeight(context),
                  child: Center(
                    child: Text(AppLang.local(context).data_is_not_available),
                  ),
                )
                : data.isWalletInit?
            ListView.separated(
              physics: NeverScrollableScrollPhysics(),
               shrinkWrap: true,
               padding: EdgeInsets.symmetric(horizontal: StyleConfig.padding),
                itemBuilder: (context,index)=>Container(
                  padding: EdgeInsets.symmetric(horizontal: 14,vertical: 10),
                  decoration: BoxDecorations.shadow(radius: 10),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(data.walletHistory[index].date),
                          SizedBox(height: 8,),
                          Text(data.walletHistory[index].paymentMethod),
                        ],
                      ),
                      Spacer(),
                      Text(data.walletHistory[index].amount,style: StyleConfig.fs14cSecondryfwBold,),
                    ],
                  ),
                ),
                separatorBuilder: (context,index)=>SizedBox(height: StyleConfig.padding,), itemCount: data.walletHistory.length):

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
