
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ober_app/blocs/refund_bloc.dart';
import 'package:ober_app/config/style_config.dart';
import 'package:ober_app/config/theme_config.dart';
import 'package:ober_app/custom_widgets/buttons.dart';
import 'package:ober_app/custom_widgets/decorations.dart';
import 'package:ober_app/custom_widgets/seoAppbar.dart';
import 'package:ober_app/events/refund_events.dart';
import 'package:ober_app/helpers/main_helper.dart';
import 'package:ober_app/helpers/seo_date_formatter.dart';
import 'package:ober_app/others/seo_route.dart';
import 'package:ober_app/states/refund_state.dart';
import 'package:ober_app/ui/pages/refunds/refund_req.dart';


class RefundPage extends StatelessWidget {
  const RefundPage({super.key});

  @override
  Widget build(BuildContext context) {

    context.read<RefundBloc>().add(OnInit());

    return  Scaffold(

      appBar: SeoAppbar.build(title: getLocal(context).refund),
      body: BlocBuilder<RefundBloc,RefundState>(
        builder: (context,state) {
          return buildListView(state);
        }
      ),
    );
  }

  Widget buildListView(RefundState state) {
    if(!state.isDataInit){
      return Center(child: CircularProgressIndicator(),);
    }

    return ListView.separated(
        padding: EdgeInsets.all(StyleConfig.padding),

        itemBuilder: (context,index){
          var data = state.list[index];
          return Container(
            padding: EdgeInsets.all(10),
            decoration: Decorations.round(),
            child:
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(data.createdAt!.dayMonthYear(),style: StyleConfig.fs16,),
                Text(priceWithSymbol(data.amount),style: StyleConfig.fs14fwBold,),

                Row(
                  children: [
                    Text(refundStatus(data.status),style: StyleConfig.fs14.copyWith(color:data.status.toString() !="0"?ThemeConfig.darkGrey:ThemeConfig.accentColor ),),
                    Spacer(),

                  ],
                ),

              ],
            ),
          );
        }, separatorBuilder: (context,index)=>SizedBox(height: 14,), itemCount: state.list.length);
  }
}
