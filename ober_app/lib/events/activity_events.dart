



import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:ober_app/custom_models/dropdown_model.dart';
import 'package:ober_app/events/seo_event.dart';

class ActivityEvents extends SeoEvent{


}

class InitData extends ActivityEvents{

}

class OnRefresh extends ActivityEvents{

}

class ChooseFile extends ActivityEvents{
  File file;

  ChooseFile(this.file);
}

class OnSubmitComplain extends ActivityEvents{
  BuildContext context;
  var tripId;

  OnSubmitComplain(this.context,this.tripId);
}

class OnDetails extends ActivityEvents{
  final id;

  OnDetails(this.id);
}

class OnChangeFilter extends ActivityEvents{
  DropDownDataModel data;

  OnChangeFilter(this.data);
}