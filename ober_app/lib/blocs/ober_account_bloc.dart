import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ober_app/custom_widgets/loader.dart';
import 'package:ober_app/custom_widgets/seo_dialogs.dart';
import 'package:ober_app/custom_widgets/seo_toast.dart';
import 'package:ober_app/events/ober_account_events.dart';
import 'package:ober_app/helpers/main_helper.dart';
import 'package:ober_app/helpers/seo_date_formatter.dart';
import 'package:ober_app/repositories/profile_repository.dart';
import 'package:ober_app/states/ober_account_state.dart';

class OberAccountBloc extends Bloc<OberAccountEvents, OberAccountState>{
  OberAccountBloc():super(OberAccountState.inti()){
    on<InitData>((event, emit) => _init(emit));
    on<OnPickDate>((event, emit)=>_updateDob(event, emit));
    on<OnPickImage>((event, emit)=>_onPickedImg(event, emit));
    on<ProfileUpdate>((event, emit)=>_updateInfo(event, emit));
  }

  _updateDob(OnPickDate data,Emitter emit){
    state.dob = data.dob;
    return emit(state.update(state));
  }

  _onPickedImg(OnPickImage data,Emitter emit){
    state.selectedPhoto = data.file;
    return emit(state.update(state));

  }

  _updateInfo(ProfileUpdate event,emit)async{
    String firstName= state.firstNameController.text.trim();
    String lastName= state.lastNameController.text.trim();
    String phoneNumber= state.phoneNumberController.text.trim();
    String country= state.countryController.text.trim();
    String city= state.cityController.text.trim();
    String socialNoTxt= state.socialController.text.trim();
    String postalCode= state.postalCodeController.text.trim();
    String address= state.addressController.text.trim();
    String cardHolderName= state.cardHolderNameController.text.trim();
    String cardNumber= state.cardNumberController.text.trim();
    String expDate= state.expDateController.text.trim();
    String cvc= state.cvcController.text.trim();
    String dob= state.dob.yearMonthDay();
    File? image = state.selectedPhoto;

    Map<String,String> body = {
      "first_name":firstName,
      "last_name":lastName,
      "dob":dob,
      "phone_number":phoneNumber,
      "address":address,
      "city":city,
      "social_number":socialNoTxt,
      "postal_code":postalCode,
      "country":country,
      "card_holder_name":cardHolderName,
      "card_number":cardNumber,
      "exp_date":expDate,
      "cvc":cvc,
    };
    print(body);
    Loader.show(event.context);
    var tmp = await ProfileRepository.update(body, image, "image");
    print(tmp.error);
    Loader.hide();
    if(event.context.mounted){
      if(tmp.error !=null){
        if(tmp.message !=null){
        Dialogs.info(context: event.context, content: tmp.message);
        return;
        }
        Dialogs.info(context: event.context, content: mapToListOfString(tmp.messages).join("\n"));
        return;
      }
      SEOToast.show(event.context, tmp.message);
      _clearUpdateData();
      event.context.read<OberAccountBloc>().add(InitData());
      return emit(state.update(state));
    }



  }

  _clearUpdateData(){
    state.firstNameController = TextEditingController();
    state.lastNameController = TextEditingController();
    state.phoneNumberController = TextEditingController();
    state.addressController = TextEditingController();
    state.countryController = TextEditingController();
    state.cityController = TextEditingController();
    state.socialController = TextEditingController();
    state.dob = DateTime.now();
    state.postalCodeController = TextEditingController();
    state.selectedPhoto = null;
  }

  _init(Emitter emit)async{
    var tmp = await ProfileRepository.getDetails();
    state.usersData = tmp.data;
    state.firstNameController.text = tmp.data?.firstName??"";
    state.lastNameController.text = tmp.data?.lastName??"";
    state.phoneNumberController.text = tmp.data?.phoneNumber??"";
    state.countryController.text = tmp.data?.country??"";
    state.cityController.text = tmp.data?.city??"";
    state.postalCodeController.text = tmp.data?.postalCode??"";
    state.addressController.text = tmp.data?.address??"";
    state.dob = (tmp.data?.dob??DateTime.now());
    state.socialController.text = tmp.data?.socialNumber??"";
    state.cardHolderNameController.text = tmp.data?.cardHolderName??"";
    state.cardNumberController.text = tmp.data?.cardNumber??"";
    state.expDateController.text = tmp.data?.expDate??"";
    state.cvcController.text = tmp.data?.cvc ??"";
   return emit(state.update(state));
  }

}