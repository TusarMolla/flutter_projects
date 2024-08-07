import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ober_app/blocs/ober_account_bloc.dart';
import 'package:ober_app/config/style_config.dart';
import 'package:ober_app/config/theme_config.dart';
import 'package:ober_app/custom_widgets/seoAppbar.dart';
import 'package:ober_app/events/ober_account_events.dart';
import 'package:ober_app/helpers/device_info.dart';
import 'package:ober_app/helpers/main_helper.dart';
import 'package:ober_app/states/ober_account_state.dart';
import 'package:ober_app/ui/pages/ober_account/account_info.dart';
import 'package:ober_app/ui/pages/ober_account/ober_security.dart';
import 'package:ober_app/ui/pages/ober_account/privacy_and_data.dart';


class OberAccountPage extends StatelessWidget {
  const OberAccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<OberAccountBloc>().add(InitData());
    return  BlocBuilder<OberAccountBloc,OberAccountState>(
      builder: (context,data) {
        return Scaffold(
          appBar: SeoAppbar.build(title: getLocal(context).ober_account,bottom: PreferredSize(
            preferredSize: Size(DeviceInfo.width,20),
            child: TabBar(
              controller: data.tabController,
              labelColor: isDarkMode?ThemeConfig.lightGrey:ThemeConfig.extraDarkGrey,
              indicatorColor: isDarkMode?ThemeConfig.lightGrey:ThemeConfig.extraDarkGrey,
              dividerHeight: 0,
              onTap: (index){

              },
              tabs: [
                buildTabModel(getLocal(context).account_info),
                buildTabModel(getLocal(context).security),
                buildTabModel(getLocal(context).privacy),
              ],

            ),
          )),
          body: TabBarView(
              controller: data.tabController,
              children: [
            AccountInfo(),
            Security(),
            PrivacyAndData(),

          ]),
        );
      }
    );
  }

  Text buildTabModel(String txt) => Text(txt,style: StyleConfig.fs16,);

}
