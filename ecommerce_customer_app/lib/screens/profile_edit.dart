import 'dart:convert';
import 'dart:io';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:grostore/app_lang.dart';
import 'package:grostore/configs/style_config.dart';
import 'package:grostore/configs/theme_config.dart';
import 'package:grostore/custom_classes/system_data.dart';
import 'package:grostore/custom_ui/BoxDecorations.dart';
import 'package:grostore/custom_ui/Button.dart';
import 'package:grostore/custom_ui/Image_view.dart';
import 'package:grostore/custom_ui/input_decorations.dart';
import 'package:grostore/helpers/device_info_helper.dart';
import 'package:grostore/presenters/user_presenter.dart';
import 'package:provider/provider.dart';


class ProfileEdit extends StatefulWidget {
  @override
  _ProfileEditState createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(context),
      body: Consumer<UserPresenter>(
        builder: (context,data,child) {
          return buildBody(data);
        }
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      centerTitle: false,
      leading: Builder(
        builder: (context) => IconButton(
          icon: Icon(Icons.arrow_left, color: ThemeConfig.darkGrey),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      title: Text(
        AppLang.local(context).edit_profile_ucf,
        style: TextStyle(fontSize: 16, color: ThemeConfig.fontColor,fontWeight: FontWeight.bold),
      ),
      elevation: 0.0,
      titleSpacing: 0,
    );
  }

 Widget buildBody(UserPresenter data) {
    
      return RefreshIndicator(
        onRefresh: data.refresh,
        color: ThemeConfig.accentColor,
        backgroundColor: Colors.white,
        //onRefresh: _onPageRefresh,
        displacement: 10,
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate([
                buildTopSection(data),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),

                ),
                buildProfileForm(data)
              ]),
            )
          ],
        ),
      );
    
  }

  buildTopSection(UserPresenter data) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
          child: Stack(
            children: [

              data.file!=null?ImageView.roundFileImage(file:File(data.file!.path),height: 120.0,width: 120.0,context: context, radius: 60):ImageView.round(url:SystemData.userInfo.avatar,height: 120.0,width: 120.0,context: context, radius: 60),
/*
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(
                      color: Color.fromRGBO(112, 112, 112, .3), width: 2),
                  //shape: BoxShape.rectangle,
                ),
                child: ClipRRect(
                    clipBehavior: Clip.hardEdge,
                    borderRadius: BorderRadius.all(Radius.circular(100.0)),
                    child: FadeInImage.assetNetwork(
                      placeholder: 'assets/placeholder.png',
                      image: "${avatar_original.$}",
                      fit: BoxFit.fill,
                    )),
              ),*/
              Positioned(
                right: 8,
                bottom: 8,
                child: SizedBox(
                  width: 24,
                  height: 24,
                  child: Button(
                    padding: EdgeInsets.all(0),
                    shape: CircleBorder(
                      side:
                          new BorderSide(color: ThemeConfig.lightGrey),
                    ),
                    color: ThemeConfig.lightGrey,
                    onPressed: () {
                      data.chooseAndUploadImage(context);
                    },
                    child: Icon(
                      Icons.edit,
                      color: ThemeConfig.fontColor,
                      size: 14,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  buildProfileForm(UserPresenter data) {
    return Padding(
      padding:
          const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 16.0, right: 16.0),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildBasicInfo(data),

            buildChangePassword(data),
          ],
        ),
      ),
    );
  }

  Column buildChangePassword(UserPresenter data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30.0,bottom: 10),
                child: Text(
                  AppLang.local(context).password_change_ucf,
                  style: StyleConfig.fs14fwBold,
                  textHeightBehavior: TextHeightBehavior(applyHeightToFirstAscent: false),
                  textAlign: TextAlign.center,
                  softWrap: false,
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(bottom: 4.0),
                child: Text(
                  AppLang.local(context).password,
                  style: TextStyle(
                    fontSize: 12,
                      color: ThemeConfig.fontColor, fontWeight: FontWeight.normal),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      decoration: BoxDecorations.basic(),
                      height: 36,
                      child: TextField(
                        style: TextStyle(fontSize: 12),
                        controller: data.passwordController,
                        autofocus: false,
                        obscureText: !data.showPassword,
                        enableSuggestions: false,
                        autocorrect: false,
                        decoration: InputDecorations.basic(
                            hint_text: "• • • • • • • •").copyWith(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: ThemeConfig.accentColor),

                            ),
                            suffixIcon: InkWell(
                              onTap: (){
                                data.passwordShowHide();
                              },
                              child: Icon(data.showPassword?Icons.visibility_outlined:Icons.visibility_off_outlined,
                                color: ThemeConfig.accentColor,
                              ),
                            ),),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Text(
                        AppLang.local(context)
                            .password_must_be_at_last_6_digit,
                        style: TextStyle(
                            color: ThemeConfig.accentColor,
                            fontStyle: FontStyle.italic),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 4.0),
                child: Text(
                  AppLang.local(context)
                      .confirm_password_ucf,
                  style: TextStyle(
                    fontSize: 12,
                      color: ThemeConfig.fontColor, fontWeight: FontWeight.normal),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Container(
                  decoration: BoxDecorations.basic(),
                  height: 36,
                  child: TextField(
                    controller: data.passwordConfirmController,
                    autofocus: false,
                    obscureText: !data.showConfirmPassword,
                    enableSuggestions: false,
                    autocorrect: false,
                    decoration: InputDecorations.basic(
                        hint_text: "• • • • • • • •").copyWith(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: ThemeConfig.accentColor),

                        ),
                        suffixIcon: InkWell(
                          onTap: (){
                            data.conPasswordShowHide();
                          },
                          child: Icon(data.showConfirmPassword?Icons.visibility_outlined:Icons.visibility_off_outlined,
                            color: ThemeConfig.accentColor,
                          ),
                        )),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  alignment: Alignment.center,
                  width: 150
                  ,
                  child: Button(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    minWidth: MediaQuery.of(context).size.width,
                    color: ThemeConfig.accentColor,
                    shape: RoundedRectangleBorder(
                        borderRadius:
                        const BorderRadius.all(Radius.circular(8.0))),
                    child: Text(
                      AppLang.local(context).update_password_ucf,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    ),
                    onPressed: () {
                      data.onPressUpdatePassword(context);
                    },
                  ),
                ),
              ),
            ],
          );
  }

  Column buildBasicInfo(UserPresenter data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 18.0),
                child: Text(
                  AppLang.local(context).basic_info,
                  style: StyleConfig.fs14fwBold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 4.0),
                child: Text(
                  AppLang.local(context).name,
                  style: TextStyle(
                    fontSize: 12,
                      color: ThemeConfig.fontColor, fontWeight: FontWeight.normal),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 14.0),
                child: Container(
                  decoration: BoxDecorations.basic(),
                  height: 36,
                  child: TextField(
                    controller: data.nameController,
                    autofocus: false,
                    style: TextStyle(color:ThemeConfig.fontColor,fontSize: 12),
                    decoration: InputDecorations.basic(
                        hint_text: "John Doe").copyWith(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: ThemeConfig.accentColor),

                        ),),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 4.0),
                child: Text(
                  AppLang.local(context).phone,
                  style: TextStyle(
                    fontSize: 12,
                      color: ThemeConfig.fontColor, fontWeight: FontWeight.normal),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 14.0),
                child: Container(
                  decoration: BoxDecorations.basic(),
                  height: 36,
                  child: TextField(
                    controller: data.phoneController,
                    autofocus: false,
                    keyboardType:TextInputType.phone,
                    style: TextStyle(color:ThemeConfig.fontColor,fontSize: 12),
                    decoration: InputDecorations.basic(
                        hint_text: "+01xxxxxxxxxx").copyWith(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: ThemeConfig.accentColor),

                        ),),
                  ),
                ),
              ),


              Visibility(
                visible: true,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 4.0),
                      child: Text(
                        AppLang.local(context).email,
                        style: TextStyle(
                          fontSize: 12,
                            color: ThemeConfig.fontColor,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 14.0),
                      child: Container(
                        decoration: BoxDecorations.basic(),
                        height: 36,
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        alignment: Alignment.centerLeft,
                        child: Text(data.emailController.text,style: TextStyle(fontSize: 12,color: ThemeConfig.grey),)
                        /*TextField(
                          style: TextStyle(color:ThemeConfig.grey_153,fontSize: 12),
                          enabled: false,
                          enableIMEPersonalizedLearning: true,
                          controller: _emailController,
                          autofocus: false,
                          decoration: InputDecorations.buildInputDecoration_1(

                              hint_text: "jhon@example.com").copyWith(
                            //enabled: false,
                        labelStyle: TextStyle(color: ThemeConfig.grey_153),
                        enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        ),

                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,

                        ),),
                        ),*/
                      ),
                    ),
                  ],
                ),
              ),

              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  alignment: Alignment.center,
                  width: getWidth(context)/2.5,
                  child:Button(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    minWidth: MediaQuery.of(context).size.width,
                    color: ThemeConfig.accentColor,
                    shape: RoundedRectangleBorder(
                        borderRadius:
                        const BorderRadius.all(Radius.circular(8.0))),
                    child: Text(
                      AppLang.local(context).update_profile_ucf,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    ),
                    onPressed: () {
                      data.onPressUpdate(context);
                    },
                  ),
                ),
              ),
            ],
          );
  }
}
