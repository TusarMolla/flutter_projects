import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ober_app/events/home_events.dart';
import 'package:ober_app/events/seo_event.dart';
import 'package:ober_app/states/demo_state.dart';
import 'package:ober_app/states/main_state.dart';

class MainBloc extends Bloc<SeoEvent,MainState>{
  MainBloc():super(MainState.init()) {
    on<OnChangeIndex>((event, emit) =>emit(state.update(index: event.currentIndex)));

  }
}