import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ober_app/blocs/ticket_bloc.dart';
import 'package:ober_app/config/style_config.dart';
import 'package:ober_app/config/theme_config.dart';
import 'package:ober_app/custom_models/dropdown_model.dart';
import 'package:ober_app/custom_widgets/buttons.dart';
import 'package:ober_app/custom_widgets/decorations.dart';
import 'package:ober_app/custom_widgets/input_decorations.dart';
import 'package:ober_app/custom_widgets/seoAppbar.dart';
import 'package:ober_app/events/ticket_events.dart';
import 'package:ober_app/helpers/main_helper.dart';
import 'package:ober_app/states/ticket_state.dart';

class CreateTicket extends StatelessWidget {
  const CreateTicket({super.key});


  Future<FilePickerResult?> pickSingleFile() async {
    return await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: [
      "jpg",
      "jpeg",
      "png",
      "svg",
      "webp",
      "gif",
      "mp4",
      "mpg",
      "mpeg",
      "webm",
      "ogg",
      "avi",
      "mov",
      "flv",
      "swf",
      "mkv",
      "wmv",
      "wma",
      "aac",
      "wav",
      "mp3",
      "zip",
      "rar",
      "7z",
      "doc",
      "txt",
      "docx",
      "pdf",
      "csv",
      "xml",
      "ods",
      "xlr",
      "xls",
      "xlsx"
    ]);
  }

  Future<File?> chooseAndUploadFile(context) async {
    FilePickerResult? file = await pickSingleFile();
    if(file !=null) {
      return File(file.files.first.path!);
    }
    return null;
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SeoAppbar.build(title: "Create New Ticket"),
      body: BlocBuilder<TicketBloc,TicketState>(
        builder: (context,data) {
          return SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 14),
              child: Column(
                children: [
                      buildFormItemModel(editTextField(data.subjectEditController,"Subject"), "Subject",context,),
                      buildFormItemModel(buildDropdownField(data: TicketState.priorities, selectedValue: data.selectedPriority, context: context,
                          onChanged: (value){
                            context
                                .read<TicketBloc>()
                                .add(OnChangePriority(value));
                        }), "Priority",context),
                  buildFormItemModel(textAreaField(data.messageEditController,"Message....",80), "Message",context,height: 110),
                  buildFormItemModel(fileField(context, (newData){
                    context.read<TicketBloc>().add(OnSelectedFile(newData));
                  }, data.attachment), "Attachment",context,height: 130,isRequired: false),

                  Buttons(color: Colors.green,
                    minWidth:getWidth(context),
                    minHeight: 40.0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8
                    )),
                    onPressed: (){
                    context.read<TicketBloc>().add(OnSubmitTicket(context));
                    },
                    child: Text("Submit",style: StyleConfig.fs12,),
                  ),

                ],
              ),
            ),
          );
        }
      ),
    );
  }

  Widget buildFormItemModel(Widget field, String title, BuildContext context,{double height = 64,bool isRequired = true}) {
    return SizedBox(
      width: getWidth(context),
      height: height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [buildLabel(title,isRequired), field],
      ),
    );
  }


  Widget editTextField(TextEditingController controller, String hint,
      {bool readOnly = false

      }) {
    return Container(
      height: 36,
      child: TextField(
        readOnly: readOnly,
        controller: controller,
        autofocus: false,
        decoration: InputDecorations.normal(hint: hint),
      ),
    );
  }

  Widget textAreaField(TextEditingController controller, String hint,double height) {
    return Container(
      height: height,
      padding: EdgeInsets.symmetric(horizontal: 8),
      decoration: Decorations.round(),
      child: TextField(
        controller: controller,
        autofocus: false,
        decoration: InputDecoration.collapsed(hintText: hint).copyWith(focusedBorder: InputBorder.none),
      ),
    );
  }

  Container buildDropdownField(
      {required List<DropDownDataModel> data,
        required DropDownDataModel? selectedValue,
        required BuildContext context,
        required onChanged}) {
    return Container(
      height: 36,
      decoration: Decorations.round(),
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: DropdownButton<DropDownDataModel>(
          menuMaxHeight: 200,
          padding: EdgeInsets.zero,
          underline: SizedBox.shrink(),
          isExpanded: true,
          value: selectedValue,
          style: StyleConfig.fs14,
          dropdownColor: themeBoxColor,
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
          onChanged: onChanged),
    );
  }


  buildLabel(String title,bool isRequired) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Text(
            title,
            style: StyleConfig.fs12,
          ),
          if(isRequired)
          Text(
            " *",
            style: StyleConfig.fs12.copyWith(color: ThemeConfig.red),
          ),

        ],
      ),
    );
  }



  Widget fileField(BuildContext context, dynamic onChosenFile,
      File? selectedFile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Buttons(
          padding: EdgeInsets.zero,
          onPressed: () async {
            File? tmpFile = await chooseAndUploadFile(context);
            if(tmpFile !=null){
              context.read<TicketBloc>().add(OnSelectedFile(tmpFile));
            }


          },
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6),side: BorderSide(color: ThemeConfig.mediumGrey,)),
          child: Container(
            height: 46,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /*Padding(
                  padding: const EdgeInsets.only(left: 14.0),
                  child: Text(
                    "Choose File",
                    style: TextStyle(fontSize: 12, color: ThemeConfig.grey),
                  ),
                ),*/
                Container(
                  decoration: BoxDecoration(
                  color: ThemeConfig.grey.withOpacity(0.5),
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(6),bottomLeft:Radius.circular(6) )),
                  alignment: Alignment.center,
                  height: 46,
                  width: 80,
                  child: Text(
                    "Choose file",
                    style: TextStyle(fontSize: 12, color: ThemeConfig.grey),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        if (selectedFile != null)
          Stack(
            children: [
              Container(
                padding: EdgeInsets.all(3),
                height: 40,
                alignment: Alignment.center,
                width: 40,
                decoration: BoxDecoration(
                  color: ThemeConfig.grey,
                ),
                child: Text(
                  selectedFile.path.split("/").last??"",
                  style: TextStyle(fontSize: 9, color: ThemeConfig.white),
                ),
              ),
              Positioned(
                top: 0,
                right: 5,
                child: Container(
                  height: 15,
                  width: 15,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: ThemeConfig.white),
                  // remove the selected file button
                  child: InkWell(
                    onTap: () {
                      onChosenFile(null);
                    },
                    child: Icon(
                      Icons.close,
                      size: 12,
                      color: ThemeConfig.red,
                    ),
                  ),
                ),
              ),
            ],
          ),
      ],
    );
  }

}
