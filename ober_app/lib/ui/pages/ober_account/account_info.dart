import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ober_app/blocs/ober_account_bloc.dart';
import 'package:ober_app/blocs/user_data_bloc.dart';
import 'package:ober_app/config/style_config.dart';
import 'package:ober_app/custom_widgets/decorations.dart';
import 'package:ober_app/custom_widgets/images.dart';
import 'package:ober_app/dummy_data.dart';
import 'package:ober_app/events/ober_account_events.dart';
import 'package:ober_app/helpers/main_helper.dart';
import 'package:ober_app/others/seo_route.dart';
import 'package:ober_app/others/system_data.dart';
import 'package:ober_app/states/ober_account_state.dart';
import 'package:ober_app/states/profile_state.dart';
import 'package:ober_app/ui/pages/ober_account/update_profile.dart';

class AccountInfo extends StatelessWidget {
  const AccountInfo({super.key});

  @override
  Widget build(BuildContext context) {


    return BlocBuilder<OberAccountBloc,OberAccountState>(
      builder: (context,state) {
        return Container(
          padding: EdgeInsets.only(
              top: 20, left: StyleConfig.padding, right: StyleConfig.padding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    getLocal(context).account_info,
                    style: StyleConfig.fs24,
                  ),
                  Spacer(),
                  InkWell(
                    onTap: () {
                      SEORoute.go(context, UpdateProfile());
                    },
                    child: Icon(Icons.edit),
                  )
                ],
              ),
              SizedBox(
                height: 14,
              ),
              SizedBox(
                height: 100,
                width: 100,
                child: ImageView.networkCircle(
                    imageUrl: getUserPhoto(context), height: 100, width: 100),
              ),
              SizedBox(height: 24,),
              Text(getLocal(context).basic_info,style: StyleConfig.fs18,),
              SizedBox(height: 14,),
              buildBasicInfoModel(getLocal(context).name,"${state.usersData?.firstName??''} ${state.usersData?.lastName??''}",context),
              SizedBox(height: 14,),
              buildBasicInfoModel(getLocal(context).phone_number,"${state.usersData?.phoneNumber??''}",context),
              SizedBox(height: 14,),

              BlocBuilder<UserDataBloc,UserDataState>(
                builder: (context,profileState) {
                  return buildBasicInfoModel(getLocal(context).email,profileState.email,context,canGo: false);
                }
              ),
            ],
          ),
        );
      }
    );
  }

  InkWell buildBasicInfoModel(String title,String data,BuildContext context,
      {bool canGo=true}) {
    return InkWell(
      onTap:canGo? (){



      }:null,
          child: Container(
            padding: EdgeInsets.all(8),
            decoration: Decorations.round(),
            // color: isDarkMode?ThemeConfig.extraDarkGrey:ThemeConfig.lightGrey,
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,style: StyleConfig.fs16,),
                    Text(data,style: StyleConfig.fs14,),
                  ],
                ),
              ],
            ),
          ),
        );
  }
}
