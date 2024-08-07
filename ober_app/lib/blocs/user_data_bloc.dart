




import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ober_app/events/profile_events.dart';
import 'package:ober_app/events/seo_event.dart';
import 'package:ober_app/repositories/auth_repository.dart';
import 'package:ober_app/states/profile_state.dart';

class UserDataBloc extends Bloc<UserDataEvent,UserDataState>{

  UserDataBloc():super(UserDataState.init()) {
    on<UserDataEvent>((event, emit)async{
      await _updateInfo();
     return emit(state.update(state));
    });
  }

  _updateInfo()async{
    var tmpUserInfo = await AuthRepository.getInfo();
    state.email = tmpUserInfo.user?.email??"";
    state.name = tmpUserInfo.user?.username??"";
  }
}