import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ober_app/events/demo_event.dart';
import 'package:ober_app/events/demo_event.dart';
import 'package:ober_app/events/seo_event.dart';
import 'package:ober_app/states/demo_state.dart';

class DemoBloc extends Bloc<SeoEvent,DemoState>{
  DemoBloc():super(DemoState.init()) {
    on<Increment>((event, emit) =>emit(state.update(count:  state.count + 1 )));
  }

}