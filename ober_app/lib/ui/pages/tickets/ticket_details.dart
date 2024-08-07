import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ober_app/blocs/ticket_bloc.dart';
import 'package:ober_app/config/app_config.dart';
import 'package:ober_app/config/style_config.dart';
import 'package:ober_app/config/theme_config.dart';
import 'package:ober_app/custom_widgets/buttons.dart';
import 'package:ober_app/custom_widgets/decorations.dart';
import 'package:ober_app/custom_widgets/seoAppbar.dart';
import 'package:ober_app/custom_widgets/seo_forms.dart';
import 'package:ober_app/events/ticket_events.dart';
import 'package:ober_app/helpers/main_helper.dart';
import 'package:ober_app/others/system_data.dart';
import 'package:ober_app/states/ticket_state.dart';
import 'package:url_launcher/url_launcher.dart';

class TicketDetails extends StatelessWidget {
   TicketDetails({super.key,required this.id});
  final id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SeoAppbar.build(title: "Ticket Details"),
      body: BlocBuilder<TicketBloc,TicketState>(
        builder: (context,state) {
          return SingleChildScrollView(
            padding: EdgeInsets.all(StyleConfig.padding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Ticket Info",style: StyleConfig.fs16fwBold,),
                SizedBox(height: 5,),
                Text("Subject: ${state.details?.subject??''}"),
                SizedBox(height: 5,),

                Text("Priority: ${state.details?.priority??''}"),
                SizedBox(height: 5,),

                Text("Status: ${state.details?.status??''}"),
                SizedBox(height: 5,),

                Text("Message: ${state.details?.description??''}"),
                if(state.details?.supportReply?.isNotEmpty??false)
                  Column(
                    children: [
                      Row(
                        children: [
                          Text("Replies",style: StyleConfig.fs16fwBold,),
                          Spacer(),
                          Buttons(child: Text("New Reply"),onPressed: (){
                            showReplyBox(context);
                          },
                            padding: EdgeInsets.all(10),
                            shape: StyleConfig.buttonsRadius(20),
                          minHeight: 40.0,minWidth: 60.0,
                          color: ThemeConfig.accentColor,
                          )
                        ],
                      ),
                      SizedBox(height: 10,),
                      ListView.separated(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context,index){
                        var reply = state.details?.supportReply?[index];
                        var isAdmin = reply?.userId != SystemData.userData?.id;
                        var isPreviousUserSame = false;
                        if(index>0) {
                        var tmp =  state.details?.supportReply?[index-1];

                        isPreviousUserSame = tmp?.userId ==
                              SystemData.userData?.id;
                        }
                        var file ;
                        if(reply?.files is String){
                          file = jsonDecode(reply?.files??[]).first;
                        }
                        return Align(
                          alignment: isAdmin?Alignment.centerLeft:Alignment.centerRight,
                          child: Column(
                            crossAxisAlignment:isAdmin? CrossAxisAlignment.start:CrossAxisAlignment.end,
                            children: [
                              if(!isPreviousUserSame)
                              if(isAdmin)
                                Container(
                                  decoration: Decorations.round(radius: 25).copyWith(color: ThemeConfig.accentColor),
                                  height: 50,
                                  width:50,
                                  alignment: Alignment.center,
                                  child: Text("Admin",style: StyleConfig.fs14,),
                                )else
                                Container(
                                  decoration: Decorations.round(radius: 25).copyWith(color: ThemeConfig.accentColor),
                                  height: 50,
                                  width:50,
                                  alignment: Alignment.center,
                                  child: Text("Yours",style: StyleConfig.fs14,),
                                ),

                              SizedBox(height: 10,),
                              Container(
                                constraints: BoxConstraints(maxWidth:  getWidth(context)*0.7),
                                // width:,
                                padding: EdgeInsets.all(8),
                                decoration: Decorations.border(),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(reply?.message??""),
                                    if(file !=null)
                                      Padding(
                                        padding: EdgeInsets.only(top: 8),
                                        // height: 40,
                                        // width: 80,
                                        child: InkWell(
                                          onTap: ()async{
                                            var uri = Uri.parse(AppConfig.public_assets+"/"+file);
                                            if(await canLaunchUrl(uri)){
                                              launchUrl(uri);
                                            }
                                          },

                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Icon(Icons.file_copy_sharp,size: 26,),
                                                Icon(Icons.file_download,size: 26,),

                                              ],
                                            )),

                                      )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      }, separatorBuilder: (context,index)=>SizedBox(height: 14,), itemCount: state.details?.supportReply?.length??0),

                    ],
                  )

              ],
            ),
          );
        }
      ),
    );
  }

  showReplyBox(BuildContext context){
    showModalBottomSheet(
        isScrollControlled: true,
        context: context, builder: (context)=>BlocBuilder<TicketBloc,TicketState>(
          builder: (context,state) {
            return Container(
                  color: themeBoxColor,
                  padding: EdgeInsets.only(left: 14,right: 14,top: 14,bottom: MediaQuery.of(context).viewInsets.bottom+10),
                  child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SeoForms.textField(title: "Message", controller: state.replyMessageEditController,isRequired: true),
              SeoForms.flatImagePicker(title: "File", networkImg: "", onImagePicked: (file){
                context.read<TicketBloc>().add(OnSelectedReplyFile(file));
              },pickedImage: state.replyAttachment),
              SizedBox(height: 10,),
              Buttons.round(onPress: (){
                context.read<TicketBloc>().add(OnSubmitReplyTicket(context, id));
              }, child: Text("Submit"))
            ],
                  ),
                );
          }
        ));
  }

}
