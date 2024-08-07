import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart' as cWidget;
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ober_app/config/style_config.dart';
import 'package:ober_app/config/theme_config.dart';
import 'package:ober_app/custom_models/dropdown_model.dart';
import 'package:ober_app/custom_widgets/buttons.dart';
import 'package:ober_app/custom_widgets/decorations.dart';
import 'package:ober_app/custom_widgets/images.dart';
import 'package:ober_app/custom_widgets/input_decorations.dart';
import 'package:ober_app/helpers/main_helper.dart';
import 'package:ober_app/helpers/seo_date_formatter.dart';
import 'package:ober_app/main.dart';

class SeoForms{


  static dateField({required BuildContext context,required title,required ArgumentCallback<DateTime?> onPicked,required DateTime currentDate,bool isRequired = false}){
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildTitle(title,isRequired),
        SizedBox(width: 6,),
        Buttons(
          onPressed: ()async{
        onPicked(await _pickedDate(context,currentDate));

        },
          child: Row(
            children: [
              Icon(Icons.calendar_month,color:themeTxtColor,),
              SizedBox(width: 6,),
              Text(currentDate.yearMonthDay(),style: StyleConfig.fs14,),
            ],
          ),
        ),
      ],
    );
  }


  static passwordField(
      {required title,
        required TextEditingController controller,
        String? hint,
        bool isRequired = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitle(title, isRequired),
        SizedBox(
          height: 6,
        ),
        TextField(
          controller: controller,
          keyboardAppearance:Brightness.dark ,
          obscureText: true,
          decoration:InputDecorations.round(prefix: Icons.lock_outline_rounded,hint: "••••••••"),
        ),
      ],
    );
  }

  static textField({required title,required TextEditingController controller,String? hint,bool isRequired = false,int? maxLength,List<TextInputFormatter> formatter = const[]}){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitle(title,isRequired),
        SizedBox(height: 6,),
        TextField(
          style: StyleConfig.fs14,
          controller: controller,
          decoration: InputDecorations.normal(hint:hint ),
          maxLength: maxLength,
          inputFormatters: formatter,
        )
      ],
    );
  }
  static longTextField({required title,required TextEditingController controller,String? hint,bool isRequired = false}){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitle(title,isRequired),
        SizedBox(height: 6,),
        noTitleLongTextField(controller,hint)
      ],
    );
  }

  static Container noTitleLongTextField(TextEditingController controller,hint) {
    return Container(
        height: 100,
        decoration: Decorations.border(),
        child: TextField(
          style: StyleConfig.fs14,
          controller: controller,
          decoration: InputDecoration(border: InputBorder.none,focusedBorder: InputBorder.none,fillColor: ThemeConfig.noColor,hintText: hint)
        ),
      );
  }

  static Widget cupertinoNoTitleLongTextField(TextEditingController controller) {
    return cWidget.Container(
        height: 100,
         alignment: Alignment.topLeft,
         decoration: BoxDecoration(

           borderRadius: BorderRadius.circular(8),
           color: ThemeConfig.white
         ),
        child: cWidget.CupertinoTextField.borderless(
          placeholder: "Type here",
          style: StyleConfig.fs14.copyWith(color: themeBoxColor),
          controller: controller,
          // decoration: cWidget.BoxDecoration(border: cWidget.Border.none,focusedBorder: InputBorder.none,fillColor: ThemeConfig.noColor)
        ),
      );
  }

  static imagePicker({required title,required String  networkImg,required ArgumentCallback<File> onImagePick,File? pickedImg,bool isRequired = false}){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitle(title,isRequired),
        SizedBox(
          height: 100,
          width: 100,
          child: Stack(
            children: [

              pickedImg ==null?ImageView.networkCircle(
                  imageUrl: networkImg, height: 100, width: 100):ImageView.fileCircle(imageFile: pickedImg, height: 100.0, width: 100.0),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: Decorations.round(radius: 30),
                  child: InkWell(
                    onTap: ()async {
                      var img = await pickImage();
                      if(img !=null){
                        onImagePick(File(img.path));
                      }
                    },
                    child: Icon(Icons.edit),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }


  static flatImagePicker(
      {required title,
        required String networkImg,
        required ArgumentCallback<File> onImagePicked,
        File? pickedImage,
        bool isRequired = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitle(title, isRequired),
        SizedBox(height: 8,),
        SizedBox(
          // height: 100,
          // width: 100,
          child: Column(
            children: [
              Container(
                padding:EdgeInsets.all(14),
                decoration: Decorations.round(radius: 4.0).copyWith(color: ThemeConfig.lightGrey),
                child: InkWell(
                  onTap: ()async{
                    var img = await pickImage();
                    if (img!=null) {
                      onImagePicked(File(img.path));
                    }
                  },
                  child: Row(
                    children: [
                      Text("Choose Images",style: StyleConfig.fs14.copyWith(color: ThemeConfig.black),),
                      // Spacer(),
                      // Icon(Icons.add_circle_outlined)
                    ],
                  ),
                ),
              ),
              if(pickedImage != null)
              ImageView.fileSquire(
                  imageFile: pickedImage, size: 100.0),
            ],
          ),
        ),
      ],
    );
  }



  static Widget _buildTitle(title,bool isRequired){
   return RichText(

     text: TextSpan(text: title,

       children: [
         if(isRequired)
         TextSpan(text: " *",style: StyleConfig.fs16.copyWith(color: ThemeConfig.red))
       ],
       style: Theme.of(globalState.currentState!.context).textTheme.bodyMedium,
     ),
   );
  }


  static Future<DateTime?> _pickedDate(BuildContext context,DateTime currentDate)async{
    var data = await showDatePicker(context: context, firstDate: DateTime(1800), lastDate: DateTime.now(),currentDate: currentDate);

    return data;

  }


  static Widget dropdown({required title,required List<DropDownDataModel> data,
    bool isRequired = false,
  required DropDownDataModel? selectedValue,
  required BuildContext context,
  bool? isDataInit=false,
  required ArgumentCallback<DropDownDataModel?> onSelected}){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitle(title, isRequired),
        SizedBox(height: 6,),
        _buildDropdownField(data: data, selectedValue: selectedValue, context: context, onSelected: onSelected,isDataInit: isDataInit)
      ],
    );
  }

  static Container _buildDropdownField(
      {required List<DropDownDataModel> data,
        required DropDownDataModel? selectedValue,
        required BuildContext context,
        bool? isDataInit=false,
        required ArgumentCallback<DropDownDataModel?> onSelected}) {
    isDataInit??=false;
    return Container(
      height: 36,
      decoration: isDataInit ? Decorations.border() : null,
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: isDataInit
          ? DropdownButton<DropDownDataModel>(
          menuMaxHeight: 200,
          padding: EdgeInsets.zero,
          underline: SizedBox.shrink(),
          isExpanded: true,
          value: selectedValue,
          dropdownColor: themeBoxColor,
          style: StyleConfig.fs14.copyWith(color: themeTxtColor),
          items: data
              .map<DropdownMenuItem<DropDownDataModel>>(
                  (e) => DropdownMenuItem<DropDownDataModel>(
                value: e,
                child: Text(
                  e.value,
                  style: StyleConfig.fs14,
                  maxLines: 2,
                ),
              ))
              .toList(),
          onChanged:(DropDownDataModel? newData)=> onSelected(newData))
          : Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
        ],
      ),
    );
  }


}