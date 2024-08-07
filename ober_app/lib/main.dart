import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ober_app/blocs/location_search_bloc.dart';
import 'package:ober_app/blocs/setting_bloc.dart';
import 'package:ober_app/config/app_config.dart';
import 'package:ober_app/config/theme_config.dart';
import 'package:ober_app/events/location_search_events.dart';
import 'package:ober_app/events/setting_events.dart';
import 'package:ober_app/helpers/device_info.dart';
import 'package:ober_app/helpers/shared_value_helper.dart';
import 'package:ober_app/others/seo_pusher.dart';
import 'package:ober_app/bolc_providers.dart';
import 'package:ober_app/states/setting_state.dart';
import 'package:ober_app/ui/pages/splash_screen.dart';
import 'package:shared_value/shared_value.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main(){
  WidgetsFlutterBinding.ensureInitialized();
  SeoPusher.init();


  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(
      SharedValue.wrapApp(
          MultiBlocProvider(
              providers: BlocProviders.get,
              child: const MyApp())
      )
      );
}

GlobalKey<NavigatorState> globalState = GlobalKey<NavigatorState>();


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    themeMode.load().then((value)
    {

      context.read<SettingBloc>().add(ChangeMode(ThemeMode.values[themeMode.$]));
    });
    DeviceInfo.context ??= context;
    context.read<LocationSearchBloc>().add(SetUserCurrentLocation());
     langCode.load().then((value) {
       SettingState.languages.forEach((element) {
         if(element.key == langCode.$){
           context.read<SettingBloc>().add(ChangeLang(element));
         }
       });
    });

    return BlocBuilder<SettingBloc,SettingState>(
      builder: (context,state) {
        return MaterialApp(
          navigatorKey: globalState,
          title: AppConfig.appName,
          darkTheme: ThemeData(
              inputDecorationTheme: InputDecorationTheme(
                filled: true,
                  fillColor: ThemeConfig.darkGrey,
                  focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: ThemeConfig.white)
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: ThemeConfig.noColor)
                  ),
                  contentPadding: const EdgeInsets.only(left: 14,right: 10),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: ThemeConfig.noColor)
                  )
              ),
              dropdownMenuTheme: DropdownMenuThemeData(textStyle: TextStyle(color:ThemeConfig.white )),
              appBarTheme: const AppBarTheme(
                backgroundColor: ThemeConfig.darkThemeColor,
                titleTextStyle: TextStyle(color: ThemeConfig.white),
                iconTheme:IconThemeData(color: ThemeConfig.white)
              ),
              scaffoldBackgroundColor:ThemeConfig.darkThemeColor,
              textTheme: TextTheme(bodySmall: TextStyle(color: ThemeConfig.white,fontSize: 14),bodyMedium: TextStyle(color: ThemeConfig.white,fontSize: 16,),bodyLarge:TextStyle(color: ThemeConfig.white,fontSize: 18,) ,  ),

              iconTheme: const IconThemeData(color:ThemeConfig.white)),
          themeMode:state.mode,
          theme: ThemeData(
            dropdownMenuTheme: DropdownMenuThemeData(textStyle: TextStyle(color:ThemeConfig.fontColor )),
              textTheme: TextTheme(bodySmall: TextStyle(color: ThemeConfig.fontColor,fontSize: 14),bodyMedium: TextStyle(color: ThemeConfig.fontColor,fontSize: 16,),bodyLarge:TextStyle(color: ThemeConfig.fontColor,fontSize: 18,) ,  ),
              iconTheme: IconThemeData(color:ThemeConfig.fontColor),
            inputDecorationTheme: InputDecorationTheme(
              filled: true,
                fillColor: ThemeConfig.lightGrey,
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: ThemeConfig.darkGrey)
                ),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: ThemeConfig.noColor)
                ),
                contentPadding: const EdgeInsets.only(left: 14,right: 10),
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: ThemeConfig.noColor)
                )
            ),
            // scaffoldBackgroundColor: Colors.black,
            // This is the theme of your application.
            //
            // TRY THIS: Try running your application with "flutter run". You'll see
            // the application has a purple toolbar. Then, without quitting the app,
            // try changing the seedColor in the colorScheme below to Colors.green
            // and then invoke "hot reload" (save your changes or press the "hot
            // reload" button in a Flutter-supported IDE, or press "r" if you used
            // the command line to start the app).
            //
            // Notice that the counter didn't reset back to zero; the application
            // state is not lost during the reload. To reset the state, use hot
            // restart instead.
            //
            // This works for code too, not just values: Most code changes can be
            // tested with just a hot reload.
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,

          ),
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            AppLocalizations.delegate
          ],
          supportedLocales: [
            Locale('en'), // English
            Locale('is'), // Spanish
          ],
          locale:Locale(state.selectedLang.key),
          home: SplashScreen(),
        );
      }
    );
  }
}


