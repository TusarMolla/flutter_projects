
import'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:ober_app/custom_models/dropdown_model.dart';
import 'package:ober_app/models/ticket_detail_response.dart';
import 'package:ober_app/models/ticket_list_response.dart';

class TicketState{

  List<TicketData> data = [];
  bool isDataInit = false;

  bool isDetailsInit = false;
  TicketDetail? details ;

  // List<ReplyData> replyData = [];
  bool isReplyDataInit = false;
  int? page = 1;
  ScrollController scrollController = ScrollController();
 static final List<DropDownDataModel> priorities =   [
    DropDownDataModel("high","High"),
    DropDownDataModel("medium","Medium"),
    DropDownDataModel("low","Low")
  ];
  DropDownDataModel? selectedPriority=priorities.first;

  TextEditingController subjectEditController = TextEditingController();
  TextEditingController messageEditController = TextEditingController();
  TextEditingController replyMessageEditController = TextEditingController();

  File? attachment;
  File? replyAttachment;


  TicketState update(TicketState oldState ){
    var newState = TicketState();
    newState.data = oldState.data;
    newState.isDataInit = oldState.isDataInit;
    newState.page = oldState.page;
    newState.selectedPriority=oldState.selectedPriority;
    newState.subjectEditController.text=oldState.subjectEditController.text;
    newState.messageEditController.text=oldState.messageEditController.text;
    newState.attachment=oldState.attachment;
    newState.replyAttachment=oldState.replyAttachment;
    newState.replyMessageEditController.text=oldState.replyMessageEditController.text;
    newState.isReplyDataInit =oldState.isReplyDataInit;
    newState.isDetailsInit = oldState.isDetailsInit;
    newState.details = oldState.details;
    // newState.replyData = oldState.replyData;
    return newState;
  }

Map<String,String>  postBody(){
    return {
      "subject":subjectEditController.text.trim(),
      "priority":selectedPriority?.key??"3",
      "description":messageEditController.text.trim(),
    };


  }

Map<String,String>  replyBody(id){
    return {
      // "ticket_id":id,
      "message":replyMessageEditController.text.trim()
    };


  }

 Map<String,File?> fileBody(){
    return {
      "attachments":attachment
    };
  }

}