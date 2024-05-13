import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grostore/app_lang.dart';
import 'package:grostore/configs/theme_config.dart';
import 'package:grostore/custom_ui/Boxdecorations.dart';
import 'package:grostore/custom_ui/common_appbar.dart';
import 'package:grostore/custom_ui/shimmers.dart';
import 'package:grostore/helpers/device_info_helper.dart';
import 'package:grostore/helpers/shared_value_helper.dart';
import 'package:grostore/presenters/stock_locations_presenter.dart';
import 'package:toast/toast.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class StockLocations extends StatefulWidget {
  StockLocations({Key? key}) : super(key: key);

  @override
  _StockLocationsState createState() => _StockLocationsState();
}

class _StockLocationsState extends State<StockLocations> {



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
Provider.of<StockLocationsPresenter>(context,listen: false).setContext(context);
  }
  @override
  void dispose() {
    super.dispose();
  }

@override
  void didChangeDependencies() {

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: buildAppBar(context),
        body: Consumer<StockLocationsPresenter>(
          builder: (context,data,child) {
            return RefreshIndicator(
              //color: MyTheme.accent_color,
              backgroundColor: Colors.white,
              onRefresh: data.onRefresh,
              displacement: 0,
              child: CustomScrollView(
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                slivers: [
                  SliverList(
                    delegate: SliverChildListDelegate([
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: buildLanguageMethodList(data),
                      ),
                    ]),
                  )
                ],
              ),
            );
          }
        ));
  }

  AppBar buildAppBar(BuildContext context) {
    return CommonAppbar.show(title: AppLang.local(context).locations, context: context);
  }

  buildLanguageMethodList(StockLocationsPresenter data) {
    if (!data.isLocationInit && data.locations.length == 0) {
      return SingleChildScrollView(
          child: Shimmers.list(10, getWidth(context), 20));
    } else if (data.locations.length > 0) {
      return SingleChildScrollView(
        child: ListView.separated(
          separatorBuilder: (context, index) {
            return SizedBox(
              height: 14,
            );
          },
          itemCount: data.locations.length,
          scrollDirection: Axis.vertical,
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return buildCard(index,data);
          },
        ),
      );
    } else if (data.isLocationInit && data.locations.isEmpty) {
      return Container(
          height: 100,
          child: Center(
              child: Text(
           AppLang.local(context).data_is_not_available,
            style: TextStyle(color: ThemeConfig.fontColor),
          )));
    }
  }

  GestureDetector buildCard(index,StockLocationsPresenter data) {
    return GestureDetector(
      onTap: () {
        print(data.locations[index].id);
       data.onchange(data.locations[index].id);
      },
      child: Stack(
        children: [
          AnimatedContainer(
            duration: Duration(milliseconds: 400),
            decoration: BoxDecorations.basic().copyWith(
                border: Border.all(
                    color: stock_location_id.$ == data.locations[index].id.toString()
                        ? ThemeConfig.accentColor: ThemeConfig.lightGrey,
                    width: stock_location_id.$ == data.locations[index].id.toString() ? 1.0 : 0.0)),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 150,
                    height: 50,
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Text(
                        "${data.locations[index].name}",
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: ThemeConfig.fontColor,
                            fontSize: 14,
                            height: 1.6,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ]),
          ),
           // Positioned(
           //        left: 16,
           //        top: 16,
           //        child: buildCheckContainer(data.selectedIndex == index),
           //      )

        ],
      ),
    );
  }

  // Container buildCheckContainer(bool check) {
  //   return check
  //       ? Container(
  //           height: 16,
  //           width: 16,
  //           decoration: BoxDecoration(
  //               borderRadius: BorderRadius.circular(16.0), color: Colors.green),
  //           child: Padding(
  //             padding: const EdgeInsets.all(3),
  //             child: Icon(Icons.check, color: Colors.white, size: 10),
  //           ),
  //         )
  //       : Container();
  // }

}
