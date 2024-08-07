import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ober_app/custom_widgets/loader.dart';
import 'package:ober_app/custom_widgets/seo_dialogs.dart';
import 'package:ober_app/custom_widgets/seo_toast.dart';
import 'package:ober_app/events/ticket_events.dart';
import 'package:ober_app/helpers/main_helper.dart';
import 'package:ober_app/repositories/ticket_repository.dart';
import 'package:ober_app/states/ticket_state.dart';
import 'package:toast/toast.dart';

class TicketBloc extends Bloc<TicketEvents,TicketState>{
  TicketBloc():super(TicketState()) {
    on<InitData>((event, emit)async {
      state.isDataInit = false;
      state.page=1;
      emit(state.update(state));
     await getTicketData();
   return  emit(state.update(state));
    });

    on<ResetData>((event, emit)async{
    await  resetData(emit);
      return emit(state.update(state));
    });

    on<OnChangePriority>((event, emit)async {
      state.selectedPriority = event.dataModel;
      return  emit(state.update(state));
    });

    on<OnSelectedFile>((event, emit)async {
      state.attachment = event.file;
      return  emit(state.update(state));
    });
    on<OnSubmitTicket>((event, emit)async {

      await submitTicket(event.context);
      return  emit(state.update(state));
    });
    on<OnCloseTicket>((event, emit)async {

      await deleteTicket(event.context,event.id);
      return  emit(state.update(state));
    });

    on<OnSubmitReplyTicket>((event, emit)async {
      await replyTicket(event.context,event.id);
      return  emit(state.update(state));
    });

    on<OnTicketDetails>((event, emit) async {emit(state.update(await _getTicketDetails(event.id)));});
    on<OnSelectedReplyFile>((event, emit) => _onSelectReplyFile(emit,event.file));
  }


  _onSelectReplyFile(Emitter emit,File file){
    state.replyAttachment = file;
    emit(state.update(state));
  }

  submitTicket(BuildContext context)async{
    if(state.subjectEditController.text.trim().isEmpty){
      SEOToast.show(context, "Subject Required");
      return;
    }else if(state.messageEditController.text.trim().isEmpty) {
      SEOToast.show(context, "Message Required");
      return;
    }

    Loader.show(context);

    var response = await TicketRepository.createNewTicket(postBody: state.postBody(), fileKey: "files[0]",file: state.attachment);

    Loader.hide();
    if(response.error !=null){
      Dialogs.info(context: context, content: mapToListOfString(response.messages).join("\n"));
      return;
    }

    if(response.success??false){
      context.read<TicketBloc>().add(ResetData(context));
    }
      SEOToast.show(context,response.message);
  }

  replyTicket(BuildContext context,id)async{
     if(state.replyMessageEditController.text.trim().isEmpty) {
      SEOToast.show(context, "Message Required");
      return;
    }

    Loader.show(context);

    var response = await TicketRepository.replyTicket(id:id ,postBody: state.replyBody(id), fileKey: "files[0]",file: state.replyAttachment);

    Loader.hide();
      SEOToast.show(context,response.message);
    if(response.success??false){
      state.replyMessageEditController.clear();
      state.replyAttachment = null;
      _getTicketDetails(id);
      Navigator.pop(context);
    }

  }

  deleteTicket(BuildContext context,id)async{
    Loader.show(context);
    var response = await TicketRepository.deleteTicket(id);
    Loader.hide();
      SEOToast.show(context,response.message);
    if(response.status??false){
      context.read<TicketBloc>().add(ResetData(context));
    }

  }


  Future<TicketState>  _getTicketDetails( id)async{
    var res = await TicketRepository.getTicketDetails(id);
    state.details = res.data?.first;
    state.isDetailsInit = true;
    return state;
  }


  Future<TicketState>  getTicketData()async{
    var res = await TicketRepository.getTicketList(state.page);
    // print(res.data?.toJson());
    /*if(res.data?.nextPageUrl !=null){
        state.page= state.page! + 1;
    }else{
      state.page=null;
    }*/
    state.data = res.data??[];
    state.isDataInit = true;
    return state;
  }
/*
  Future<TicketState>  getReplyTicketData(InitTicketReplies event)async{
    var res = await TicketRepository.getReplyTicketList(event.id);



    state.replyData = res.data??[];
    state.isReplyDataInit = true;
    return state;
  }
*/
  onScrollEvent(BuildContext context){

    if(state.scrollController.position.pixels == state.scrollController.position.maxScrollExtent){
      if(state.page !=null) {
        getTicketData();
      }else{
        SEOToast.show(context, "No More data",gravity: Toast.center);
      }
    }
  }
  clearAll(){
    state.data = [];
    state.isDataInit = false;
    state.page = 1;
    state.selectedPriority=TicketState.priorities.first;
    state.subjectEditController.text ="";
    state.messageEditController.text ="";
    state.attachment=null;
  }
  resetData(emit)async{
    clearAll();
    emit(state.update(state));
    await getTicketData();
  }
}