import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ober_app/blocs/ticket_bloc.dart';
import 'package:ober_app/config/style_config.dart';
import 'package:ober_app/custom_widgets/decorations.dart';
import 'package:ober_app/custom_widgets/seoAppbar.dart';
import 'package:ober_app/custom_widgets/seo_no_data.dart';
import 'package:ober_app/events/ticket_events.dart';
import 'package:ober_app/helpers/main_helper.dart';
// import 'package:ober_app/models/ticket_detail_response.dart';
import 'package:ober_app/others/seo_route.dart';
import 'package:ober_app/states/ticket_state.dart';
import 'package:ober_app/ui/pages/tickets/create_ticket.dart';
import 'package:ober_app/ui/pages/tickets/ticket_details.dart';

class Tickets extends StatelessWidget {
  const Tickets({super.key});

  @override
  Widget build(BuildContext context) {

    context.read<TicketBloc>().add(InitData(context));
    return Scaffold(
      appBar: SeoAppbar.build(
        title: "Ticket",
        bottom: PreferredSize(
          preferredSize: Size(getWidth(context), 60),
          child: Container(

            width: getWidth(context),
            margin: EdgeInsets.all(14),
            alignment: Alignment.center,
            height: 60,
            decoration: Decorations.round(),
            child: InkWell(
              onTap: () {
                SEORoute.go(context, CreateTicket());
              },
              child: SizedBox(
                width: getWidth(context),
                child: Column(

                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "New Ticket",
                      style: StyleConfig.fs16fwBold,
                    ),
                   const Icon(
                      Icons.add,
                      size: 26,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      body: BlocBuilder<TicketBloc,TicketState>(
        builder: (context,state) {
          if(!state.isDataInit){
            return Center(child: CircularProgressIndicator(),);
          }else if(state.data.isEmpty){
            return Center(child:  SeoNoData(),);
          }
          return RefreshIndicator(
              onRefresh: ()async{
                context.read<TicketBloc>().add(ResetData(context));
              },
            child: ListView.separated(
              physics: AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: StyleConfig.padding),
              itemBuilder: (context, index) => Container(
                padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                decoration: Decorations.round(),
                child: InkWell(
                  onTap: (){
                    context.read<TicketBloc>().add(OnTicketDetails(state.data[index].id));
                    SEORoute.go(context, TicketDetails(id: state.data[index].id));
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Flexible(
                              flex: 1,
                              fit: FlexFit.tight,
                              child: Text(state.data[index].subject??"",style: StyleConfig.fs16fwBold,)),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(state.data[index].status??"",style: StyleConfig.fs14fwBold,),
                      ),
                        ],
                      ),
                      Text(state.data[index].description??"",style: StyleConfig.fs14,maxLines: 2,),
                    ],
                  ),
                ),
              ),
              separatorBuilder: (BuildContext context, int index) => SizedBox(
                height: 14,
              ),
              itemCount: state.data.length,
            ),
          );
        }
      ),
    );
  }
}
