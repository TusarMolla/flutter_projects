import 'dart:io';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ober_app/custom_models/dropdown_model.dart';

typedef SeoOnDropDownSelect = Function(DropDownDataModel? data);
typedef SeoOnDateSelect = Function(DateTime? data);
typedef SeoOnFileSelect = Function(File? file);
typedef OnMapCameraMove = Function(CameraPosition position);
