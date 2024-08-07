


import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ober_app/custom_widgets/loader.dart';
import 'package:ober_app/custom_widgets/seo_dialogs.dart';
import 'package:ober_app/custom_widgets/seo_toast.dart';
import 'package:ober_app/events/activity_events.dart';
import 'package:ober_app/helpers/main_helper.dart';
import 'package:ober_app/repositories/trip_repository.dart';
import 'package:ober_app/states/activity_state.dart';

class ActivityBloc extends Bloc<ActivityEvents,ActivityState>{
  ActivityBloc():super(ActivityState.init()) {
    on<InitData>((event, emit) async {
     await _initData();
     emit(state.update(state));
    });

on<OnChangeFilter>((event, emit)async {
  state.selectedFilter = event.data;
  _clearAll();
  await _getTripList(status: event.data.key);
  emit(state.update(state));
});
    on<OnRefresh>((event, emit) async {
     await _onReFresh();
     emit(state.update(state));
    });

    on<ChooseFile>((event, emit) {
      _onChooseFile(event);
      emit(state.update(state));
    });

    on<OnSubmitComplain>((event, emit) async{
      await _submitComplain(event);
      emit(state.update(state));
    });

    on<OnDetails>((event, emit)async {
      await _details(event.id);
      emit(state.update(state));
    });

  }


  _details(id)async{
    var response =await TripRepository.tripDetails(id);
    state.detailsResponse = response;
    state.isDetailsInit = true;
  }

  _initData()async{
    _clearAll();
    await _getTripList();
  }

  _onReFresh()async{
    _clearAll();
    return _getTripList();

  }

  _clearAll(){
    state.isTripInit = false;
    state.trips.clear();
  }

  _getTripList({status})async{
    status ??= state.selectedFilter?.key;
    var response = await TripRepository.tripList(status);
    state.trips.addAll(response.trips?.data??[]);
    state.isTripInit = true;
  }

  _onChooseFile(ChooseFile event){
    state.selectedFile = event.file;

  }

  _submitComplain(OnSubmitComplain event)async{

    Loader.show(event.context);
    var response = await TripRepository.tripComplain(event.tripId, state.subjectController.text.trim(), state.messageController.text.trim(),img: state.selectedFile);
    Loader.hide();
    if(response.error !=null){
      print(response.message);
      if(event.context.mounted) {
        Dialogs.info(
            context: event.context,
            content: mapToListOfString(response.messages).join("\n"));
      }
      return ;
    }
    if(event.context.mounted) {
      SEOToast.show(event.context, response.message);
    }
    state.selectedFile = null;
    state.subjectController.clear();
    state.messageController.clear();
    event.context.read<ActivityBloc>().add(OnDetails(event.tripId));

  }

}