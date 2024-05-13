import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grostore/app_lang.dart';
import 'package:grostore/configs/app_config.dart';
import 'package:grostore/configs/theme_config.dart';
import 'package:grostore/helpers/common_functions.dart';
import 'package:grostore/presenters/address_presenter.dart';
import 'package:grostore/presenters/auth/auth_presenter.dart';
import 'package:grostore/presenters/cart_presenter.dart';
import 'package:grostore/presenters/categories_presenter.dart';
import 'package:grostore/presenters/check_out_presenter.dart';
import 'package:grostore/presenters/coupon_presenter.dart';
import 'package:grostore/presenters/filter_presenter.dart';
import 'package:grostore/presenters/home_presenter.dart';
import 'package:grostore/presenters/landing_page_presenter.dart';
import 'package:grostore/presenters/order_details_presenter.dart';
import 'package:grostore/presenters/setting_presenter.dart';
import 'package:grostore/presenters/main_persenter.dart';
import 'package:grostore/presenters/order_presenter.dart';
import 'package:grostore/presenters/product_details_presenter.dart';
import 'package:grostore/presenters/refund_presenter.dart';
import 'package:grostore/presenters/stock_locations_presenter.dart';
import 'package:grostore/presenters/user_presenter.dart';
import 'package:grostore/presenters/wallet_presenter.dart';
import 'package:grostore/presenters/wishlist_presenter.dart';
import 'package:grostore/screens/home.dart';
import 'package:grostore/screens/landing_pages/landing_page.dart';
import 'package:grostore/screens/main.dart';

import 'package:grostore/screens/splash.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:one_context/one_context.dart';

import 'package:provider/provider.dart';
import 'package:shared_value/shared_value.dart';

void main() {
  runApp(SharedValue.wrapApp(
   const MyApp(),
  ));
}

/// The route configuration.
final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
    path: '/',
    builder: (BuildContext context, GoRouterState state) {
      return const Splash();
    },
  ),
    GoRoute(
      path: '/landing-page',
      builder: (BuildContext context, GoRouterState state) {
        return const LandingPage();
      },
    ),

  ],
);



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=>SettingPresenter()),
        ChangeNotifierProvider(create: (context)=>AuthPresenter()),
        ChangeNotifierProvider(create: (context)=>MainPresenter()),
        ChangeNotifierProvider(create: (context)=>LandingPagePresenter()),
        ChangeNotifierProvider(create: (context)=>CartPresenter()),
        ChangeNotifierProvider(create: (context)=>HomePresenter()),
        ChangeNotifierProvider(create: (context)=>ProductDetailsPresenter()),
        ChangeNotifierProvider(create: (context)=>StockLocationsPresenter()),
        ChangeNotifierProvider(create: (context)=>UserPresenter(),),
        ChangeNotifierProvider(create: (context)=>OrderPresenter()),
        ChangeNotifierProvider(create: (context)=>CheckOutPresenter()),
        ChangeNotifierProvider(create: (context)=>CategoriesPresenter()),
        ChangeNotifierProvider(create: (context)=>FilterPresenter()),
        ChangeNotifierProvider(create: (context)=>CouponPresenter()),
        ChangeNotifierProvider(create: (context)=>WishlistPresenter()),
        ChangeNotifierProvider(create: (context)=>AddressPresenter()),
        ChangeNotifierProvider(create: (context)=>WalletPresenter()),
        ChangeNotifierProvider(create: (context)=>RefundPresenter()),
        ChangeNotifierProvider(create: (context)=>OrderDetailsPresenter()),

      ],
      child: Consumer<SettingPresenter>(
        builder: (context,data,child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: AppConfig.appName,
            theme: ThemeData(
              //primaryTextTheme:GoogleFonts.lobsterTextTheme() ,
              primaryColor: ThemeConfig.accentMaterialColor,
              primarySwatch:ThemeConfig.accentMaterialColor,
              textTheme: GoogleFonts.interTextTheme().copyWith(

              ),

              //textTheme:
            ),
            //builder: OneContext().builder,
            themeMode: ThemeMode.light,
            locale: data.locale,
            localeResolutionCallback: (deviceLocale, supportedLocales) {
              if (AppLocalizations.delegate.isSupported(deviceLocale!)) {
                return deviceLocale;
              }
              return const Locale('en');
            },
            localizationsDelegates: [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: AppLang().supportedLocales(),
            // home: Splash(),
            initialRoute: '/',
            routes: {
              "/":(context)=> Splash(),
              "/home":(context)=>Home(id: getQueryParameter(context,"id"),),
              "/main":(context)=>Main(),
              "/landing_page":(context)=>LandingPage(),
            },

          );
        }
      ),
    );
  }
}
