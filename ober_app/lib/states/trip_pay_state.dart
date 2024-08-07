



class TripPayState{
  var tripId;
  var categoryid;
  var amount;
  String cardNumber;
  String cardHolderName;
  String expDate;
  String cvc;


  TripPayState(
      {
        required this.tripId,
        required this.categoryid,
        required this.amount,
        required this.cardNumber,
        required this.cardHolderName,
        required this.expDate,
        required this.cvc
      });

  TripPayState.init():
      cardNumber="",
      cardHolderName="",
      expDate="",
      cvc="";

 TripPayState update(TripPayState state){
    return TripPayState(tripId: state.tripId, categoryid: state.categoryid, amount: state.amount, cardNumber: state.cardNumber,
        cardHolderName: state.cardHolderName, expDate: state.expDate, cvc: state.cvc);
  }

}