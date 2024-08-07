import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ober_app/blocs/location_search_bloc.dart';
import 'package:ober_app/config/style_config.dart';
import 'package:ober_app/config/theme_config.dart';
import 'package:ober_app/custom_widgets/buttons.dart';
import 'package:ober_app/custom_widgets/seoAppbar.dart';
import 'package:ober_app/events/location_search_events.dart';
import 'package:ober_app/helpers/device_info.dart';
import 'package:ober_app/helpers/main_helper.dart';
import 'package:ober_app/helpers/seo_typedef.dart';
import 'package:ober_app/others/seo_route.dart';
import 'package:ober_app/states/location_search_state.dart';
import 'package:ober_app/ui/models/seo_map.dart';
import 'package:ober_app/ui/pages/search_location/booking_screen.dart';
import 'package:ober_app/ui/pages/search_location/multi_stop_page.dart';
import 'package:ober_app/ui/pages/search_location/search_list.dart';

class LocationSearchPage extends StatelessWidget {
  const LocationSearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<LocationSearchBloc>().add(SetUserCurrentLocation());

    return BlocBuilder<LocationSearchBloc, LocationSearchState>(
        builder: (context, data) {

      return Scaffold(
        appBar: SeoAppbar.build(
            title: "Plan Your Ride",
            bottom: PreferredSize(
                preferredSize: Size(DeviceInfo.width, 80),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: StyleConfig.padding, vertical: 5),
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /*//buildTopBar(context),
                      SizedBox(
                        height: 10,
                      ),*/
                      Container(
                        padding: EdgeInsets.all(4),
                        color: ThemeConfig.transparentGrey,
                        child: TextField(
                          onTap: (){
                            context.read<LocationSearchBloc>().add(OnChangeLocationField(ActiveLocationField.PickUp));
                          },
                            onChanged: (string){
                            context.read<LocationSearchBloc>().add(OnSearchLocation(string));
                            },
                            controller: data.pickupLocationController,
                            decoration: InputDecoration.collapsed(
                              hintText: "Enter pickup location",
                              hintStyle: StyleConfig.fs14,
                            ).copyWith(focusedBorder: InputBorder.none)),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: EdgeInsets.all(4),
                        color: ThemeConfig.transparentGrey,
                        child: TextField(
                          focusNode:data.focusNode ,
                            autofocus: true,
                            onTap: () {
                              context.read<LocationSearchBloc>().add(OnChangeLocationField(ActiveLocationField.DropOff));
                            },
                            onChanged: (str){
                              context.read<LocationSearchBloc>().add(OnSearchLocation(str));
                            },
                            controller: data.dropOffLocationController,
                            decoration: InputDecoration.collapsed(
                              hintText: "Where to?",
                              hintStyle: StyleConfig.fs14,
                            ).copyWith(focusedBorder: InputBorder.none)),
                      ),
                    ],
                  ),
                ),)),
        body: Stack(
          children: [
            if(data.currentLocation!=null)
            SeoMap(initialLocation:  data.currentLocation!,
                currentLocation: data.currentLocation!,
                cameraMoveCompleted:(moveCamera){
                  if(moveCamera !=null){
                    context.read<LocationSearchBloc>().add(OnChangeCameraPosition(moveCamera));
                  }
                },
                mapController: data.controller),
            if (data.isShownBottomSheet)
              DraggableScrollableSheet(
                controller: data.draggableController,
                initialChildSize: 1,
                maxChildSize: 1,
                builder: (context, controller) => SingleChildScrollView(
                    controller: controller,
                    child: SearchList(
                      locations: data.autoCompleteLocations,
                      onSelectedLocation: (newLocation){
                        context.read<LocationSearchBloc>().add(OnSelectedAutoLocation(newLocation,context));
                      },
                      onClickSetLocation: (){
                        context.read<LocationSearchBloc>().add(OnSetBottomShowHide(false));
                      },
                    )),
              ),
            if(!data.isShownBottomSheet)
              Positioned(
                bottom: 10,
                right: 80,
                left: 80,
                child: Buttons(
                  color: Colors.green,
                  shape: StyleConfig.buttonsRadius(14),
                  child: Text("Done",style: StyleConfig.fs16cWhitefwBold,),onPressed:(){

                    context.read<LocationSearchBloc>().add(OnPressDone(context));

                },),
              )

          ],
        ),
      );
    });
  }

  SingleChildScrollView buildTopBar(BuildContext context) {
    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Buttons(
                              color: ThemeConfig.transparentGrey,
                              shape: StyleConfig.buttonsRadius(30),
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.watch_later_rounded,
                                    color: themeColor,
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    "Pickup now",
                                    style: StyleConfig.fs14,
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Icon(
                                    Icons.keyboard_arrow_down,
                                    color: themeColor,
                                  )
                                ],
                              )),
                          SizedBox(
                            width: 8,
                          ),
                          Buttons(
                            onPressed: (){
                              showModalBottomSheet(context: context, builder: (context)=>Container(
                                width: getWidth(context),
                                color: themeBoxColor,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizedBox(height: 14,),
                                    Text("Do you want to use multi stops?",style: StyleConfig.fs14,),
                                    Buttons(
                                      shape:StyleConfig.buttonsRadius(14),
                                      color: themeTxtColor,
                                      minWidth: getWidth(context)*0.5,
                                      minHeight: 36.0,
                                      child: Text("Yes",style: StyleConfig.fs16fwBold,),onPressed: (){
                                        Navigator.pop(context);
                                      //SEORoute.go(context, MultiStopPage());
                                    },),
                                    Buttons
                                      (

                                      shape:StyleConfig.buttonsRadius(14),
                                      color: themeTxtColor,
                                      minWidth: getWidth(context)*0.5,
                                      minHeight: 36.0,
                                      child: Text("No",style: StyleConfig.fs16,),onPressed: (){
                                      Navigator.pop(context);
                                    },),
                                  ],
                                ),
                              ));
                            },
                              color: ThemeConfig.transparentGrey,
                              shape: StyleConfig.buttonsRadius(30),
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.arrow_forward,
                                    color: themeColor,
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    "One Way",
                                    style: StyleConfig.fs14,
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Icon(
                                    Icons.keyboard_arrow_down,
                                    color: themeColor,
                                  )
                                ],
                              )),
                          SizedBox(
                            width: 8,
                          ),
                          Buttons(
                              color: ThemeConfig.transparentGrey,
                              shape: StyleConfig.buttonsRadius(30),
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.person_sharp,
                                    color: themeColor,
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    "For Me",
                                    style: StyleConfig.fs14,
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Icon(
                                    Icons.keyboard_arrow_down,
                                    color: themeColor,
                                  )
                                ],
                              )),
                        ],
                      ),
                    );
  }
}
