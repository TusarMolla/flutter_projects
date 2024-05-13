
import 'package:flutter/cupertino.dart';
import 'package:grostore/apis/currency_api.dart';
import 'package:grostore/apis/language_api.dart';
import 'package:grostore/custom_classes/system_data.dart';
import 'package:grostore/models/currency_response.dart';
import 'package:grostore/models/language_response.dart';

import '../helpers/shared_value_helper.dart';

class SettingPresenter extends ChangeNotifier{



  Locale _locale=Locale(app_language.$,'');

  List<CurrencyInfo> currencyList=[];
  List<LanguageInfo> languageList=[];
  LanguageInfo? selectedLanguage ;
  CurrencyInfo? selectedCurrency ;

  fetchCurrencyListData()async{
    currencyList.clear();
    var res = await CurrencyApi().getList();

    currencyList.addAll(res.object.data);

    print("Currency");
    currencyList.forEach((element) {
      if(system_currency.$.isEmpty && element.isDefault){
        print("Currency isDefault");
        onChange(element);
      }else
      if(system_currency.$.isNotEmpty && element.code == system_currency.$){
        print("Currency not isDefault");
        print(element.toJson());
        onChange(element);
      }
    });

    notifyListeners();
  }

  fetchLanguageListData()async{
    languageList.clear();
    var res = await LanguageApi.getLanguages();
    languageList.addAll(res.object.data);
    languageList.forEach((element) {
      if(app_language.$ == element.code){
        selectedLanguage = element;
      }
    });
    notifyListeners();
  }

  onChange(CurrencyInfo currency){
    if(currency!=null) {
      selectedCurrency = currency;
      // SystemData.systemCurrency = currency;
      system_currency.$ = currency.code;
      system_currency.save();
      notifyListeners();
    }
  }

  Locale get locale {
    //print("app_mobile_language.isEmpty${app_mobile_language.$.isEmpty}");
    return _locale ;
  }

  void setLocale(LanguageInfo languageInfo){
    _locale = Locale(languageInfo.code,'');
    selectedLanguage= languageInfo;
    notifyListeners();
  }


  initState(){
    fetchCurrencyListData();
    fetchLanguageListData();
  }

}