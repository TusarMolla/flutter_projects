import 'package:flutter/cupertino.dart';
import 'package:grostore/apis/address_api.dart';
import 'package:grostore/app_lang.dart';
import 'package:grostore/custom_ui/loading.dart';
import 'package:grostore/custom_ui/toast_ui.dart';
import 'package:grostore/models/city_response.dart';
import 'package:grostore/models/country_response.dart';
import 'package:grostore/models/edit_address_response.dart';
import 'package:grostore/models/state_response.dart';
import 'package:grostore/models/user/addresses_response.dart';

class AddressPresenter extends ChangeNotifier {
  static BuildContext? context;

  setContext(BuildContext context) {
    AddressPresenter.context = context;
  }

  List<AddressInfo> addresses = [];
  List<CountryInfo> countries = [];
  List<StateInfo> states = [];
  List<CityInfo> cities = [];
  List<CountryInfo> filteredCountries = [];
  List<StateInfo> filteredStates = [];
  List<CityInfo> filteredCities = [];

  String defaultAddress = "No";
  EditAddressResponse? editAddress;

  CountryInfo? selectedCountry;

  StateInfo? selectedState;

  CityInfo? selectedCity;

  bool isFetchAddress = false;

  TextEditingController addressController = TextEditingController();

  fetchAddresses() async {
    var res = await AddressApi.getAddresses();
    addresses.clear();
    addresses.addAll(res.object.data);
    isFetchAddress = true;
    notifyListeners();
  }

  initState() {
    fetchAddresses();
  }

 Future<void> onRefresh()async{
   return await fetchAddresses();
  }

  clear(){
    addresses.clear();
    isFetchAddress = false;
    notifyListeners();
  }

  filterCountry(String text) {
    filteredCountries.clear();
    if (text.isNotEmpty) {
      filteredCountries.addAll(countries.where((element) {
        return element.name.toLowerCase().contains(text.toLowerCase());
      }));
    } else {
      filteredCountries.addAll(countries);
    }
    notifyListeners();
  }

  filterState(String text) {
    filteredStates.clear();
    if (text.isNotEmpty) {
      filteredStates.addAll(states.where((element) {
        return element.name.toLowerCase().contains(text.toLowerCase());
      }));
    } else {
      filteredStates.addAll(states);
    }
    notifyListeners();
  }

  filterCity(String text) {
    filteredCities.clear();
    if (text.isNotEmpty) {
      filteredCities.addAll(cities.where((element) {
        return element.name.toLowerCase().contains(text.toLowerCase());
      }));
    } else {
      filteredCities.addAll(cities);
    }
    notifyListeners();
  }

  getCountries() async {
    var response = await AddressApi.getCountries();
    countries.addAll(response.object.data);

    if(editAddress!=null){
      countries.forEach((element) {
        if(element.id==editAddress!.data.countryId){
          setSelectedCountry(element);
        }
      });
    }

    filteredCountries.addAll(countries);
    notifyListeners();
  }

  getStates(id) async {
    var response = await AddressApi.getState(id);
    states.addAll(response.object.data);
    if(editAddress!=null){
      states.forEach((element) {
        if(element.id==editAddress!.data.stateId){
          setSelectedState(element);
        }
      });
    }
    filteredStates.addAll(states);
    notifyListeners();
  }

  getCities(id) async {
    var response = await AddressApi.getCity(id);
    cities.addAll(response.object.data);
    if(editAddress!=null){
      cities.forEach((element) {
        print(element.id);
        print(editAddress!.data.cityId);
        if(element.id==editAddress!.data.cityId){
          setSelectedCity(element);
        }
      });
    }

    notifyListeners();
  }

  setSelectedCountry(CountryInfo countryInfo) {
    selectedCountry = countryInfo;
    selectedState = null;
    selectedCity = null;
    getStates(countryInfo.id);
    notifyListeners();
  }

  setSelectedState(StateInfo stateInfo) {
    selectedState = stateInfo;
    selectedCity = null;
    getCities(stateInfo.id);
    notifyListeners();
  }

  setSelectedCity(CityInfo cityInfo) {
    selectedCity = cityInfo;
    notifyListeners();
  }

  setDefaultAddress(String? value) {
    if (value != null) {
      defaultAddress = value;
      notifyListeners();
    }
  }

  addAddress(BuildContext context,
      {required CountryInfo? countryInfo,
      required StateInfo? stateInfo,
      required CityInfo? cityInfo,
      required String? fullAddress,
      required int? isDefault}) async {
    if (!checkAddressValidation(context,
        countryInfo: countryInfo,
        stateInfo: stateInfo,
        cityInfo: cityInfo,
        fullAddress: fullAddress,
        isDefault: isDefault)) {
      return;
    }
    Loading.show(context);
    var response = await AddressApi.addAddress(
        countryId: countryInfo!.id,
        stateId: stateInfo!.id,
        cityId: cityInfo!.id,
        isDefault: isDefault!,
        address: fullAddress!);
    Loading.close();
    if (!context.mounted) return;
    ToastUi.show(context, response.object.message);
    if (response.object.result) {
      Navigator.pop(context);
    }
  }

  updateAddress(BuildContext context,
      {
        required int id,
        required CountryInfo? countryInfo,
      required StateInfo? stateInfo,
      required CityInfo? cityInfo,
      required String? fullAddress,
      required int? isDefault}) async {
    if (!checkAddressValidation(context,
        countryInfo: countryInfo,
        stateInfo: stateInfo,
        cityInfo: cityInfo,
        fullAddress: fullAddress,
        isDefault: isDefault)) {
      return;
    }
    Loading.show(context);
    var response = await AddressApi.updateAddress(
      id: id,
        countryId: countryInfo!.id,
        stateId: stateInfo!.id,
        cityId: cityInfo!.id,
        isDefault: isDefault!,
        address: fullAddress!);
    Loading.close();
    if (!context.mounted) return;
    ToastUi.show(context, response.object.message);
    if (response.object.result) {
      Navigator.pop(context);
    }
  }


  bool checkAddressValidation(BuildContext context,
      {required CountryInfo? countryInfo,
      required StateInfo? stateInfo,
      required CityInfo? cityInfo,
      required String? fullAddress,
      required int? isDefault}) {
    if (countryInfo == null) {
      ToastUi.show(context, AppLang.local(context).please_select_a_country);
      return false;
    }
    if (stateInfo == null) {
      ToastUi.show(context, AppLang.local(context).please_select_a_state);
      return false;
    }
    if (cityInfo == null) {
      ToastUi.show(context, AppLang.local(context).please_select_a_city);
      return false;
    }
    if (fullAddress == null || fullAddress.trim().isEmpty) {
      ToastUi.show(context, AppLang.local(context).please_enter_address);
      return false;
    }
    return true;
  }

  getEditAddressData(id,BuildContext context)async{
    Loading.show(context);
    var response =await AddressApi.editAddresses(id);
    Loading.close();
    if(response.statusCode==200 && response.object.result){
      editAddress= response.object;
      getCountries();
      //setSelectedCountry(CountryInfo(id: response.object.data.countryId, code: "0", name: response.object.data.countryName, isActive: true));
      //setSelectedState(StateInfo(id: response.object.data.stateId,name: response.object.data.stateName, isActive: true, countryId: response.object.data.countryId));
      //setSelectedCity(CityInfo(id: response.object.data.cityId,name: response.object.data.cityName, isActive: true, stateId: response.object.data.stateId));

      setDefaultAddress(editAddress!.data.isDefault==1?"Set Default":"No");
      addressController.text=response.object.data.address;
      notifyListeners();
    }
  }

  deleteAddress(id,BuildContext context)async{
    Loading.show(context);
    var response = await AddressApi.deleteAddress(id: id);
    Loading.close();
    ToastUi.show(context, response.object.message);
    onRefresh();
  }

}
