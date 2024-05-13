import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_countdown_timer/countdown.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:grostore/app_lang.dart';
import 'package:grostore/configs/style_config.dart';
import 'package:grostore/configs/theme_config.dart';
import 'package:grostore/custom_ui/BoxDecorations.dart';
import 'package:grostore/custom_ui/Button.dart';
import 'package:grostore/custom_ui/common_appbar.dart';
import 'package:grostore/custom_ui/shimmers.dart';
import 'package:grostore/custom_ui/toast_ui.dart';
import 'package:grostore/helpers/device_info_helper.dart';
import 'package:grostore/presenters/coupon_presenter.dart';
import 'package:provider/provider.dart';

class Coupons extends StatefulWidget {
  const Coupons({Key? key}) : super(key: key);

  @override
  State<Coupons> createState() => _CouponsState();
}

class _CouponsState extends State<Coupons> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<CouponPresenter>(context, listen: false).initState();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppbar.show(
          title: AppLang.local(context).coupons, context: context),
      body: Consumer<CouponPresenter>(builder: (context, data, child) {
        print(data.isCouponsInit);
        if (!data.isCouponsInit) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: StyleConfig.padding),
            child:
                Shimmers.list(10, getWidth(context) - StyleConfig.padding, 150),
          );
        }

        return ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: StyleConfig.padding),
            itemBuilder: (context, index) {
              return Container(
                height: getWidth(context) * 0.5,
                width: getWidth(context),
                decoration:
                    BoxDecorations.image(url: data.coupons[index].banner),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Text("UP to  ${data.coupons[index].discountValue.toString()}${data.coupons[index].discountType== 'percent'?'%':''} OFF",style: StyleConfig.fs24fwBold.copyWith(color: Colors.red,),),
                    ),
                    SizedBox(height: 14,),
                    Container(
                      height: 40,
                      margin: EdgeInsets.symmetric(horizontal: StyleConfig.padding),
                      decoration: BoxDecoration(
                       // border: Border.all(),
                        borderRadius: BorderRadius.circular(8),
                        color: ThemeConfig.white
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left:8 ,right: 8.0),
                            child: Text(data.coupons[index].code,style: StyleConfig.fs16fwBold,),
                          ),
                        Spacer(),
                        Button(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          color: ThemeConfig.accentColor,
                            minHeight: 40.0,
                            minWidth: 10,
                            shape: StyleConfig.buttonRadius(8),
                            onPressed: ()async{
                              await Clipboard.setData(ClipboardData(text:data.coupons[index].code));
                              ToastUi.show(context, "Copied");
                            },
                            child: Text(AppLang.local(context).copy_code_ucf,
                              style: StyleConfig.fs14cWhitefwNormal,
                            ),
                        )
                      ],
                      ),
                    ),
                    SizedBox(height: 14,),
                    buildCounterRow(data, index)
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) => SizedBox(
                  height: StyleConfig.smSectionSpacer,
                ),
            itemCount: data.coupons.length);
      }),
    );
  }

  Row buildCounterRow(CouponPresenter data, int index) {
    return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CountdownTimer(
                        controller: data.controller[index],
                        widgetBuilder: (context, timer) {
                          return buildCounterContainer(TimerType.day, timer);
                        },
                      ),
                      CountdownTimer(
                        controller: data.controller[index],
                        widgetBuilder: (context, timer) {
                          return buildCounterContainer(TimerType.hours, timer);
                        },
                      ),
                      CountdownTimer(
                        controller: data.controller[index],
                        widgetBuilder: (context, timer) {
                          return buildCounterContainer(TimerType.min, timer);
                        },
                      ),
                      CountdownTimer(
                        controller: data.controller[index],
                        widgetBuilder: (context, timer) {
                          return buildCounterContainer(TimerType.sec, timer);
                        },
                      ),
                    ],
                  );
  }

  Container buildCounterContainer(TimerType timerType, CurrentRemainingTime? timer) {
    return Container(
      width: getWidth(context) / 6,
      height: getWidth(context) / 6,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: ThemeConfig.amber, width: 1),
          color: ThemeConfig.white),
      child:makeCounter(timerType, timer)
    );
  }

  makeCounter(TimerType timerType, CurrentRemainingTime? timer){
    if(timerType==TimerType.day){
      return buildCounterDate(timer, context);
    }else if(timerType ==TimerType.hours){
      return buildCounterHours(timer, context);
    }else if(timerType ==TimerType.min){
      return buildCounterMin(timer, context);
    }else {
      return buildCounterSec(timer, context);
    }
  }

  Column buildCounterDate(CurrentRemainingTime? timer, BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          timer?.days.toString() ?? "",
          style: StyleConfig.fs14fwNormal,
        ),
        Text(
          AppLang.local(context).days,
          style: StyleConfig.fs14fwNormal,
        ),
      ],
    );
  }
  Column buildCounterHours(CurrentRemainingTime? timer, BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          timer?.hours.toString() ?? "",
          style: StyleConfig.fs14fwNormal,
        ),
        Text(
          AppLang.local(context).hours,
          style: StyleConfig.fs14fwNormal,
        ),
      ],
    );
  }
  Column buildCounterMin(CurrentRemainingTime? timer, BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          timer?.min.toString() ?? "",
          style: StyleConfig.fs14fwNormal,
        ),
        Text(
          AppLang.local(context).min,
          style: StyleConfig.fs14fwNormal,
        ),
      ],
    );
  }
  Column buildCounterSec(CurrentRemainingTime? timer, BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          timer?.sec.toString() ?? "",
          style: StyleConfig.fs14fwNormal,
        ),
        Text(
          AppLang.local(context).sec,
          style: StyleConfig.fs14fwNormal,
        ),
      ],
    );
  }
}
enum TimerType{
  day,hours,min,sec
}