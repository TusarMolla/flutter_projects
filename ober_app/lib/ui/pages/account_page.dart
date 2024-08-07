import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ober_app/blocs/main_bloc.dart';
import 'package:ober_app/blocs/ober_account_bloc.dart';
import 'package:ober_app/config/app_config.dart';
import 'package:ober_app/config/style_config.dart';
import 'package:ober_app/config/theme_config.dart';
import 'package:ober_app/custom_widgets/decorations.dart';
import 'package:ober_app/custom_widgets/images.dart';
import 'package:ober_app/custom_widgets/seo_container.dart';
import 'package:ober_app/dummy_data.dart';
import 'package:ober_app/events/home_events.dart';
import 'package:ober_app/helpers/auth.dart';
import 'package:ober_app/helpers/device_info.dart';
import 'package:ober_app/helpers/main_helper.dart';
import 'package:ober_app/others/seo_route.dart';
import 'package:ober_app/others/system_data.dart';
import 'package:ober_app/ui/pages/activity/activity_page.dart';
import 'package:ober_app/ui/pages/common_web_view.dart';
import 'package:ober_app/ui/pages/help/help_page.dart';
import 'package:ober_app/ui/pages/ober_account/ober_account_page.dart';
import 'package:ober_app/ui/pages/refunds/refund_page.dart';
import 'package:ober_app/ui/pages/settings/settings_page.dart';
import 'package:ober_app/ui/pages/tickets/tickets.dart';




class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(

        body: Container(

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: StyleConfig.padding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                        onTap: (){
                          context.read<MainBloc>().add(OnChangeIndex(0)) ;
                    }, child:Icon(Icons.close,size: 30,)),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(getUsername(context),style: StyleConfig.fs24fwBold,),
                        Spacer(),
                        InkWell(
                            onTap: (){
                              SEORoute.go(context, OberAccountPage());
                            },
                            child: ImageView.networkCircle(imageUrl: getUserPhoto(context), height: 60, width: 60)),

                      ],
                    ),
                    SeoContainer(
                      decoration:Decorations.round(radius: 4),
                      padding: EdgeInsets.symmetric(horizontal: 8,vertical: 2),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.star,size: 15,),
                          Text("${SystemData.userRating?.rating??'0.0'}")
                        ],
                      ),
                    ),
                    buildSpacer(),
                    Row(
                      children: [
                        buildHorizontal3ItemModel("Help",Icons.help_outline,(){
                          SEORoute.go(context, HelpPage());
                        }),
                        /*SizedBox(width: 10,),
                        buildHorizontal3ItemModel("Payment",Icons.payments_outlined,(){
                          SEORoute.go(context, PaymentPage());
                        }),*/
                        SizedBox(width: 10,),

                        buildHorizontal3ItemModel("Activity",Icons.receipt_long_outlined,(){
                          SEORoute.go(context, ActivityPage());
                        }),
                      ],
                    ),
                    buildSpacer(),
                    SeoContainer(
                      width: DeviceInfo.width,
                      padding: EdgeInsets.all(14),
                      decoration: Decorations.round(),
                      child: InkWell(
                        onTap: (){
                          Uri uri = Uri.parse(AppConfig.baseUrl+"/privacy-policy-page");
                          SEORoute.go(context, CommonWebView(uri: uri));
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Privacy Checkup",style: StyleConfig.fs18,),
                            SizedBox(height: 4,),
                            Text("Take an interactive tour of your privacy",style: StyleConfig.fs14,),
                            SizedBox(height: 4,),
                            Text("setting",style: StyleConfig.fs14,),

                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(height: 40,thickness: 4,color: isDarkMode ?ThemeConfig.extraDarkGrey:ThemeConfig.lightGrey,),
              Padding(padding: EdgeInsets.symmetric(horizontal: StyleConfig.padding,),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildBottomVerticalModel("Settings",Icons.settings,(){
                      SEORoute.go(context, SettingPage());
                    }),
                    SizedBox(height: 14,),
                    buildBottomVerticalModel("Ticket",Icons.email,(){
                      SEORoute.go(context, Tickets());
                    }),
                    /*SizedBox(height: 14,),
                    buildBottomVerticalModel("Setup your business profile",Icons.work,(){}),*/
                    SizedBox(height: 14,),
                    buildBottomVerticalModel("Manage Ober account",Icons.person,(){
                      SEORoute.go(context, OberAccountPage());
                    }),
                      SizedBox(height: 14,),
                    buildBottomVerticalModel(getLocal(context).refund,Icons.sync,(){
                      SEORoute.go(context, RefundPage());
                    }),

                    SizedBox(height: 14,),
                    buildBottomVerticalModel("Logout",Icons.logout,(){
                      Auth.logout(context);
                    }),

                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  InkWell buildBottomVerticalModel(String title,IconData icon,VoidCallback onTap,) {
    return InkWell(
                    onTap: onTap,
                    child: Row(
                      children: [
                        Icon(icon,size: 18),
                        SizedBox(width: 18,),
                        Text(title,style: StyleConfig.fs18,)
                      ],
                    ),
                  );
  }

  SizedBox buildSpacer() => SizedBox(height: 20,);

  Flexible buildHorizontal3ItemModel(String title,IconData icon,VoidCallback onTap) {
    return Flexible(
                  flex: 1,
                    fit: FlexFit.tight,
                    child: SeoContainer(
                  padding: EdgeInsets.symmetric(vertical: 14),
                  decoration: Decorations.round(),
                  child: InkWell(
                    onTap: onTap,
                    child: Column(
                      children: [
                        Icon(icon),
                        Text(title,style: StyleConfig.fs14,)
                      ],
                    ),
                  ),
                ));
  }
}
