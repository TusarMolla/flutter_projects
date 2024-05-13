import 'package:flutter/material.dart';
import 'package:grostore/app_lang.dart';
import 'package:grostore/configs/style_config.dart';
import 'package:grostore/configs/theme_config.dart';
import 'package:grostore/custom_ui/BoxDecorations.dart';
import 'package:grostore/custom_ui/common_appbar.dart';
import 'package:grostore/helpers/device_info_helper.dart';
import 'package:grostore/models/currency_response.dart';
import 'package:grostore/models/language_response.dart';
import 'package:grostore/presenters/setting_presenter.dart';
import 'package:provider/provider.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<SettingPresenter>(context, listen: false).initState();
    });

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeConfig.xxlightGrey,
      appBar: CommonAppbar.show(
          title: AppLang.local(context).settings, context: context),
      body: Consumer<SettingPresenter>(builder: (context, data, child) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: StyleConfig.padding,),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20,),
              /* DropdownButton<LanguageInfo>(
          value: data.selectedLanguage,
            icon: const Icon(Icons.arrow_downward),
            elevation: 16,
            style: const TextStyle(color: Colors.deepPurple),
            underline: Container(
              height: 2,
              color: Colors.deepPurpleAccent,
            ),
            onChanged: (LanguageInfo? value) {
              // This is called when the user selects an item.
             if(value!=null) {
                    data.setLocale(value);
                  }
                },
            items: data.languageList.map<DropdownMenuItem<LanguageInfo>>((LanguageInfo value) {
              return DropdownMenuItem<LanguageInfo>(
                value: value,
                child: Text(value.name),
              );
            }).toList(),
          ),*/
              Text(AppLang.local(context).currency,style: StyleConfig.fs14fwBold,),
              SizedBox(height: 14,),
              Container(
                width: getWidth(context),
                padding: EdgeInsets.symmetric(horizontal: 14),
                decoration: BoxDecorations.customRadius(radius: BorderRadius.circular(5)).copyWith(color: ThemeConfig.white,),
                child: DropdownButton<CurrencyInfo>(
                  isExpanded: true,
                  value: data.selectedCurrency,
                  elevation: 16,
                  underline:const SizedBox.shrink(),
                  style: const TextStyle(color: Colors.deepPurple),
                  onChanged: (CurrencyInfo? value) {
                    // This is called when the user selects an item.
                    if (value != null) {
                      data.onChange(value);
                    }
                  },
                  items: data.currencyList
                      .map<DropdownMenuItem<CurrencyInfo>>((CurrencyInfo value) {
                    return DropdownMenuItem<CurrencyInfo>(
                      value: value,
                      child: Row(
                        children: [
                          Text(value.symbol,style: StyleConfig.fs14fwNormal,),
                         const SizedBox(width:5,),
                          Text(value.name,style: StyleConfig.fs14fwNormal,),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
