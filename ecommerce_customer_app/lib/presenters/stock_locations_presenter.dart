


import 'package:flutter/cupertino.dart';
import 'package:grostore/apis/locations_api.dart';
import 'package:grostore/helpers/shared_value_helper.dart';
import 'package:grostore/models/locations_response.dart';

class StockLocationsPresenter extends ChangeNotifier{
  static BuildContext? context;
  setContext(BuildContext context){
    StockLocationsPresenter.context=context;
  }

  List<LocationInfo> locations=[];
  bool isLocationInit=false;
  int selectedIndex=0;


  fetchLocations(BuildContext context) async {
    locations =[];
    var res = await LocationApi.getLocations(context);
    locations.addAll(res.object.data);
    isLocationInit = true;
  await  stock_location_id.load();
    if(stock_location_id.$.isEmpty){
      locations.forEach((element) {
        if(element.isDefault) {
          stock_location_id.$ = element.id.toString();
        }
      });
    }

    notifyListeners();
  }

  onchange(id){
    stock_location_id.$=id.toString();
    notifyListeners();
  }

  cleanAll(){
    locations=[];
     isLocationInit=false;
  }

  initState(){
    cleanAll();
    fetchLocations(context!);
  }

 Future<void> onRefresh(){
    cleanAll();
    fetchLocations(context!);
   return Future.delayed(Duration.zero);
  }

}