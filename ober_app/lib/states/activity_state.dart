import 'dart:io';
import 'package:ober_app/custom_models/dropdown_model.dart';
import 'package:ober_app/models/trip_detail_response.dart';
import 'package:ober_app/models/trip_list_response.dart';
import 'package:flutter/material.dart';

class ActivityState {
  List<TripData> trips;

 static List<DropDownDataModel> filters = [
    DropDownDataModel("", "All"),
    DropDownDataModel("3", "Cancelled"),
    DropDownDataModel("2", "Completed"),
  ];
  DropDownDataModel? selectedFilter ;

  bool isTripInit;
  int currentPage;
  int lastPage;
  TextEditingController subjectController;
  TextEditingController messageController;
  File? selectedFile ;
  bool isDetailsInit;

  TripDetailsResponse? detailsResponse;

  ActivityState(
      {required this.trips,
      required this.currentPage,
      required this.lastPage,
        required this.messageController,
        required this.subjectController,
        required this.selectedFile,
      required this.isTripInit,
        required this.isDetailsInit,
      required this.detailsResponse,
        required this.selectedFilter
      });

  ActivityState.init()
      : trips = [],
        isTripInit = false,
        currentPage = 1,
  subjectController = TextEditingController(),
  messageController = TextEditingController(),
  selectedFilter = ActivityState.filters.first,
  isDetailsInit  = false,
        lastPage = 1;

  ActivityState update(ActivityState state) {
    return ActivityState(
        trips: state.trips,
        currentPage: state.currentPage,
        lastPage: state.lastPage,
        isTripInit: state.isTripInit,
      messageController: state.messageController,
      selectedFile: state.selectedFile,
      subjectController: state.subjectController,
      detailsResponse: state.detailsResponse,
      isDetailsInit: state.isDetailsInit,
      selectedFilter: state.selectedFilter
    );
  }
}
