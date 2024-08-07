import 'package:flutter/cupertino.dart';

class AuthState {
  TextEditingController loginEmailController;
  TextEditingController loginPasswordController;

  TextEditingController regUserNameController;
  TextEditingController regEmailController;
  TextEditingController regPasswordController;
  TextEditingController regConfirmPasswordController;
  bool isAgree ;

  TextEditingController updatePassOldController;
  TextEditingController updatePassNewController;
  TextEditingController updatePassConfirmController;


  TextEditingController forgotPEmail;
  TextEditingController forgotPNewPassword;
  TextEditingController forgotPConfirmPassword;
  TextEditingController forgotPOTP;


  AuthState(
      {required this.loginEmailController,
        required this.loginPasswordController,
        required this.regUserNameController,
        required this.regEmailController,
        required this.regPasswordController,
        required this.regConfirmPasswordController,
        required this.updatePassConfirmController,
        required this.updatePassNewController,
        required this.updatePassOldController,
        required this.forgotPConfirmPassword,
        required this.forgotPEmail,
        required this.forgotPNewPassword,
        required this.forgotPOTP,
        required this.isAgree
      });

  AuthState.init()
      : loginEmailController = TextEditingController(),
        loginPasswordController = TextEditingController(),
        regUserNameController = TextEditingController(),
        regEmailController = TextEditingController(),
        regPasswordController = TextEditingController(),
        updatePassNewController = TextEditingController(),
        updatePassOldController = TextEditingController(),
        updatePassConfirmController = TextEditingController(),
        forgotPNewPassword = TextEditingController(),
        forgotPOTP = TextEditingController(),
        forgotPEmail = TextEditingController(),
        forgotPConfirmPassword = TextEditingController(),
        isAgree = true,
        regConfirmPasswordController = TextEditingController();

  update(AuthState state) {
    return AuthState(
        loginEmailController: state.loginEmailController,
        loginPasswordController: state.loginPasswordController,
        regUserNameController: state.regUserNameController,
        regEmailController: state.regEmailController,
        regPasswordController: state.regPasswordController,
        regConfirmPasswordController: state.regConfirmPasswordController,
        updatePassConfirmController: state.updatePassConfirmController,
        updatePassNewController: state.updatePassNewController,
        updatePassOldController: state.updatePassOldController,
        forgotPEmail: state.forgotPEmail,
        forgotPNewPassword: state.forgotPNewPassword,
        forgotPConfirmPassword: state.forgotPConfirmPassword,
        forgotPOTP: state.forgotPOTP,
        isAgree: state.isAgree
    );
  }
}
