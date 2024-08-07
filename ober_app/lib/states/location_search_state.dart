import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ober_app/custom_models/ober_address_model.dart';
import 'package:ober_app/models/auto_complete_response.dart';

class LocationSearchState {
  LatLng? currentLocation;
  OberAddressModel? pickupAddress;
  OberAddressModel? dropOffAddress;
  String locationDetails;
  Completer<GoogleMapController> controller;
  TextEditingController pickupLocationController ;
  TextEditingController dropOffLocationController ;
  bool isShownBottomSheet;
  DraggableScrollableController draggableController;
  ActiveLocationField currentActiveField;

  List<Prediction> autoCompleteLocations;
  Prediction? selectedLocation ;
  FocusNode focusNode;


  LocationSearchState(
      {required this.currentLocation,required this.locationDetails,required this.controller,required this.dropOffLocationController,required this.pickupLocationController,required this.isShownBottomSheet,required this.draggableController,required this.dropOffAddress,required this.pickupAddress,required this.autoCompleteLocations,required this.selectedLocation,required this.focusNode,required this.currentActiveField});

  LocationSearchState.init():
  controller  = Completer<GoogleMapController>(),
  locationDetails = "",
  pickupLocationController = TextEditingController(),
  dropOffLocationController = TextEditingController(),
  isShownBottomSheet= true,
  draggableController = DraggableScrollableController(),
  autoCompleteLocations = [],
  currentActiveField = ActiveLocationField.DropOff,
  focusNode = FocusNode();
  update(LocationSearchState oldState){
    return LocationSearchState(currentLocation: oldState.currentLocation, locationDetails: oldState.locationDetails, controller: oldState.controller,pickupLocationController: oldState.pickupLocationController,dropOffLocationController: oldState.dropOffLocationController,isShownBottomSheet: oldState.isShownBottomSheet,draggableController: oldState.draggableController,pickupAddress: oldState.pickupAddress,dropOffAddress: oldState.dropOffAddress,autoCompleteLocations: oldState.autoCompleteLocations,selectedLocation: oldState.selectedLocation,focusNode: oldState.focusNode,currentActiveField: oldState.currentActiveField);
  }
}

enum ActiveLocationField{
  PickUp,DropOff;
}