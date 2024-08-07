import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ober_app/blocs/ober_account_bloc.dart';
import 'package:ober_app/config/style_config.dart';
import 'package:ober_app/custom_widgets/buttons.dart';
import 'package:ober_app/custom_widgets/seoAppbar.dart';
import 'package:ober_app/custom_widgets/seo_forms.dart';
import 'package:ober_app/events/ober_account_events.dart';
import 'package:ober_app/helpers/main_helper.dart';
import 'package:ober_app/others/seo_input_formatters.dart';
import 'package:ober_app/states/ober_account_state.dart';


class UpdateProfile extends StatelessWidget {
  const UpdateProfile({super.key});

  @override
  Widget build(BuildContext context) {
    // context.read<OberAccountBloc>().add(InitData());

    return Scaffold(
      appBar:SeoAppbar.build(title: getLocal(context).update_profile),
      body: BlocBuilder<OberAccountBloc,OberAccountState>(
        builder: (context,state) {
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: StyleConfig.padding),
            child: Column(
              children: [
                SeoForms.imagePicker(title:getLocal(context).profile_photo, networkImg: state.usersData?.image??"" , onImagePick:(File imageFile){
                  context.read<OberAccountBloc>().add(OnPickImage(imageFile));
                },pickedImg: state.selectedPhoto),

                SeoForms.textField(title: getLocal(context).first_name,isRequired: true ,controller: state.firstNameController),
                spacer(),
                SeoForms.textField(title: getLocal(context).last_name,isRequired: true ,controller: state.lastNameController),
                spacer(),
                SeoForms.textField(title: getLocal(context).social_no, isRequired: true,controller:state.socialController),
                spacer(),
                SeoForms.textField(title: getLocal(context).phone_number,isRequired: true ,controller: state.phoneNumberController),
                spacer(),
                SeoForms.dateField(context: context, title: getLocal(context).date_of_birth, isRequired: true,onPicked: (newDate){
                  if(newDate != null){
                    context.read<OberAccountBloc>().add(OnPickDate(newDate));
                  }
                }, currentDate: state.dob),
                spacer(),
                SeoForms.textField(title: getLocal(context).country, isRequired: true,controller:state.countryController),
                spacer(),
                SeoForms.textField(title: getLocal(context).city, isRequired: true,controller: state.cityController),
                spacer(),
                SeoForms.textField(title: getLocal(context).postal_code,isRequired: true, controller:state.postalCodeController),
                spacer(),
                SeoForms.longTextField(title: getLocal(context).address,isRequired: true, controller:state.addressController),
                spacer(),
                Text(getLocal(context).card_info,style: StyleConfig.fs16,),
                spacer(),
                SeoForms.textField(title: getLocal(context).card_holder_name,isRequired: false, controller:state.cardHolderNameController),
                spacer(),
                SeoForms.textField(title: getLocal(context).card_number,isRequired: false, controller:state.cardNumberController,maxLength: 12),
                spacer(),
                SeoForms.textField(title: getLocal(context).exp_date,isRequired: false, controller:state.expDateController,maxLength: 5,
                  formatter: [
                    CardExpFormatter()
                  ],),
                spacer(),
                SeoForms.textField(title: getLocal(context).cvc,isRequired: false, controller:state.cvcController),
                spacer(),
                Buttons.round(onPress: (){
                  context.read<OberAccountBloc>().add(ProfileUpdate(context));
                }, child: Text(getLocal(context).update,style: StyleConfig.fs14,)),
                spacer(),
              ],
            ),
          );
        }
      ),
    );
  }
 Widget spacer(){
    return SizedBox(height: 14,);
  }
}
