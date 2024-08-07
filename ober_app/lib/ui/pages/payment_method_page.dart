import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ober_app/blocs/booking_screen_bloc.dart';
import 'package:ober_app/blocs/ober_account_bloc.dart';
import 'package:ober_app/blocs/trip_pay_bloc.dart';
import 'package:ober_app/config/style_config.dart';
import 'package:ober_app/events/booking_screen_events.dart';
import 'package:ober_app/events/trip_pay_events.dart';
import 'package:ober_app/helpers/main_helper.dart';
import 'package:ober_app/main.dart';
import 'package:ober_app/models/trip_request_response.dart';
import 'package:ober_app/others/seo_input_formatters.dart';

class PaymentFormPage extends StatefulWidget {
  @override
  _PaymentFormPageState createState() => _PaymentFormPageState();
  final tripId;
 final VehicleCategory vehicleCategory;
  final amount;

  PaymentFormPage(this.tripId, this.vehicleCategory, this.amount);
}

class _PaymentFormPageState extends State<PaymentFormPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _cardNumberController = TextEditingController(text: globalState.currentState!.context.read<OberAccountBloc>().state.usersData?.cardNumber);
  final TextEditingController _expiryDateController = TextEditingController(text: globalState.currentState!.context.read<OberAccountBloc>().state.usersData?.expDate);
  final TextEditingController _cvvController = TextEditingController(text: globalState.currentState!.context.read<OberAccountBloc>().state.usersData?.cvc);
  final TextEditingController _cardHolderNameController =
      TextEditingController(text: globalState.currentState!.context.read<OberAccountBloc>().state.usersData?.cardHolderName);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(getLocal(context).payment_form),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(getLocal(context).card_info,style: StyleConfig.fs16fwBold,),
              Text("${getLocal(context).distance}: ${context.read<BookingScreenBloc>().state.totalDistance}"),
              Text("${getLocal(context).price}: ${priceWithSymbol(widget.vehicleCategory.rate)}"),
              SizedBox(height: 20,),

              TextFormField(
                controller: _cardNumberController,
                maxLength: 12,
                decoration: InputDecoration(
                  labelText: getLocal(context).card_number,
                  labelStyle: StyleConfig.fs14,
                  hintText: '1234 5678 9012 3456',
                   counterStyle: StyleConfig.fs14,
                  // counterText: ""
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || (value.isEmpty )) {
                    return 'Please enter your card number';
                  }else if(value.length<12){
                    return 'Card number must be 12 character';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _expiryDateController,
                decoration: InputDecoration(
                  labelText: getLocal(context).exp_date,
                  hintText: 'MM/YY',
                ),
                keyboardType: TextInputType.datetime,
                maxLength: 5,
                inputFormatters: [
                  CardExpFormatter()
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your card\'s expiry date';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _cvvController,
                decoration: InputDecoration(
                  labelText: getLocal(context).cvc,
                  hintText: '123',
                ),
                keyboardType: TextInputType.number,
                obscureText: true,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter your card\'s CVV';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _cardHolderNameController,
                decoration: InputDecoration(
                  labelText: 'Card Holder Name',
                ),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter the card holder\'s name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 32.0),
              Center(
                child: ElevatedButton(
                  child: Text(getLocal(context).pay_now),
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? true) {
                      // Process payment

                      String cardNumber = _cardNumberController.text.trim();
                      String cvc = _cvvController.text.trim();
                      String expDate = _expiryDateController.text.trim();
                      String holderName = _cardHolderNameController.text.trim();

                      context.read<TripPayBloc>().add(OnRequestTrip(
                            context: context,
                            tripId: widget.tripId,
                            amount: widget.amount.toString(),
                            categoryId: widget.vehicleCategory.id??0,
                            cardNumber: cardNumber,
                        cvc: cvc,
                        expDate: expDate,
                        holderName: holderName
                          ));
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
