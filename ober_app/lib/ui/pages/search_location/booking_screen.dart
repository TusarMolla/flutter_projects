import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ober_app/blocs/booking_screen_bloc.dart';
import 'package:ober_app/config/style_config.dart';
import 'package:ober_app/custom_widgets/buttons.dart';
import 'package:ober_app/custom_widgets/decorations.dart';
import 'package:ober_app/custom_widgets/seo_dialogs.dart';
import 'package:ober_app/events/booking_screen_events.dart';
import 'package:ober_app/helpers/main_helper.dart';
import 'package:ober_app/others/seo_route.dart';
import 'package:ober_app/others/system_data.dart';
import 'package:ober_app/states/booking_screen_state.dart';
import 'package:ober_app/ui/models/seo_map.dart';
import 'package:ober_app/ui/pages/payment_method_page.dart';

class BookingScreen extends StatelessWidget {
  BookingScreen({super.key, required this.pickUp, required this.dropOff});

  LatLng pickUp, dropOff;

  @override
  Widget build(BuildContext context) {
    context
        .read<BookingScreenBloc>()
        .add(InitState(pickUp: pickUp, dropOff: dropOff,context: context));

    return BlocBuilder<BookingScreenBloc, BookingScreenState>(
        builder: (context, data) {
      if (data.polyline.isEmpty) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }

      return Scaffold(
        body: Stack(
          children: [
            SeoMap(
              currentLocation: SystemData.userCurrentLocation!,
              initialLocation: data.polyline.values.first.points.first,
              mapController: data.mapController,
              polyline: data.polyline,
              showPlacePicker: false,
              markers: {
                Marker(
                    markerId: MarkerId("pickup"),
                    position: data.polyline.values.first.points.first,
                    icon: BitmapDescriptor.defaultMarkerWithHue(
                        BitmapDescriptor.hueGreen)),
                Marker(
                    markerId: MarkerId("dropOff"),
                    position: data.polyline.values.last.points.last,
                    icon: BitmapDescriptor.defaultMarkerWithHue(
                        BitmapDescriptor.hueBlue)),
              },
            ),
            showCategoryList(context, data),
            Positioned(
              left: 14,
              top: 24,
              child: Buttons(
                color: Colors.blue,
                padding: EdgeInsets.zero,
                minWidth: 36.0,
                minHeight: 36.0,
                shape: StyleConfig.buttonsRadius(28),
                alignment: Alignment.center,
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back,
                  size: 24,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  DraggableScrollableSheet showCategoryList(BuildContext context, BookingScreenState state) {
    return DraggableScrollableSheet(
      // controller: data.draggableController,
      initialChildSize: 0.3,
      minChildSize: 0.3,
      maxChildSize: 0.5,
      builder: (context, controller) => SingleChildScrollView(
          controller: controller,
          child: Container(
            decoration: BoxDecoration(
                color: themeBoxColor,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(24),
                    topLeft: Radius.circular(24)),

            ),
            // color: Colors.red,
            height: getHeight(context),
            width: getWidth(context),

            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Choose a ride",
                  style: StyleConfig.fs16,
                ),
                SizedBox(
                  height: 10,
                ),
                Divider(
                  color: themeTxtColor,
                  thickness: 1,
                  height: 1,
                ),
                SizedBox(
                  height: 10,
                ),
                ListView.separated(
                  padding: EdgeInsets.symmetric(horizontal: 14),
                  physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) => Container(
                      padding: EdgeInsets.all(8),
                      decoration: Decorations.border(),
                      child: InkWell(
                        onTap: () {
                              /*Dialogs.yesNo(context: context,
                                  title: "Confirmation alert!",
                                  content: "Ara you sure to call Ober driver?",
                                  yesOnClick: () {
                                    context.read<BookingScreenBloc>().add(
                                        OnRequestTrip(context,
                                            state.vehicleCategories[index].id ??
                                                0, state.tripId ?? 0));
                                  });*/
                          SEORoute.go(context, PaymentFormPage(state.tripId??0,state.vehicleCategories[index],state.vehicleCategories[index].rate));
                        },
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                                flex: 2,child: Image.asset(getAssetIcon("car.png"),width: 100,)),
                            SizedBox(width: 24,),
                            Flexible(
                              flex: 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(state.vehicleCategories[index].name??"",style: StyleConfig.fs16,),
                                  Text(state.vehicleCategories[index].additional_notes??"",style: StyleConfig.fs14,),
                                  Text("${((state.tripLocationData?.distanceValue??0)/1000)}km"),
                                  Text(state.tripLocationData?.duration??""),
                                ],
                              ),
                            ),
                                Spacer(),
                            Flexible(
                                flex: 1,child: Text(priceWithSymbol(state.vehicleCategories[index].rate),style: StyleConfig.fs16,)),
                          ],
                        ),
                      ),
                    ),
                    separatorBuilder: (context, index) => SizedBox(
                          height: 14,
                        ),

                    itemCount: state.vehicleCategories.length)
              ],
            ),
          )),
    );
  }
}
