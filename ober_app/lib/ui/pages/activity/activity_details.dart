import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ober_app/blocs/activity_bloc.dart';
import 'package:ober_app/config/app_config.dart';
import 'package:ober_app/config/style_config.dart';
import 'package:ober_app/custom_widgets/buttons.dart';
import 'package:ober_app/custom_widgets/decorations.dart';
import 'package:ober_app/custom_widgets/seoAppbar.dart';
import 'package:ober_app/custom_widgets/seo_forms.dart';
import 'package:ober_app/events/activity_events.dart';
import 'package:ober_app/helpers/main_helper.dart';
import 'package:ober_app/helpers/seo_date_formatter.dart';
import 'package:ober_app/models/trip_detail_response.dart';
import 'package:ober_app/others/system_data.dart';
import 'package:ober_app/states/activity_state.dart';
import 'package:url_launcher/url_launcher.dart';

class ActivityDetails extends StatelessWidget {
  const ActivityDetails({super.key, required this.id});

  final id;

  @override
  Widget build(BuildContext context) {

    context.read<ActivityBloc>().add(OnDetails(id));

    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      appBar: SeoAppbar.build(title: "Details Page"),
      body: buildBlocBuilder(),
    );
  }

  BlocBuilder<ActivityBloc, ActivityState> buildBlocBuilder() {
    return BlocBuilder<ActivityBloc,ActivityState>(
      builder: (context,state) {
        print("is niit ${state.isDetailsInit}");
        return state.isDetailsInit? buildSingleChildScrollView(context,state):loader();
      }
    );
  }

  Widget loader(){
    return Center(child:  CircularProgressIndicator(),);
  }

  SingleChildScrollView buildSingleChildScrollView(BuildContext context,ActivityState state) {



    var data  = state.detailsResponse!.trip!;
    var complain;
    if(state.detailsResponse?.complain != null && state.detailsResponse!.complain!.isNotEmpty) {
      complain = state.detailsResponse!.complain!.first;
    }
    print("user id ${SystemData.userData?.id.toString()}");
    // print("complain${complain.isEmpty}");
    return SingleChildScrollView(
        padding: EdgeInsets.all(StyleConfig.padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Date: ${state.detailsResponse!.trip!.createdAt!.dayMonthYear()}",
              style: StyleConfig.fs14,
            ),
            // Spacer(),
            Text(
              "Status: ${statusToString(data.status)} ${data.status.toString()=='3'?(data.cancelledBy.toString()==SystemData.userData?.id.toString()?'(${getLocal(context).cancel_status_message})':'(${getLocal(context).cancel_status_message2})'):''}",
              style: StyleConfig.fs14.copyWith(color:statusToColor(data.status) ),
            ),
            if(state.detailsResponse?.driver != null)
            Text(
              "Driver Name: ${state.detailsResponse?.driver?.firstName??''} ${state.detailsResponse?.driver?.lastName??''}",
              style: StyleConfig.fs14,
            ),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ("Pickup: "),
                  style: StyleConfig.fs14,
                ),
                Flexible(
                    child: Text(
                  (data.startLocation!),
                  style: StyleConfig.fs14,
                )),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ("DropOff: "),
                  style: StyleConfig.fs14,
                ),
                Flexible(
                    child: Text(
                  (data.endLocation!),
                  style: StyleConfig.fs14,
                )),
              ],
            ),

            Text(
              "Distance: ${data.distance}Km",
              style: StyleConfig.fs14,
            ),
            Text(
              "Amount: ${priceWithSymbol(data.fare)}",
              style: StyleConfig.fs14,
            ),
            SizedBox(
              height: 10,
            ),
            if (DateTime.now().difference(data.createdAt!).inHours < 24 && ((complain?.isEmpty??true)))
              Buttons.round(
                  onPress: () {
                    showComplainBox(context,data);
                  },
                  child: Text("Do you want to complain?"))
            else if(complain !=null && (complain?.isNotEmpty??false))
              Container(
                width: getWidth(context),
                padding: EdgeInsets.all(StyleConfig.padding),
                decoration: Decorations.border(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(child: Text("Complain",style: StyleConfig.fs16fwBold,)),
                    SizedBox(height: 8,),
                    Text("Date: ${DateTime.parse(complain['created_at']).dayMonthYear()}"),
                    Text("status: ${complain['status']}"),
                    Text("Subject: ${complain['title']}"),
                    Text("Message: ${complain['description']}"),
                    if(complain['image'] !=null)
                      IconButton(onPressed: ()async{
                        Uri url = Uri.parse(AppConfig.public_assets+"/${complain['image']}");
                        if(await canLaunchUrl(url)){
                          launchUrl(url);
                        }
                      }, icon: Icon(Icons.arrow_circle_down))
                  ],
                ),
              )
          ],
        ),
      );
  }

  showComplainBox(BuildContext context,Trip data) {

    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        backgroundColor: themeBoxColor,
        // constraints: BoxConstraints(minHeight: 200, maxHeight: 1000, minWidth: getWidth(context)),
        builder: (childContext) => BlocBuilder<ActivityBloc,ActivityState>(
          builder: (stateContext,state) {
            return SingleChildScrollView(
              // padding: EdgeInsets.zero,
              //     padding:  EdgeInsets.only(top: 8,right: 8,left: 8,bottom: 200),
              padding:  EdgeInsets.only(top: 8,right: 8,left: 8,bottom: MediaQuery.of(childContext).viewInsets.bottom+10),

                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Make your complain",
                        style: StyleConfig.fs16,
                      ),
                      SeoForms.textField(title: "Subject", controller: state.subjectController,hint: "Type your subject",isRequired: true),
                      SizedBox(height: 10,),
                      SeoForms.longTextField(title: "Message", controller: state.messageController,hint: "Type your message",isRequired: true),
                      SizedBox(height: 10,),

                      SeoForms.flatImagePicker(title: "Document", networkImg: "",pickedImage: state.selectedFile ,onImagePicked: (img){
                        context.read<ActivityBloc>().add(ChooseFile(img));
                      }),
                      SizedBox(height: 20,),

                      Buttons.round(onPress: (){
                        Navigator.pop(childContext);
                        context.read<ActivityBloc>().add(OnSubmitComplain(context, data.id));

                      }, child: Text("Submit",))
                    ],
                  ),
                );
          }
        ));
  }
}
