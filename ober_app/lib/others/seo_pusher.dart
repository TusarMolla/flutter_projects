import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ober_app/blocs/trip_bloc.dart';
import 'package:ober_app/config/app_config.dart';
import 'package:ober_app/config/theme_config.dart';
import 'package:ober_app/custom_widgets/seo_dialogs.dart';
import 'package:ober_app/custom_widgets/seo_forms.dart';
import 'package:ober_app/events/trip_events.dart';
import 'package:ober_app/main.dart';
import 'package:ober_app/models/driver_location_pusher_response.dart';
import 'package:ober_app/models/trip_accepted_pusher_response.dart';
import 'package:ober_app/others/seo_route.dart';
import 'package:ober_app/others/system_data.dart';
import 'package:ober_app/repositories/trip_repository.dart';
import 'package:ober_app/ui/pages/main.dart';
import 'package:ober_app/ui/pages/trip/trip_request_details.dart';
import 'package:ober_app/ui/pages/trip/trip_view_on_map.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

import '../config/style_config.dart';

class SeoPusher {
  static PusherChannelsFlutter pusher = PusherChannelsFlutter.getInstance();
  static TextEditingController commentController = TextEditingController();
  static double rating = 0.0;

  static init() async {
    try {
      await pusher.init(
        apiKey: AppConfig.pusherApiKey,
        cluster: AppConfig.pusherCluster,

        // onConnectionStateChange: onConnectionStateChange,
        // onError: onError,
        // onSubscriptionSucceeded: onSubscriptionSucceeded,
        // onEvent: onEvent,
        // onSubscriptionError: onSubscriptionError,
        // onDecryptionFailure: onDecryptionFailure,
        // onMemberAdded: onMemberAdded,
        // onMemberRemoved: onMemberRemoved,
        // authEndpoint: "<Your Authendpoint>",
        // onAuthorizer: onAuthorizer
      );
      pusher.connect();
    } catch (e) {
      print("ERROR: $e");
    }
  }

  static final GlobalKey _alertKey = GlobalKey();

  static fetchTripRequest() {
    pusher.unsubscribe(channelName: AppConfig.tripAcceptChannel);
    pusher.subscribe(
        channelName: AppConfig.tripAcceptChannel,
        onEvent: (newEvents) {
          if (newEvents.data is String) {
            print("accept");
            var eventData = tripAcceptedPusherResponseFromJson(newEvents.data);
            print(eventData.passenger?.userId);
            print(SystemData.userData?.id);
            if (eventData.passenger != null &&
                eventData.passenger?.userId.toString() == SystemData.userData?.id.toString()) {
              print("accept trip");
              if (_alertKey.currentContext == null) {
                globalState.currentState!.context
                    .read<TripBloc>()
                    .add(OnCheckTripStatus());

                showDialog(
                    context: globalState.currentState!.context,
                    builder: (context) =>
                        _tripDialog(context, eventData.trip?.id,eventData.trip?.fare??0,"xrfdddvb"));
              }
            }
          }
        });
  }

  static fetchDriverLocation({required String driverID}) {
    var ddd = pusher.getChannel(AppConfig.driverLocationChannel);
    pusher.unsubscribe(channelName: AppConfig.driverLocationChannel);
    pusher.subscribe(
        channelName: AppConfig.driverLocationChannel,
        onEvent: (newEvents) {
          print("pusher Driver location${driverID}");
          print("pusher Driver location${newEvents}");
          if (newEvents.data is String) {
            var eventData =
                driverLocationPusherResponseFromJson(newEvents.data);
            if (eventData.latitude != null &&
                eventData.longitude != null &&
                eventData.id.toString() == driverID.toString()) {
              LatLng location = LatLng(double.parse(eventData.latitude ?? "0"),
                  double.parse(eventData.longitude ?? "0"));
              globalState.currentState!.context
                  .read<TripBloc>()
                  .add(UpdateDriverLocation(location));
            }
          }
        });
  }

  static tripComplete({required String tripId}) {
    // var ddd = pusher.getChannel(AppConfig.driverLocationChannel);
    pusher.unsubscribe(channelName: AppConfig.tripCompleteChannel);
    pusher.subscribe(
        channelName: AppConfig.tripCompleteChannel,
        onEvent: (newEvents) {
          print("pusher trip cancel ${newEvents}");
          // print("pusher Driver location${newEvents}");
          if (newEvents.data is String) {
            var eventData = jsonDecode(newEvents.data);
            BuildContext context = globalState.currentState!.context;
            var cTripID =
                context.read<TripBloc>().state.currentTripId.toString();
            if (cTripID == eventData['trip_id'].toString()) {
              // context.read<TripBloc>().add(OnCheckTripStatus());
              showDialog(
                  context: context,
                  builder: (context) => _tripCompleteDialog(context, cTripID));
            }
          }
        });
  }

  static tripStart({required String tripId}) {
    // var ddd = pusher.getChannel(AppConfig.driverLocationChannel);
    pusher.unsubscribe(channelName: AppConfig.tripStartChannel);
    pusher.subscribe(
        channelName: AppConfig.tripStartChannel,
        onEvent: (newEvents) {
          // print("pusher Driver location${newEvents}");
          if (newEvents.data is String) {
            var eventData = jsonDecode(newEvents.data);
            BuildContext context = globalState.currentState!.context;
            var cTripID =
                context.read<TripBloc>().state.currentTripId.toString();
            if (cTripID == eventData['trip_id'].toString()) {
              context.read<TripBloc>().add(OnCheckTripStatus());
              Dialogs.info(context: context, content: "Trip has been started",onClickOk: (){
                List tmpFrom =
                (context.read<TripBloc>().state.details?.trip?.fromLatitudeLongitude ?? "")
                    .split(", ");
                if (tmpFrom.isNotEmpty) {
                  String lat = tmpFrom[0];
                  String lng = tmpFrom[1];
                  SEORoute.go(
                      context,
                      TripViewOnMap(
                        startLatLng: LatLng(
                            double.parse(lat), double.parse(lng)),));
                }
                context.read<TripBloc>().add(InitTripDetails(eventData['trip_id'],context));
              });
            }
          }
        });
  }

  static tripCancel({required String tripId}) {
    print("pusher trip cancel init }");
    // var ddd = pusher.getChannel(AppConfig.driverLocationChannel);
    pusher.unsubscribe(channelName: AppConfig.tripCancelChannel);
    pusher.subscribe(
        channelName: AppConfig.tripCancelChannel,
        onEvent: (newEvents) {
          print("pusher trip cancel ${newEvents}");
          // print("pusher Driver location${newEvents}");
          if (newEvents.data is String) {
            var eventData = jsonDecode(newEvents.data);
            BuildContext context = globalState.currentState!.context;
            var cTripID =
                context.read<TripBloc>().state.currentTripId.toString();
            if (cTripID == eventData['trip_id'].toString() &&
                eventData['userId'].toString() !=
                    SystemData.userData?.id.toString()) {
              context.read<TripBloc>().add(OnCheckTripStatus());
              _tripCancelledDialog(context);
            }
          }
        });
  }


  static Widget _tripDialog(BuildContext context, tripId,amount,trnxId) {
    return CupertinoAlertDialog(
      key: _alertKey,
      title: Text(
        "Trip Accepted",
        style: StyleConfig.fs14fwBold.copyWith(color: ThemeConfig.black),
      ),
      content: Text(
        "Your Trip is accepted. A driver will contact with you shortly.",
        style: StyleConfig.fs14.copyWith(color: ThemeConfig.black),
      ),
      actions: [
        CupertinoDialogAction(
            onPressed: () async {
              // TripRepository.tripPay(tripId, amount, trnxId);
              Navigator.pop(context);
              SEORoute.go(
                  globalState.currentState!.context,
                  TripRequestDetails(
                    id: tripId,
                    from: "GlobalContext",
                  ));
            },

            // color: Colors.grey,
            child: Text(
              "View Driver Details",
              style: StyleConfig.fs14cWhitefwNormal
                  .copyWith(color: ThemeConfig.green),
            )),
      ],
    );
  }

  static Widget _tripCompleteDialog(BuildContext context, tripId) {
    return CupertinoAlertDialog(
      title: Text(
        "Trip Completed",
        style: StyleConfig.fs14fwBold.copyWith(color: ThemeConfig.black),
      ),
      content: Column(
        children: [
          Text(
            "Congratulations! your Trip is completed. Please provide your valuable rating.",
            style: StyleConfig.fs14.copyWith(color: ThemeConfig.black),
          ),
          RatingBar(
              minRating: 1,
              initialRating: 1,
              ratingWidget: RatingWidget(
                  full: Icon(
                    Icons.star,
                    color: ThemeConfig.accentColor,
                  ),
                  half: Icon(Icons.star_half),
                  empty: Icon(Icons.star_border)),
              onRatingUpdate: (ratinData) {
                rating = ratinData;
              }),
          SizedBox(
            height: 10,
          ),
          SeoForms.cupertinoNoTitleLongTextField(commentController),
        ],
      ),
      actions: [
        CupertinoDialogAction(
            onPressed: () async {
              SEORoute.goAndRemoveAll(context, MainPage());
            },

            // color: Colors.grey,
            child: Text(
              "Close",
              style: StyleConfig.fs14cWhitefwNormal
                  .copyWith(color: ThemeConfig.darkGrey),
            )),
        CupertinoDialogAction(
            onPressed: () async {
              Navigator.pop(context);
              TripRepository.tripRating(
                  tripId, rating, commentController.text.trim());
              commentController.clear();
              rating = 1.0;
            },

            // color: Colors.grey,
            child: Text(
              "Submit",
              style: StyleConfig.fs14cWhitefwNormal
                  .copyWith(color: ThemeConfig.darkThemeColor),
            )),
      ],
    );
  }

  static _tripCancelledDialog(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => CupertinoAlertDialog(
        // key: _alertKey,
        title: Text(
          "Trip Cancelled",
          style: StyleConfig.fs14fwBold.copyWith(color: ThemeConfig.black),
        ),
        content: Text(
          "Your Trip is Cancelled by the driver. Your payment will be refunded. Please create a new trip.",
          style: StyleConfig.fs14.copyWith(color: ThemeConfig.black),
        ),
        actions: [
          CupertinoDialogAction(
            onPressed: () async {
              SEORoute.goAndRemoveAll(context, MainPage());
            },
            // color: Colors.grey,
            child: Text(
              "OK",
              style: StyleConfig.fs14cWhitefwNormal
                  .copyWith(color: ThemeConfig.green),
            ),
          ),
        ],
      ),
    );
    // print("dialog showed");
  }
}
