



import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ober_app/custom_widgets/loader.dart';
import 'package:ober_app/custom_widgets/seo_dialogs.dart';
import 'package:ober_app/custom_widgets/seo_toast.dart';
import 'package:ober_app/events/auth_events.dart';
import 'package:ober_app/events/seo_event.dart';
import 'package:ober_app/helpers/auth.dart';
import 'package:ober_app/helpers/main_helper.dart';
import 'package:ober_app/helpers/shared_value_helper.dart';
import 'package:ober_app/others/seo_route.dart';
import 'package:ober_app/repositories/auth_repository.dart';
import 'package:ober_app/states/auth_state.dart';
import 'package:ober_app/ui/pages/auth/login_page.dart';
import 'package:ober_app/ui/pages/auth/reset_password_page.dart';
import 'package:ober_app/ui/pages/main.dart';

class AuthBloc extends Bloc<AuthEvents,AuthState>{
AuthBloc():super(AuthState.init()) {
  on<OnPressLogin>((event, emit) => _onPressLogin(event.context));
  on<OnPressSignUp>((event, emit) => _onPressSignUp(event.context));
  on<OnUpdatePassword>((event, emit) => _updatePassword(emit,event.context));
  on<ForgotPassword>((event, emit) => _sendOtp(event.context));
  on<ResetPassword>((event, emit) => _resetPassword(event.context));
  on<PrivacyAgree>((event, emit) {
    state.isAgree = event.agree;
    emit(state.update(state));
  });
}
_updatePassword(Emitter emit,BuildContext context)async{
  Loader.show(context);
  var res = await AuthRepository.updatePassword(state.updatePassOldController.text.trim(), state.updatePassNewController.text.trim(), state.updatePassConfirmController.text.trim());
  Loader.hide();
  if(res.error !=null){
    Dialogs.info(context: context, content:mapToListOfString(res.messages).join('\n'));
    return;
  }
  SEOToast.show(context, res.message);
  state.updatePassOldController.clear();
  state.updatePassConfirmController.clear();
  state.updatePassNewController.clear();
  emit(state.update(state));
}
_onPressLogin(BuildContext context)async{
  var emailOrUsername = state.loginEmailController.text;
  var password = state.loginPasswordController.text;
  if(emailOrUsername.isEmpty){
    Dialogs.info(context: context, content: "Email or User Name is required");
    return;
  }
  if(password.isEmpty){
    Dialogs.info(context: context, content: "Password is required");
    return;
  }

  Loader.show(context);
  var res = await AuthRepository.onLogin(emailOrUsername, password);
  Loader.hide();
  if(res.success !=null){
    if(res.success['role']=="passenger") {
      var tmp = res.success['token'];
      print(tmp);
      Auth.storeToken(tmp);
      SEORoute.goAndRemoveAll(context, MainPage());
    }else{
      SEOToast.show(context, "Invalid user!");
      return;
    }
  }
  SEOToast.show(context, res.message);

}

_onPressSignUp(BuildContext context)async{
  var username = state.regUserNameController.text;
  var email = state.regEmailController.text;
  var password = state.regPasswordController.text;
  var conPassword = state.regConfirmPasswordController.text;
  if(username.isEmpty || email.isEmpty){
    Dialogs.info(context: context, content: "Email or User Name is required");
    return;
  }
  if(password.isEmpty){
    Dialogs.info(context: context, content: "Password is required");
    return;
  }
  if(conPassword.isEmpty){
    Dialogs.info(context: context, content: "Confirm Password is required");
    return;
  }

  Loader.show(context);
  var res = await AuthRepository.onSignUp(userName: username, password: password,confirmPassword: conPassword,email: email);
  Loader.hide();
  if(res.success !=null ){
    var tmp = res.success['token'];
    Auth.storeToken(tmp);
    SEOToast.show(context, res.message);
    SEORoute.goAndRemoveAll(context, MainPage());
  }else{
    Dialogs.info(context: context, content: mapToListOfString(res.details).join("\n"));
  }


}

_sendOtp(BuildContext context)async{
  var email = state.forgotPEmail.text;
  if( email.isEmpty){
    Dialogs.info(context: context, content: "Email is required");
    return;
  }
  Loader.show(context);
  var res =await AuthRepository.forgotReq(email: email);
  Loader.hide();
  if(res.status??false){
    state.update(state);
    SEOToast.show(context, res.message);
    SEORoute.go(context, ResetPasswordPage());
  }
}
_resetPassword(BuildContext context)async{
  var email = state.forgotPEmail.text;
  var confirmPass = state.forgotPConfirmPassword.text;
  var password = state.forgotPNewPassword.text;
  var otp = state.forgotPOTP.text;
  if( email.isEmpty){
    Dialogs.info(context: context, content: "Email is required");
    return;
  }
  Loader.show(context);
  var res =await AuthRepository.resetPassword(email: email,confirmPassword: confirmPass,password: password,otp: otp);
  print(res.toJson());
  Loader.hide();
  if(res.errors ==null){
    if(res.status??false)
      SEOToast.show(context, res.message);
    {
      SEORoute.goAndRemoveAll(context, LoginPage());
    }

  }else{
    Dialogs.info(context: context, content: mapToListOfString(res.errors).join("\n"));
  }
}

}