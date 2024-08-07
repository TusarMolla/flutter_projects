import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ober_app/custom_widgets/loader.dart';
import 'package:ober_app/custom_widgets/seo_toast.dart';
import 'package:ober_app/events/demo_event.dart';
import 'package:ober_app/events/demo_event.dart';
import 'package:ober_app/events/refund_events.dart';
import 'package:ober_app/events/seo_event.dart';
import 'package:ober_app/repositories/refund_repository.dart';
import 'package:ober_app/states/demo_state.dart';
import 'package:ober_app/states/refund_state.dart';

class RefundBloc extends Bloc<RefundEvents,RefundState>{
  RefundBloc():super(RefundState.init()) {
    on<OnInit>((event, emit) async{

         await _initData();
          emit(state.update(state));
    });

    on<RefundRequest>((event, emit)async{
     await _request(event);
     emit(state.update(state));
    });
  }

  _initData()async{
    _clearData();
   await _getData();

  }


  _request(RefundRequest event)async{
    Loader.show(event.context);
    var res =await RefundRepository.requestRefund(event: event);
    Loader.hide();
    SEOToast.show(event.context, res.message);
    state.currentPage = 1;
    Navigator.pop(event.context);
    await _initData();

  }

  _getData()async{
    var res =await RefundRepository.initData(page: state.currentPage);
    state.list = res.data?.data??[];
    state.isDataInit = true;
    if(state.currentPage<(res.data?.lastPage??state.currentPage)) {
      state.currentPage = state.currentPage + 1;
    }
  }
  _clearData(){
    state.lastPage = 1;
    state.isDataInit = false;
    state.list.clear();
  }
}