import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:grostore/app_lang.dart';
import 'package:grostore/configs/theme_config.dart';
import 'package:grostore/custom_classes/system_data.dart';
import 'package:grostore/helpers/common_functions.dart';
import 'package:grostore/helpers/route.dart';
import 'package:grostore/models/product_mini_response.dart';
import 'package:grostore/presenters/main_persenter.dart';
import 'package:grostore/presenters/stock_locations_presenter.dart';
import 'package:grostore/screens/auth/login.dart';
import 'package:grostore/screens/cart.dart';
import 'package:provider/provider.dart';
import '../presenters/cart_presenter.dart';

class Main extends StatefulWidget {
  const Main({super.key});

  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  @override
  void initState() {
    Provider.of<MainPresenter>(context, listen: false).setContext(context);
    Future.delayed(Duration(seconds: 1)).then((value) {
      Provider.of<StockLocationsPresenter>(context, listen: false)
          .fetchLocations(context);
    });

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MainPresenter>(builder: (context, data, child) {
      return WillPopScope(
        onWillPop: () async {
          if (data.bottomAppbarIndex != 0) {
            data.onTapped(0);
          } else {
            return Future.delayed(Duration.zero);
          }
          return Future.delayed(Duration.zero);
        },
        child: Scaffold(
          extendBody: true,
          body: data.bottomAppbarChildren[data.bottomAppbarIndex],
          bottomNavigationBar: SizedBox(
            height: 90,
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              onTap: data.onTapped,
              currentIndex: data.bottomAppbarIndex,
              backgroundColor: Colors.white.withOpacity(0.95),
              unselectedItemColor: Color.fromRGBO(168, 175, 179, 1),
              selectedItemColor: ThemeConfig.accentColor,
              selectedLabelStyle: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: ThemeConfig.accentColor,
                  fontSize: 12),
              unselectedLabelStyle: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: Color.fromRGBO(168, 175, 179, 1),
                  fontSize: 12),
              items: [
                BottomNavigationBarItem(
                    icon: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Image.asset(
                        getAssetIcon("home.png"),
                        color: data.bottomAppbarIndex == 0
                            ? ThemeConfig.accentColor
                            : ThemeConfig.grey,
                        height: 16,
                      ),
                    ),
                    label: AppLang.local(context).home),
                BottomNavigationBarItem(
                    icon: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Image.asset(
                        getAssetIcon("categories.png"),
                        color: data.bottomAppbarIndex == 1
                            ? ThemeConfig.accentColor
                            : ThemeConfig.grey,
                        height: 16,
                      ),
                    ),
                    label: AppLang.local(context).categories),
                BottomNavigationBarItem(
                    icon: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Image.asset(
                        getAssetIcon("orders.png"),
                        color: data.bottomAppbarIndex == 2
                            ? ThemeConfig.accentColor
                            : Color.fromRGBO(153, 153, 153, 1),
                        height: 16,
                      ),
                    ),
                    label: AppLang.local(context).orders),
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Image.asset(
                      getAssetIcon("profile.png"),
                      color: data.bottomAppbarIndex == 3
                          ? ThemeConfig.accentColor
                          : ThemeConfig.grey,
                      height: 16,
                    ),
                  ),
                  label: AppLang.local(context).profile,
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              if (SystemData.isLogIn) {
                MakeRoute.go(context, Cart());
              } else {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Login()));
                return;
              }
            },
            backgroundColor: ThemeConfig.amber,
            child: badges.Badge(
              position: badges.BadgePosition.custom(end: 12, bottom: -15),
              badgeStyle: badges.BadgeStyle(
                  shape: badges.BadgeShape.circle,
                  badgeColor: ThemeConfig.red,
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(width: 1, color: ThemeConfig.white)
                  //padding: EdgeInsets.all(5),
                  ),
              badgeContent: Consumer<CartPresenter>(
                builder: (context, cart, child) {
                  return Text(
                    "${cart.cartResponse.cartCount}",
                    style: TextStyle(fontSize: 10, color: Colors.white),
                  );
                },
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Image.asset(
                  getAssetIcon("cart.png"),
                  color: ThemeConfig.white,
                  height: 20,
                ),
              ),
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
        ),
      );
    });
  }
}
