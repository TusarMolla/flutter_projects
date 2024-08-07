


import 'package:flutter/material.dart';
import 'package:ober_app/events/seo_event.dart';

class TripPayEvents extends SeoEvent{

}


class OnRequestTripAgain extends TripPayEvents{
  BuildContext context;
  OnRequestTripAgain(this.context);
}
class OnRequestTrip extends TripPayEvents{
  BuildContext context;
  int categoryId,tripId;
  String amount,cardNumber,cvc,expDate,holderName;

  OnRequestTrip(
      {
        required this.context,
        required this.categoryId,
        required this.tripId,
        required this.amount,
        required this.cardNumber,
        required this.cvc,
        required this.expDate,
        required this.holderName});
}
