import 'package:flutter/material.dart';
import 'package:grostore/app_lang.dart';
import 'package:grostore/configs/style_config.dart';
import 'package:grostore/configs/theme_config.dart';
import 'package:grostore/custom_ui/BoxDecorations.dart';
import 'package:grostore/custom_ui/Button.dart';
import 'package:grostore/custom_ui/common_appbar.dart';
import 'package:grostore/custom_ui/input_decorations.dart';
import 'package:grostore/custom_ui/toast_ui.dart';
import 'package:grostore/helpers/device_info_helper.dart';
import 'package:grostore/models/city_response.dart';
import 'package:grostore/models/country_response.dart';
import 'package:grostore/models/state_response.dart';
import 'package:grostore/presenters/address_presenter.dart';

class AddressNewOrUpdate extends StatefulWidget {
  int? addressId;

  AddressNewOrUpdate({super.key, this.addressId});

  @override
  State<AddressNewOrUpdate> createState() => _AddressNewOrUpdateState();
}

class _AddressNewOrUpdateState extends State<AddressNewOrUpdate> {
  AddressPresenter addressPresenter = AddressPresenter();

  @override
  void initState() {
    // TODO: implement initState
    if (widget.addressId != null) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        addressPresenter.getEditAddressData(widget.addressId, context);
      });
    }else{
      addressPresenter.getCountries();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppbar.show(
          title: widget.addressId == null
              ? AppLang.local(context).add_new_address_ucf
              : AppLang.local(context).update_address,
          context: context),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(StyleConfig.padding),
          child: ListenableBuilder(
              listenable: addressPresenter,
              builder: (context, child) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //buildLabelText(AppLang.local(context).country),
                    space(size: 10),
                    // buildButton(AppLang.local(context).select_country,
                    //     addressPresenter.selectedCountry?.name ?? "", () {
                    //   showCountryDialog();
                    // }),
                    countryDropDown(),
                    space(),
                    //buildLabelText(AppLang.local(context).state),
                    //space(size: 10),
                    // buildButton(AppLang.local(context).select_state,
                    //     addressPresenter.selectedState?.name ?? '', () {
                    //   if (addressPresenter.selectedCountry != null) {
                    //     showStateDialog();
                    //   } else {
                    //     ToastUi.show(context,
                    //         AppLang.local(context).please_select_a_country);
                    //   }
                    // }),
                    stateDropDown(),
                    space(),
                    // buildLabelText(AppLang.local(context).city),
                    // space(size: 10),
                    // buildButton(AppLang.local(context).select_city,
                    //     addressPresenter.selectedCity?.name ?? '', () {
                    //   if (addressPresenter.selectedState != null) {
                    //     showCityDialog();
                    //   } else {
                    //     ToastUi.show(context,
                    //         AppLang.local(context).please_select_a_state);
                    //   }
                    // }),
                    cityDropDown(),
                    space(),
                    isDefaultDropDown(),
                    space(),
                    Container(
                      height: 100,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      decoration: BoxDecorations.customRadius(
                              radius: BorderRadius.circular(8))
                          .copyWith(
                              border: Border.all(color: ThemeConfig.grey)),
                      child: TextField(
                        controller: addressPresenter.addressController,
                        decoration: const InputDecoration.collapsed(
                            hintText: "2/5 Elephant Road, New Town"),
                      ),
                    ),
                    space(),
                    Button(
                        onPressed: () {
                          if (widget.addressId != null) {
                            addressPresenter.updateAddress(context,
                                id: widget.addressId!,
                                countryInfo: addressPresenter.selectedCountry,
                                stateInfo: addressPresenter.selectedState,
                                cityInfo: addressPresenter.selectedCity,
                                fullAddress: addressPresenter
                                    .addressController.text
                                    .trim(),
                                isDefault:
                                    addressPresenter.defaultAddress == "No"
                                        ? 0
                                        : 1);
                          } else {
                            addressPresenter.addAddress(context,
                                countryInfo: addressPresenter.selectedCountry,
                                stateInfo: addressPresenter.selectedState,
                                cityInfo: addressPresenter.selectedCity,
                                fullAddress: addressPresenter
                                    .addressController.text
                                    .trim(),
                                isDefault:
                                    addressPresenter.defaultAddress == "No"
                                        ? 0
                                        : 1);
                          }
                        },
                        shape: StyleConfig.buttonRadius(8),
                        color: ThemeConfig.accentColor,
                        minWidth: getWidth(context),
                        minHeight: 40.0,
                        child: Text(
                          AppLang.local(context).save,
                          style: StyleConfig.fs14cWhitefwBold,
                        ))
                  ],
                );
              }),
        ),
      ),
    );
  }

  Text buildLabelText(String text) => Text(
        text,
        style: StyleConfig.fs14fwBold,
      );

  Widget space({size = 24}) {
    return SizedBox(
      height: size.toDouble(),
    );
  }
  
 

  Button buildButton(String title, value, onPress) {
    return Button(
        onPressed: () => onPress(),
        color: ThemeConfig.grey,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(8), topLeft: Radius.circular(8))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 120,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecorations.customRadius(
                  radius: const BorderRadius.only(
                      bottomLeft: Radius.circular(8),
                      topLeft: Radius.circular(8)),
                  color: ThemeConfig.secondaryColor),
              child: Text(
                title,
                style: StyleConfig.fs14cWhitefwNormal,
              ),
            ),
            Container(
              constraints: BoxConstraints(maxWidth: getWidth(context) * 0.5),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              //decoration: BoxDecorations.customRadius(radius: BorderRadius.only(bottomRight: Radius.circular(8),topRight: Radius.circular(8)),color: ThemeConfig.grey),
              child: Text(
                value,
                style: StyleConfig.fs14cWhitefwNormal,
                maxLines: 1,
              ),
            ),
            const Spacer(),
            const Icon(Icons.arrow_drop_down_outlined)
          ],
        ));
  }

  Widget countryDropDown(){
    return DropdownButtonFormField<CountryInfo>(
      decoration: InputDecoration(
          labelText: AppLang.local(context).select_country,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: ThemeConfig.accentColor)
        ),
      ),
      value: addressPresenter.selectedCountry,
      onChanged: (CountryInfo? country) {
        if(country!=null){
          addressPresenter.setSelectedCountry(country);
        }
      },
      dropdownColor: Colors.white,
      items:addressPresenter.countries.map<DropdownMenuItem<CountryInfo>>((e) =>DropdownMenuItem(
        value: e,
        child: Text(e.name,style: StyleConfig.fs14fwNormal,),
      ) ).toList(),
    );
  }

  Widget stateDropDown(){
    return DropdownButtonFormField<StateInfo>(
      decoration: InputDecoration(
          labelText: AppLang.local(context).select_state,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: ThemeConfig.accentColor)
        ),
      ),
      value: addressPresenter.selectedState,
      onChanged: (StateInfo? state) {
        if(state!=null) {
          addressPresenter.setSelectedState(state);
        }
      },
      dropdownColor: Colors.white,
      items:addressPresenter.states.map<DropdownMenuItem<StateInfo>>((e) =>DropdownMenuItem(
        value: e,
        child: Text(e.name,style: StyleConfig.fs14fwNormal,),
      ) ).toList(),
    );
  }

  Widget cityDropDown(){
    return DropdownButtonFormField<CityInfo>(
      decoration: InputDecoration(
          labelText: AppLang.local(context).select_city,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: ThemeConfig.accentColor)
        ),
      ),
      value: addressPresenter.selectedCity,
      onChanged: (CityInfo? city) {
        if(city!=null) {
          addressPresenter.setSelectedCity(city);
        }
      },
      dropdownColor: Colors.white,
      items:addressPresenter.cities.map<DropdownMenuItem<CityInfo>>((e) =>DropdownMenuItem(
        value: e,
        child: Text(e.name,style: StyleConfig.fs14fwNormal,),
      ) ).toList(),
    );
  }

  Widget isDefaultDropDown(){
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
          labelText: AppLang.local(context).default_address,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: ThemeConfig.accentColor)
        ),
      ),
      onChanged: (String? value) {
        if(value!=null) {
          addressPresenter.setDefaultAddress(value);
        }
      },
      value: addressPresenter.defaultAddress,
      dropdownColor: Colors.white,
      items:["No", "Set Default"].map<DropdownMenuItem<String>>((e) =>DropdownMenuItem(
        value: e,
        child: Text(e,style: StyleConfig.fs14fwNormal,),
      ) ).toList(),
    );
  }
/*

showCountryDialog() {
    showDialog(
        context: context,
        builder: (context) => ListenableBuilder(
            listenable: addressPresenter,
            builder: (context, child) {
              return AlertDialog(
                title: TextField(
                    onChanged: (text) {
                      print(text);
                      addressPresenter.filterCountry(text);
                    },
                    decoration: InputDecorations.basic(hint_text: "search...")),
                content: Container(
                  height: 250,
                  child: SingleChildScrollView(
                    child: Column(
                        children: List.generate(
                            addressPresenter.filteredCountries.length,
                            (index) => Button(
                                  onPressed: () {
                                    Navigator.pop(context);

                                  },
                                  child: Container(
                                      constraints: BoxConstraints(
                                          minWidth: getWidth(context)),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 10),
                                      margin: EdgeInsets.only(bottom: 10),
                                      decoration: BoxDecorations.basic(),
                                      child: Text(
                                        addressPresenter
                                            .filteredCountries[index].name,
                                        style: StyleConfig.fs14fwNormal,
                                      )),
                                ))),
                  ),
                ),
                actions: [
                  Button(
                      color: ThemeConfig.grey,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        AppLang.local(context).close,
                        style: StyleConfig.fs14cWhitefwNormal,
                      ))
                ],
              );
            }));
  }
  showStateDialog() {
    showDialog(
        context: context,
        builder: (context) => ListenableBuilder(
            listenable: addressPresenter,
            builder: (context, child) {
              return AlertDialog(
                title: TextField(
                    onChanged: (text) {
                      addressPresenter.filterState(text);
                    },
                    decoration: InputDecorations.basic(hint_text: "search...")),
                content: Container(
                  height: 250,
                  child: SingleChildScrollView(
                    child: Column(
                        children: List.generate(
                            addressPresenter.filteredStates.length,
                            (index) => Button(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    addressPresenter.setSelectedState(
                                        addressPresenter.filteredStates[index]);
                                  },
                                  child: Container(
                                      constraints: BoxConstraints(
                                          minWidth: getWidth(context)),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 10),
                                      margin: EdgeInsets.only(bottom: 10),
                                      decoration: BoxDecorations.basic(),
                                      child: Text(
                                        addressPresenter
                                            .filteredStates[index].name,
                                        style: StyleConfig.fs14fwNormal,
                                      )),
                                ))),
                  ),
                ),
                actions: [
                  Button(
                      color: ThemeConfig.grey,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        AppLang.local(context).close,
                        style: StyleConfig.fs14cWhitefwNormal,
                      ))
                ],
              );
            }));
  }

  showCityDialog() {
    showDialog(
        context: context,
        builder: (context) => ListenableBuilder(
            listenable: addressPresenter,
            builder: (context, child) {
              return AlertDialog(
                title: TextField(
                    onChanged: (text) {
                      addressPresenter.filterCity(text);
                    },
                    decoration: InputDecorations.basic(hint_text: "search...")),
                content: Container(
                  height: 250,
                  child: SingleChildScrollView(
                    child: Column(
                        children: List.generate(
                            addressPresenter.filteredCities.length,
                            (index) => Button(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    addressPresenter.setSelectedCity(
                                        addressPresenter.filteredCities[index]);
                                  },
                                  child: Container(
                                      constraints: BoxConstraints(
                                          minWidth: getWidth(context)),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 10),
                                      margin: EdgeInsets.only(bottom: 10),
                                      decoration: BoxDecorations.basic(),
                                      child: Text(
                                        addressPresenter
                                            .filteredCities[index].name,
                                        style: StyleConfig.fs14fwNormal,
                                      )),
                                ))),
                  ),
                ),
                actions: [
                  Button(
                      color: ThemeConfig.grey,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        AppLang.local(context).close,
                        style: StyleConfig.fs14cWhitefwNormal,
                      ))
                ],
              );
            }));
  }
*/

}
