import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ober_app/blocs/user_data_bloc.dart';
import 'package:ober_app/config/style_config.dart';
import 'package:ober_app/custom_widgets/images.dart';
import 'package:ober_app/custom_widgets/seoAppbar.dart';
import 'package:ober_app/dummy_data.dart';
import 'package:ober_app/helpers/main_helper.dart';
import 'package:ober_app/others/seo_route.dart';
import 'package:ober_app/others/system_data.dart';
import 'package:ober_app/states/profile_state.dart';
import 'package:ober_app/ui/pages/settings/apperance_page.dart';
import 'package:ober_app/ui/pages/settings/language_page.dart';
import 'package:ober_app/ui/pages/ober_account/ober_account_page.dart';




class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SeoAppbar.build(title: "Settings"),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: StyleConfig.padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildAccountRow(context),
            SizedBox(height: 14,),
            Text("App Settings",style: StyleConfig.fs18fwBold,),
            /*buildAppSettingsItem(context,"Add Home",Icons.home,Container()),
            Divider(),
            buildAppSettingsItem(context,"Add Work",Icons.work,Container()),
            Divider(),
            buildAppSettingsItem(context,"Shortcuts",Icons.add_location_sharp,Container()),
            Divider(),
*/
             buildAppSettingsItem(context,"Privacy",Icons.lock,Container()),
            Divider(),
             buildAppSettingsItem(context,"Appearance",Icons.change_circle_outlined,AppearancePage()),
            Divider(),
            buildAppSettingsItem(context,getLocal(context).language,Icons.translate,LanguagePage()),
            Divider(),

          ],
        ),
      ),
    );
  }

  Padding buildAppSettingsItem(BuildContext context,String title,IconData data,Widget goto) {
    return Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: (){
                SEORoute.go(context, goto);
              },
              child: Row(
                children: [
                  Icon(data,size: 18,),
                  SizedBox(width: 10,),
                  Text(title,style: StyleConfig.fs14,),

                  Spacer(),
                  Icon(Icons.arrow_forward_ios,size: 18,)
                ],
              ),
            ),
          );
  }

  Widget buildAccountRow(BuildContext context) {
    return InkWell(
      onTap: (){
        SEORoute.go(context, OberAccountPage());
      },
      child: Row(
              children: [
                Flexible(
                    flex: 2,
                    child: ImageView.networkCircle(imageUrl: getUserPhoto(context), height: 80, width: 80)),
                BlocBuilder<UserDataBloc,UserDataState>(
                  builder: (context,profileData) {
                    return Flexible(
                      fit: FlexFit.tight,
                        flex: 6,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                          Text(getUsername(context),style: StyleConfig.fs16,),
                          Text(profileData.email,style: StyleConfig.fs14,),
                                          ],
                                        ),
                        ));
                  }
                ),
                Spacer(),
                Icon(Icons.arrow_forward_ios,size: 18,),
      
              ],
            ),
    );
  }
}
