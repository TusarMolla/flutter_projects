import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ober_app/custom_widgets/loader.dart';
import 'package:ober_app/custom_widgets/seo_dialogs.dart';
import 'package:ober_app/custom_widgets/seo_toast.dart';
import 'package:ober_app/events/trip_pay_events.dart';
import 'package:ober_app/helpers/main_helper.dart';
import 'package:ober_app/others/seo_route.dart';
import 'package:ober_app/repositories/trip_repository.dart';
import 'package:ober_app/states/trip_pay_state.dart';
import 'package:ober_app/ui/pages/trip/trip_request_details.dart';

class TripPayBloc extends Bloc<TripPayEvents,TripPayState>{
  TripPayBloc():super(TripPayState.init()) {
    on<OnRequestTrip>((event, emit) => _requestForTrip(event,emit));
    on<OnRequestTripAgain>((event, emit) {
          _sendTripReq(event.context,canGoDetails: false);
    });
  }

  _requestForTrip(OnRequestTrip event,Emitter emitter)async{
    state.tripId = event.tripId;
    state.categoryid = event.categoryId;
    state.amount = event.amount;
    state.cardHolderName = event.holderName;
    state.cardNumber = event.cardNumber;
    state.expDate = event.expDate;
    state.cvc = event.cvc;
    await  _sendTripReq(event.context);
    emitter(state.update(state));

  }

  _sendTripReq(BuildContext context,{bool canGoDetails = true})async{
    Map<String,dynamic> data= {
      "transaction_amount":state.amount,
      "category_id":state.categoryid,
      "trip_id":state.tripId,
      "card_number":state.cardNumber,
      "cvc":state.cvc,
      "exp_date":state.expDate,
      "acount_holder_name":state.cardHolderName ,
    };

    Loader.show(context);
    var response = await TripRepository.requestATrip(data);
    Loader.hide();
    if(response.error !=null){
      Dialogs.info(context: context, content: mapToListOfString(response.error).join('\n'));
      return;
    }
    SEOToast.show(context, response.message);
    if(response.success ==true && canGoDetails) {
      SEORoute.go(context, TripRequestDetails(id: state.tripId,from: "BookingScreen",));
    }
  }

}