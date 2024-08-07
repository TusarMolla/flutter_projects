import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ober_app/blocs/activity_bloc.dart';
import 'package:ober_app/config/style_config.dart';
import 'package:ober_app/config/theme_config.dart';
import 'package:ober_app/custom_widgets/buttons.dart';
import 'package:ober_app/custom_widgets/decorations.dart';
import 'package:ober_app/custom_widgets/seoAppbar.dart';
import 'package:ober_app/custom_widgets/seo_forms.dart';
import 'package:ober_app/custom_widgets/seo_no_data.dart';
import 'package:ober_app/events/activity_events.dart';
import 'package:ober_app/helpers/main_helper.dart';
import 'package:ober_app/helpers/seo_date_formatter.dart';
import 'package:ober_app/others/seo_route.dart';
import 'package:ober_app/states/activity_state.dart';
import 'package:ober_app/ui/pages/activity/activity_details.dart';
import 'package:ober_app/ui/pages/refunds/refund_req.dart';




class ActivityPage extends StatelessWidget {
  const ActivityPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<ActivityBloc>().add(InitData());
    return BlocBuilder<ActivityBloc,ActivityState>(
      builder: (context,state) {
        return Scaffold(
          appBar: SeoAppbar.build(title: "Activity",bottom: PreferredSize(preferredSize: Size(getWidth(context), 60), child: Padding(
            padding: const EdgeInsets.symmetric(horizontal:StyleConfig.padding),
            child: SeoForms.dropdown(title: getLocal(context).filter, data: ActivityState.filters, isDataInit: true,selectedValue: state.selectedFilter, context: context, onSelected: (data){
              if(data !=null) {
                          context
                              .read<ActivityBloc>()
                              .add(OnChangeFilter(data));
                        }
                      }),
          ))),
          body: RefreshIndicator(
            onRefresh: () {
              context.read<ActivityBloc>().add(OnRefresh());
             return Future.value();
            },
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child:buildBody(state,context),
            ),
          ),
        );
      }
    );
  }

  Widget buildBody(ActivityState state,BuildContext context) {
    if(!state.isTripInit){
      return Container(
        height: getHeight(context),
        child: Center(child: CircularProgressIndicator(),),
      );
    }else if(state.isTripInit && state.trips.isEmpty){
      return Container(
        height: getHeight(context),
        child: Center(child: SeoNoData(),),
      );
    }


    return ListView.separated(
      padding: EdgeInsets.all(StyleConfig.padding),
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context,index)=>Container(
          padding: EdgeInsets.all(8),
            decoration: Decorations.border(),
            child:InkWell(
              onTap: (){
                SEORoute.go(context, ActivityDetails(id: state.trips[index].id));
              },
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(state.trips[index].createdAt!.dayMonthYear(),style: StyleConfig.fs14,),
                      Spacer(),
                      Text(statusToString(state.trips[index].status),style: StyleConfig.fs14,)
                    ],
                  ),
                  SizedBox(height: 8,),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(("Pickup: "),style: StyleConfig.fs14fwBold,),
                      Flexible(child: Text((state.trips[index].startLocation),style: StyleConfig.fs14,)),
                    ],
                  ),
                  SizedBox(height: 8,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(("DropOff: "),style: StyleConfig.fs14fwBold,),
                      Flexible(child: Text((state.trips[index].endLocation),style: StyleConfig.fs14,)),
                    ],
                  ),
                  SizedBox(height: 10,),

                  if(state.trips[index].refundStatus.toString() =="1" && state.trips[index].driverId !=null)
                    Buttons(onPressed: (){
                      SEORoute.go(context, RefundReqPage(id:state.trips[index].id??0,)).then((value) {
                        context.read<ActivityBloc>().add(InitData());
                      });
                    },
                      minWidth: 40.0,
                      minHeight: 20.0,
                      color: ThemeConfig.accentColor,
                      padding: const EdgeInsets.all(8),
                      shape: StyleConfig.buttonsRadius(8),child: Text(getLocal(context).make_request),

                    )

                ],
              ),
            ) ,
          ), separatorBuilder: (index,context)=>SizedBox(height: 14,), itemCount: state.trips.length);
  }

}
