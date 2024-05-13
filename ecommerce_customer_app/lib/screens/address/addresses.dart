import 'package:flutter/material.dart';
import 'package:grostore/app_lang.dart';
import 'package:grostore/configs/style_config.dart';
import 'package:grostore/configs/theme_config.dart';
import 'package:grostore/custom_ui/Boxdecorations.dart';
import 'package:grostore/custom_ui/Button.dart';
import 'package:grostore/custom_ui/common_appbar.dart';
import 'package:grostore/custom_ui/filter_dropdown.dart';
import 'package:grostore/custom_ui/shimmers.dart';
import 'package:grostore/helpers/device_info_helper.dart';
import 'package:grostore/helpers/route.dart';
import 'package:grostore/presenters/address_presenter.dart';
import 'package:grostore/presenters/user_presenter.dart';
import 'package:grostore/screens/address/address_new_or_update.dart';
import 'package:provider/provider.dart';

class Addresses extends StatefulWidget {
  const Addresses({super.key});

  @override
  State<Addresses> createState() => _AddressesState();
}

class _AddressesState extends State<Addresses> {
  @override
  void initState() {
    // TODO: implement initState

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<AddressPresenter>(context, listen: false).initState();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppbar.show(
        title: AppLang.local(context).address,
        context: context,
        bottom: PreferredSize(
          preferredSize: Size(getWidth(context), 40),
          child: Button(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            minWidth: getWidth(context) - (StyleConfig.padding * 2),
            shape: StyleConfig.buttonRadius(2)
                .copyWith(side: BorderSide(color: ThemeConfig.extraDarkGrey)),
            onPressed: () {
              MakeRoute.go(context, AddressNewOrUpdate());
            },
            child: Text(
              AppLang.local(context).add_new_address_ucf,
              style: StyleConfig.fs14fwNormal,
            ),
          ),
        ),
      ),
      body: Consumer<AddressPresenter>(builder: (context, data, child) {
        return addresses(data);
      }),
    );
  }

  Widget addresses(AddressPresenter data) {
    return RefreshIndicator(
      onRefresh: data.onRefresh,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: StyleConfig.padding),
        //color: Colors.red,

        width: getWidth(context),
        child: data.isFetchAddress
            ? ListView.separated(
                itemCount: data.addresses.length,
                padding: EdgeInsets.symmetric(
                    horizontal: StyleConfig.padding, vertical: 10),
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  return Container(
                    padding: const EdgeInsets.all(10),
                    width: getWidth(context),
                    decoration: BoxDecorations.shadow(radius: 8).copyWith(
                        border: Border.all(width: 2, color: ThemeConfig.grey)),
                    child: Stack(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data.addresses[index].address,
                              style: StyleConfig.fs14fwNormal,
                              maxLines: 1,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 5.0),
                              child: Row(
                                children: [
                                  Text(
                                    "${AppLang.local(context).city}: ",
                                    style: StyleConfig.fs14fwBold,
                                  ),
                                  Text(
                                    data.addresses[index].cityName,
                                    style: StyleConfig.fs14fwNormal,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 5.0),
                              child: Row(
                                children: [
                                  Text(
                                    "${AppLang.local(context).state}: ",
                                    style: StyleConfig.fs14fwBold,
                                  ),
                                  Text(
                                    data.addresses[index].stateName,
                                    style: StyleConfig.fs14fwNormal,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 5.0),
                              child: Row(
                                children: [
                                  Text(
                                    "${AppLang.local(context).country}: ",
                                    style: StyleConfig.fs14fwBold,
                                  ),
                                  Text(
                                    data.addresses[index].countryName,
                                    style: StyleConfig.fs14fwNormal,
                                  ),
                                ],
                              ),
                            ),

                          ],
                        ),
                        Positioned(
                          top: 0,
                            right: 0,
                            child: Column(
                          children: [
                            SizedBox(
                              height: 25,
                              width: 25,
                              child: Button(
                                onPressed: (){
                                  MakeRoute.go(context, AddressNewOrUpdate(addressId:data.addresses[index].id ,));
                                },
                                padding: EdgeInsets.zero,
                                minWidth: 10.0,
                                minHeight: 10.0,
                                child:Icon(Icons.edit,),
                              ),
                            ),
                           const SizedBox(height: 15,),
                            SizedBox(
                              height: 25,
                              width: 25,
                              child: Button(
                                onPressed: (){
                                  data.deleteAddress(data.addresses[index].id , context);
                                },
                                padding: EdgeInsets.zero,
                                minWidth: 10.0,
                                minHeight: 10.0,
                                child:Icon(Icons.delete,),
                              ),
                            ),
                          ],
                        ))
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return SizedBox(
                    height: 10,
                  );
                },
              )
            : Shimmers.list(10, getWidth(context) * 0.5, 100),
      ),
    );
  }
}
