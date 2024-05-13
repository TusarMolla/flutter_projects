import 'package:flutter/material.dart';
import 'package:grostore/app_lang.dart';
import 'package:grostore/configs/style_config.dart';
import 'package:grostore/configs/theme_config.dart';
import 'package:grostore/custom_ui/Button.dart';
import 'package:grostore/custom_ui/common_appbar.dart';
import 'package:grostore/custom_ui/order_view_model.dart';
import 'package:grostore/custom_ui/shimmers.dart';
import 'package:grostore/helpers/device_info_helper.dart';
import 'package:grostore/helpers/route.dart';
import 'package:grostore/presenters/order_presenter.dart';
import 'package:grostore/screens/main.dart';
import 'package:provider/provider.dart';

class Orders extends StatefulWidget {
  bool fromBottomBar;
  bool fromCheckOut;

  Orders({Key? key, this.fromBottomBar = true,this.fromCheckOut=false}) : super(key: key);

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  @override
  void initState() {
    // TODO: implement initState
    Provider.of<OrderPresenter>(context, listen: false).setContext(context);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<OrderPresenter>(context, listen: false).initState();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){
        if(widget.fromCheckOut){
          MakeRoute.goAndRemoveAll(context, Main());
          return Future(() => true);
        }
        return Future(() => true);
      },
      child: Scaffold(
        backgroundColor: ThemeConfig.xxlightGrey,
        appBar: CommonAppbar.show(
            title: AppLang.local(context).orders,
            context: context,
            gotoMain: widget.fromCheckOut,
            showBackButton: !widget.fromBottomBar),
        body: Consumer<OrderPresenter>(builder: (context, data, child) {
          return RefreshIndicator(
            onRefresh: () => data.onRefresh(),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  buildTapbar(context, data),
                  if (!data.isOrdersInit)
                    Container(
                      width: getWidth(context),
                      height: getHeight(context) - 100,
                      child: Shimmers.list(10, getWidth(context), 80),
                    )
                  else if (data.isOrdersInit && data.orders.isNotEmpty)
                    ListView.separated(
                      padding: EdgeInsets.only(
                          left: 10,
                          right: 10,
                          top: 10,
                          bottom: widget.fromBottomBar ? 80 : 10),
                      scrollDirection: Axis.vertical,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: data.orders.length,
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          height: 10,
                        );
                      },
                      itemBuilder: (context, index) {
                        return Button(
                            //padding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                            minWidth: 100,
                            onPressed: () {},
                            child: OrderViewModel(
                              orderInfo: data.orders[index],
                              context: context,
                            ));
                      },
                    )
                  else
                    Container(
                      height: getHeight(context)-180,
                        alignment: Alignment.center,
                        child: Text(AppLang.local(context).data_is_not_available))
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  Container buildTapbar(BuildContext context, OrderPresenter data) {
    return Container(

      // color: Colors.red,
      width: getWidth(context),
      height: 40,
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 10),
        scrollDirection: Axis.horizontal,
        itemCount: data.searchKey.values.length,
        separatorBuilder: (context, index) {
          return SizedBox(
            width: 10,
          );
        },
        itemBuilder: (context, index) {
          return Button(
            padding: EdgeInsets.symmetric(vertical: 3, horizontal: 15),
            color: data.keySelectedIndex == index
                ? ThemeConfig.green
                : ThemeConfig.white,
            minWidth: 80,
            minHeight: 40.0,
            shape: StyleConfig.buttonRadius(10),
            onPressed: () {
              data.onChangeIndex(index);
            },
            child: Text(
              data.searchKey.values.elementAt(index),
              style: data.keySelectedIndex == index
                  ? StyleConfig.fs14cWhitefwBold
                  : StyleConfig.fs14fwBold,
            ),
          );
        },
      ),
    );
  }
}
