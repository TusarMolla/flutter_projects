import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ober_app/blocs/main_bloc.dart';
import 'package:ober_app/blocs/ober_account_bloc.dart';
import 'package:ober_app/blocs/user_data_bloc.dart';
import 'package:ober_app/config/theme_config.dart';
import 'package:ober_app/events/home_events.dart';
import 'package:ober_app/events/ober_account_events.dart';
import 'package:ober_app/events/profile_events.dart';
import 'package:ober_app/helpers/auth.dart';
import 'package:ober_app/states/main_state.dart';
import 'package:ober_app/ui/pages/account_page.dart';
import 'package:ober_app/ui/pages/activity/activity_page.dart';
import 'package:ober_app/ui/pages/home_page.dart';
import 'package:ober_app/ui/pages/services_page.dart';
import 'package:ober_app/ui/pages/tickets/tickets.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<UserDataBloc>().add(UserDataEvent());
    context.read<OberAccountBloc>().add(InitData());
    Auth.getRating();

    return  BlocBuilder<MainBloc,MainState>(
      builder: (context,data) {
        return Scaffold(
          body: body(data),

          bottomNavigationBar: BottomNavigationBar(
             currentIndex: data.currentIndex,
            selectedItemColor: ThemeConfig.accentColor,
            unselectedItemColor: ThemeConfig.grey,
            onTap: (index){
              context.read<MainBloc>().add(OnChangeIndex(index)) ;
            },
            items: [
            BottomNavigationBarItem(icon: Icon(Icons.home),label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.apps),label: "Services"),
            BottomNavigationBarItem(icon: Icon(Icons.receipt_long),label: "Activity"),
            BottomNavigationBarItem(icon: Icon(Icons.account_circle_sharp),label: "Account"),
          ],

          ),
        );
      }
    );
  }

  body(MainState mainState){
    switch(mainState.currentIndex){
      case 0:
        return HomePage();
      case 1: return Tickets()  ;
      case 2: return ActivityPage();
      case 3: return AccountPage();
    }
  }

}
