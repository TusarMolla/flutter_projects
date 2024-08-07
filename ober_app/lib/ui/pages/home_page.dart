import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ober_app/blocs/ober_account_bloc.dart';
import 'package:ober_app/blocs/setting_bloc.dart';
import 'package:ober_app/blocs/trip_bloc.dart';
import 'package:ober_app/config/app_config.dart';
import 'package:ober_app/config/style_config.dart';
import 'package:ober_app/config/theme_config.dart';
import 'package:ober_app/custom_widgets/buttons.dart';
import 'package:ober_app/custom_widgets/decorations.dart';
import 'package:ober_app/events/setting_events.dart';
import 'package:ober_app/events/trip_events.dart';
import 'package:ober_app/helpers/main_helper.dart';
import 'package:ober_app/others/seo_pusher.dart';
import 'package:ober_app/others/seo_route.dart';
import 'package:ober_app/repositories/rapyd_repository.dart';
import 'package:ober_app/states/ober_account_state.dart';
import 'package:ober_app/states/setting_state.dart';
import 'package:ober_app/states/trip_state.dart';
import 'package:ober_app/ui/pages/ober_account/update_profile.dart';
import 'package:ober_app/ui/pages/search_location/location_search_page.dart';
import 'package:ober_app/ui/pages/trip/trip_request_details.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
// RapyedReq.makeSignature();

    SeoPusher.fetchTripRequest();
    context.read<TripBloc>().add(OnCheckTripStatus());
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 80,
            ),
            Row(
              children: [
                /*Text(
                  AppConfig.appName,
                  style: StyleConfig.fs24fwBold,
                ),*/
                Image.asset(getAssetLogo("txt_logo.png")),
                Spacer(),
                Container(
                  decoration: Decorations.border(),
                  padding: EdgeInsets.all(8),
                  child: InkWell(
                      // minWidth: 80,
                      onTap: (){
                    if(context.read<SettingBloc>().state.selectedLang.key == "en"){
                      context.read<SettingBloc>().add(ChangeLang(SettingState.languages.last));
                    }else{
                      context.read<SettingBloc>().add(ChangeLang(SettingState.languages.first));
                    }
                  }, child: Row(
                    children: [
                      Icon(Icons.translate,size: 14,),
                      SizedBox(width: 10,),
                      Text(context.read<SettingBloc>().state.selectedLang.key=="en"?"Iceland":"English",style: StyleConfig.fs14,),
                    ],
                  )),
                )
              ],
            ),
            SizedBox(
              height: 14,
            ),
            buildSearchBox(context),
            SizedBox(
              height: 14,
            ),
            Container(
              padding: EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: ThemeConfig.accentColor,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                children: [
                  Flexible(
                      flex: 1,
                      child: Text(
                        getLocal(context).go_anywhere_with_ober,
                        style: StyleConfig.fs24cWhite,
                      )),
                  Flexible(
                      flex: 2, child: Image.asset(getAssetImage("car2.png"))),
                ],
              ),
            ),
            SizedBox(
              height: 14,
            ),
            buildRunningTripBox(context),
            buildCompleteProfile(context)
          ],
        ),
      ),
    );
  }

  Widget buildRunningTripBox(BuildContext context) {
    return BlocBuilder<TripBloc, TripState>(builder: (context, tripState) {
      if (tripState.currentTripId == null) {
        return SizedBox.shrink();
      }
      return Container(
        width: getWidth(context),
        padding: EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: ThemeConfig.accentColor,
          borderRadius: BorderRadius.circular(14),
        ),
        child: InkWell(
          onTap: () {
            SEORoute.go(
                context,
                TripRequestDetails(
                  id: tripState.currentTripId,
                ));
          },
          child: Column(
            children: [
              Text(
                "You connected with a trip!",
                style: StyleConfig.fs24cWhite,
              ),
              SizedBox(
                height: 14,
              ),
              Container(
                alignment: Alignment.center,
                height: 46,
                width: getWidth(context),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      getAssetImage("honda.png"),
                      height: 60,
                      width: 60,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Go now",
                      style: StyleConfig.fs16.copyWith(color: Colors.white),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );
    });
  }
  Widget buildCompleteProfile(BuildContext context) {
    return BlocBuilder<OberAccountBloc, OberAccountState>(builder: (context, accountState) {
      if (!accountState.isUserDataInit || accountState.usersData != null) {
        return SizedBox.shrink();
      }
      return Container(
        width: getWidth(context),
        padding: EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: ThemeConfig.accentColor,
          borderRadius: BorderRadius.circular(14),
        ),
        child: InkWell(
          onTap: () {
            SEORoute.go(
                context,
                UpdateProfile());
          },
          child: Column(
            children: [
              Text(
                "Your account is not complete yet. Please update your profile.",
                style: StyleConfig.fs24cWhite,
              ),
              SizedBox(
                height: 14,
              ),
              Container(
                alignment: Alignment.center,
                height: 46,
                width: getWidth(context),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Image.asset(
                        getAssetImage("user.png"),
                        height: 60,
                        width: 60,
                      ),
                    ),
                    Text(
                      "Update now",
                      style: StyleConfig.fs16.copyWith(color: Colors.white),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );
    });
  }

  Widget buildSearchBox(BuildContext context) {
    return BlocBuilder<OberAccountBloc, OberAccountState>(builder: (context, accountState) {
      return Container(
        height: 50,
        padding: EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(
          color: ThemeConfig.grey,
          borderRadius: BorderRadius.circular(25),
        ),
        child: BlocBuilder<TripBloc, TripState>(
          builder: (context, tripState) {
            return InkWell(
              onTap: () {

                print("aaaaaaaa ${accountState.usersData == null}");

                if(accountState.usersData == null){
                  SEORoute.go(
                      context,
                      UpdateProfile());
                  return;
                }
                else if (tripState.currentTripId != null) {
                  SEORoute.go(
                      context,
                      TripRequestDetails(
                        id: tripState.currentTripId,
                      ));
                  return;
                }
                SEORoute.go(context, LocationSearchPage());
              },
              child: Row(
                children: [
                  Icon(
                    Icons.search,
                    size: 25,
                    color: ThemeConfig.white,
                  ),
                  Text(
                    "Where to?",
                    style: StyleConfig.fs16cWhitefwBold,
                  ),
                ],
              ),
            );
          }
        ),
      );
    });
  }
}
