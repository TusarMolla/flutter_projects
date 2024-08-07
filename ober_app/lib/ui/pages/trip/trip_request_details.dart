import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:ober_app/blocs/trip_bloc.dart';
import 'package:ober_app/config/app_config.dart';
import 'package:ober_app/config/style_config.dart';
import 'package:ober_app/config/theme_config.dart';
import 'package:ober_app/custom_widgets/buttons.dart';
import 'package:ober_app/custom_widgets/images.dart';
import 'package:ober_app/custom_widgets/seoAppbar.dart';
import 'package:ober_app/custom_widgets/seo_dialogs.dart';
import 'package:ober_app/custom_widgets/seo_forms.dart';
import 'package:ober_app/events/trip_events.dart';
import 'package:ober_app/helpers/main_helper.dart';
import 'package:ober_app/models/trip_detail_response.dart';
import 'package:ober_app/others/seo_route.dart';
import 'package:ober_app/states/trip_state.dart';
import 'package:ober_app/ui/pages/main.dart';
import 'package:ober_app/ui/pages/trip/trip_view_on_map.dart';
import 'package:url_launcher/url_launcher.dart';

class TripRequestDetails extends StatelessWidget {
   TripRequestDetails({super.key, required this.id,this.from = "HomePage"});
  final id;
  String from ;

  @override
  Widget build(BuildContext context) {
    print("from page $from");
    context.read<TripBloc>().add(InitTripDetails(id,context));
    return PopScope(
      canPop: from == "HomePage",
      onPopInvoked: (data){
        print(data);
        // if(from !="HomePage"){
        if(!data) {
          SEORoute.goAndRemoveAll(context, MainPage());
        }
        // }
      },
      child: Scaffold(
        appBar: SeoAppbar.build(title: "Trip Details"),
        body: BlocBuilder<TripBloc, TripState>(builder: (context, state) {
          return SingleChildScrollView(
            padding: EdgeInsets.all(StyleConfig.padding),
            child: buildBody(context, state),
          );
        }),
      ),
    );
  }

  Widget buildBody(BuildContext context, TripState state) {
    Future.delayed(Duration(seconds: 30)).then((value){
      // context.read<TripBloc>().add(OnCheckTripStatus(finish: (){
      // //   if(context.read<TripBloc>().state.c)
      // }));

    });
    if (!state.isTripDetailsInit) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    var details = state.details;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if(details?.driver !=null)
        buildDriverSection(details)
        else
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(getLocal(context).please_wait_your_trip_is_processing),
              SizedBox(width: 10,),
              LoadingAnimationWidget.halfTriangleDot(
                color: ThemeConfig.accentColor,
                size: 60,
              ),
            ],
          ),
        Text("Total amount : ${priceWithSymbol(details?.trip?.fare)}",style: StyleConfig.fs14,),

        SizedBox(
          height: 10,
        ),


        Text(
          "Location Details",
          style: StyleConfig.fs16fwBold,
        ),
        Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Pickup Location: ",
                    style: StyleConfig.fs14fwBold,
                  ),
                  Flexible(
                      flex: 1,
                      child: Text(
                        "${details?.trip?.startLocation}",
                        style: StyleConfig.fs14,
                      )),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Drop-off Location: ",
                    style: StyleConfig.fs14fwBold,
                  ),
                  Flexible(
                      flex: 1,
                      child: Text(
                        "${details?.trip?.endLocation}",
                        style: StyleConfig.fs14,
                      )),
                ],
              ),
              SizedBox(
                height: 14,
              ),
              Buttons.round(
                  onPress: () {
                    List tmpFrom =
                        (state.details?.trip?.fromLatitudeLongitude ?? "")
                            .split(", ");

                    if (tmpFrom.isNotEmpty) {
                      String lat = tmpFrom[0];
                      String lng = tmpFrom[1];
                      SEORoute.go(
                          context,
                          TripViewOnMap(
                              startLatLng: LatLng(
                                  double.parse(lat), double.parse(lng))));
                    }
                  },
                  child: Text(
                    "View in Map",
                    style: StyleConfig.fs16,
                  ))   ,
              SizedBox(
                height: 14,
              ),
              if(state.details?.trip?.status.toString() !="4")
              Buttons.round(
                bColor: ThemeConfig.red,
                  onPress: () {
                    Dialogs.yesNoWithWidget(context: context, title: getLocal(context).alert, content: getLocal(context).cancel_alert_message,
                        noTxt: getLocal(context).close,
                        yesTxt: getLocal(context).cancel_trip,

                        contentWidget: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 10,),
                            Text(getLocal(context).cancel_reason+"*"),
                            SeoForms.cupertinoNoTitleLongTextField(state.cancelReasonController),
                          ],
                        )
                        ,yesOnClick: (){

                          context.read<TripBloc>().add(OnTripCancel(id,context));

                        });
                  },
                  child: Text(
                    "Trip Cancel",
                    style: StyleConfig.fs16,
                  ))
            ],
          ),
        ),
      ],
    );
  }

  Column buildDriverSection(TripDetailsResponse? details) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Driver Details",
            style: StyleConfig.fs16fwBold,
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                    child: ImageView.networkCircle(
                        imageUrl:
                            "${AppConfig.public_assets}/${details?.driver?.photo}",
                        height: 60,
                        width: 60)),
                Text(
                  "Name: ${details?.driver?.firstName??''} ${details?.driver?.lastName??''}",
                  style: StyleConfig.fs14,
                ),
                Row(
                  children: [
                    Text(
                      "Phone: ${details?.driver?.phoneNumber??''}",
                      style: StyleConfig.fs14,
                    ),
                    IconButton(
                      onPressed: () async {
                        await launchUrl(
                            Uri.parse("tel:${details?.passenger?.phoneNumber}"));
                      },
                      icon: Icon(
                        Icons.add_call,
                      ),
                      color: Colors.greenAccent,
                    )
                  ],
                ),
                Text(
                  "Car Name: ${details?.vehicle?.vehicleName}",
                  style: StyleConfig.fs14,
                ),
                Text(
                  "Car No: ${details?.vehicle?.vehicleLicenseNumber??''}",
                  style: StyleConfig.fs14,
                ),
              ],
            ),
          ),
        ],
      );
  }



}
