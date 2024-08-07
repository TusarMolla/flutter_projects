import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ober_app/custom_widgets/seo_vnc.dart';
import 'package:ober_app/models/profile_info_response.dart';

class OberAccountState {
  TabController tabController;

  ProfileData? usersData;
  bool isUserDataInit;

  TextEditingController firstNameController;

  TextEditingController lastNameController;

  TextEditingController phoneNumberController;
  TextEditingController addressController;
  TextEditingController countryController;
  TextEditingController cityController;
  TextEditingController socialController;
  TextEditingController cardHolderNameController;
  TextEditingController cardNumberController;
  TextEditingController expDateController;
  TextEditingController cvcController;
  DateTime dob;
  File? selectedPhoto;
  TextEditingController postalCodeController;

  OberAccountState(
      {required this.tabController,
      required this.usersData,
      required this.firstNameController,
      required this.lastNameController,
      required this.phoneNumberController,
      required this.addressController,
      required this.countryController,
      required this.cityController,
      required this.socialController,
      required this.dob,
        required this.isUserDataInit,
      required this.postalCodeController,
        required this.selectedPhoto,
        required this.cardHolderNameController,
        required this.cardNumberController,
        required this.cvcController,
        required this.expDateController


      });

  OberAccountState.inti()
      : firstNameController = TextEditingController(),
        lastNameController = TextEditingController(),
        phoneNumberController = TextEditingController(),
        addressController = TextEditingController(),
        countryController = TextEditingController(),
        cityController = TextEditingController(),
        socialController = TextEditingController(),
        dob = DateTime.now(),
        postalCodeController = TextEditingController(),
        isUserDataInit=false,
        tabController = TabController(length: 3, vsync: SEOVnc(),

        ),
  cardHolderNameController =TextEditingController(),
  cardNumberController =TextEditingController(),
  expDateController =TextEditingController(),
  cvcController =TextEditingController()

  ;

  update(OberAccountState state) {
    OberAccountState newState = OberAccountState(
        addressController: state.addressController,
        cityController: state.cityController,
        countryController: state.countryController,
        dob: state.dob,
        firstNameController: state.firstNameController,
        lastNameController: state.lastNameController,
        phoneNumberController: state.phoneNumberController,
        postalCodeController: state.postalCodeController,
        socialController: state.socialController,
        tabController: state.tabController,
        usersData: state.usersData,
      selectedPhoto: state.selectedPhoto,
      isUserDataInit: state.isUserDataInit,
      cardHolderNameController: state.cardHolderNameController,
      cardNumberController: state.cardNumberController,
      cvcController: state.cvcController,
      expDateController: state.expDateController,
    );
    return newState;
  }
}
