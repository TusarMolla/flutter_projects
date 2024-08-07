



import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:ober_app/events/seo_event.dart';

class OberAccountEvents extends SeoEvent{

}
class InitData extends OberAccountEvents{

}

class OnPickDate extends OberAccountEvents{
  DateTime dob;
  OnPickDate(this.dob);
}

class OnPickImage extends OberAccountEvents{
  File file;

  OnPickImage(this.file);
}

class ProfileUpdate extends OberAccountEvents{
  BuildContext context;

  ProfileUpdate(this.context);
}