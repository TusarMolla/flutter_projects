import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:grostore/apis/auth_api.dart';
import 'package:grostore/app_lang.dart';
import 'package:grostore/constant/country_code.dart';
import 'package:grostore/custom_classes/system_data.dart';
import 'package:grostore/custom_ui/loading.dart';
import 'package:grostore/custom_ui/toast_ui.dart';
import 'package:grostore/helpers/common_functions.dart';
import 'package:grostore/helpers/route.dart';
import 'package:grostore/helpers/shared_value_helper.dart';
import 'package:grostore/models/auth/login_response_model.dart';
import 'package:grostore/models/common/user_info.dart';
import 'package:grostore/models/user_info_response_model.dart';
import 'package:grostore/screens/main.dart';

class AuthPresenter extends ChangeNotifier {
  UserInfo userInfo = userInfoResponseDefault().data;
  static BuildContext? _context;

  static BuildContext get getContext => _context!;

  setContext(BuildContext context) {
    AuthPresenter._context = context;
  }

  List<Country> country = CountryCode().get();

  List<Country> filteredCountry = CountryCode().get();

  void filterCountry(String query) {
    query = query.toLowerCase();

    filteredCountry = country.where((product) {
      if (product.name.toLowerCase().contains(query)) {
        return true;
      } else {
        return false;
      }
    }).toList();
    notifyListeners();
  }

  //controllers
  TextEditingController loginPhoneNumberController = TextEditingController();
  TextEditingController loginEmailController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();

  String loginBy = "email"; //phone or email
  String initialCountry = 'US';
  var countriesCode = <String>[];
  Country regCountry = CountryCode().get().first;
  String loginPhone = "";
  late String loginEmail, loginPassword;

  /// Registration variables
  String registerBy = "email"; //phone or email
  String regPhone = "";
  bool isAgree = false;

  //controllers
  TextEditingController regNameController = TextEditingController();
  TextEditingController regEmailController = TextEditingController();
  TextEditingController regPhoneNumberController = TextEditingController();
  TextEditingController regPasswordController = TextEditingController();
  TextEditingController regPasswordConfirmController = TextEditingController();

  fetch_country() async {
    // var data = await AddressRepository().getCountryList();
    // data.countries.forEach((c) => countries_code.add(c.code));
  }

  onPressedLogin() async {
    if (checkLoginValidation()) {
      makeLogin();
    }
  }

  String makeLoginPostBody() {
    return jsonEncode({
      "email": loginEmail,
      "type": "customer",
      "password": loginPassword,
    });
  }

  bool checkLoginValidation() {
    loginEmail = loginEmailController.text.toString().trim();
    loginPassword = loginPasswordController.text.toString().trim();
    if (loginBy == "email") {
      if (loginEmail.isEmpty || !isEmail(loginEmail)) {
        ToastUi.show(_context!, AppLang.getLocal().please_enter_valid_email);
        return false;
      }
    } else {
      ///todo phone no validation
      return false;
    }

    if (loginPassword.isEmpty) {
      return false;
    }
    return true;
  }

  makeLogin() async {
    Loading.show(_context!);
    LoginResponse response =
        await AuthApi.login(makeLoginPostBody(), _context!);
    Loading.close();
    if (response.result) {
      access_token.update((p0) => response.accessToken);
      access_token.save();
      loginEmailController.clear();
      loginPasswordController.clear();
      SystemData.isLogIn = true;
      SystemData.userInfo = response.user;
      MakeRoute.goAndRemoveAll(_context!, Main());
      //UserInfo(name: response.name, email: response.email, phone: response.phone, balance: response.balance, avatar: response.avatar);
    }
    ToastUi.show(_context!, response.message);
  }

  tokenCheck(BuildContext context) async {
    var response = await AuthApi.tokenCheck(context);
    if (response.result) {
      SystemData.isLogIn = response.result;
      SystemData.userInfo = response.user;
    }
    notifyListeners();
  }

  logout(BuildContext context) async {
    var response = await AuthApi.logout(context);
    if (response.result) {
      SystemData.isLogIn = false;
      SystemData.userInfo = response.user;
    }
    notifyListeners();
  }

  ///registration methods

  onChangeCountry(Country country) {
    regCountry = country;
    notifyListeners();
  }

  String makeRegBody(name, email, phone, password, confirmPassword) {
    return jsonEncode({
      "name": name,
      "email": email,
      "phone": phone,
      "password": password,
      "password_confirmation": confirmPassword
    });
  }

  onPressSignUp() async {
    var name = regNameController.text.toString();
    var email = regEmailController.text.toString();
    var password = regPasswordController.text.toString();
    var password_confirm = regPasswordConfirmController.text.toString();
    regPhone = regPhoneNumberController.text.trim();
    if (regPhone.isNotEmpty) {
      regPhone = regCountry.dial_code + regPhone;
    }

    if (name == "") {
      ToastUi.show(_context!, AppLang.local(_context!).please_enter_name);
      return;
    } else if (registerBy == 'email' && (email == "" || !isEmail(email))) {
      ToastUi.show(_context!, AppLang.local(_context!).please_enter_email);
      return;
    } else if (registerBy == 'phone' && regPhone == "") {
      ToastUi.show(_context!, AppLang.local(_context!).please_enter_phone);
      return;
    } else if (password == "") {
      ToastUi.show(_context!, AppLang.local(_context!).please_enter_password);
      return;
    } else if (password_confirm == "") {
      ToastUi.show(
          _context!, AppLang.local(_context!).please_enter_confirm_password);
      return;
    } else if (password.length < 6) {
      ToastUi.show(
          _context!, AppLang.local(_context!).password_must_be_at_last_6_digit);
      return;
    } else if (password != password_confirm) {
      ToastUi.show(
          _context!,
          AppLang.local(_context!)
              .password_and_confirm_password_is_not_matching);
      return;
    }

    var body = makeRegBody(name, email, regPhone, password, password_confirm);
    Loading.show(_context!);
    var signupResponse = await AuthApi.registration(_context!, body);
    Loading.close();
    print(signupResponse.toJson());
    if (signupResponse.result == false) {
      var message = "";
      if (signupResponse.message.runtimeType == List) {
        signupResponse.message.forEach((key, value) {
          value.forEach((messages) {
            message += messages + "\n";
          });
        });
      } else {
        message = signupResponse.message;
      }

      ToastUi.show(_context!, message);
    } else {
      ToastUi.show(_context!, signupResponse.message);
      access_token.update((p0) => signupResponse.accessToken);
      access_token.save();
      loginEmailController.clear();
      loginPasswordController.clear();
      SystemData.isLogIn = true;
      SystemData.userInfo = signupResponse.user;
      MakeRoute.goAndRemoveAll(_context!, Main());

      // if ((mail_verification_status.$ && _register_by == "email") ||
      //     _register_by == "phone") {
      //   Navigator.push(context, MaterialPageRoute(builder: (context) {
      //     return Otp(
      //       verify_by: _register_by,
      //       user_id: signupResponse.user_id,
      //     );
      //   }));
      //
      // } else {
      //   Navigator.push(context, MaterialPageRoute(builder: (context) {
      //     return Login();
      //   }));
      // }
    }
  }

  ///

  /// ForgetPassword
  ///

  //controllers
  TextEditingController forgetEmailController = TextEditingController();
  TextEditingController forgetPhoneNumberController = TextEditingController();

  onPressSendCode() async {
    var email = forgetEmailController.text.toString();

    if (email == "") {
      ToastUi.show(_context!, AppLang.local(_context!).please_enter_email);
      return;
    }

    var passwordForgetResponse = await AuthApi.forgetPassword(_context!, email);

    if (passwordForgetResponse.result == false) {
      ToastUi.show(_context!, passwordForgetResponse.message);
    } else {
      ToastUi.show(_context!, passwordForgetResponse.message);

      // Navigator.push(context, MaterialPageRoute(builder: (context) {
      //   return PasswordOtp(
      //     verify_by: _send_code_by,
      //   );
      // }));
    }
  }

  /// Otp
  ///

  //controllers
  TextEditingController otpCodeController = TextEditingController();
  TextEditingController otpPasswordController = TextEditingController();
  TextEditingController otpPasswordConfirmController = TextEditingController();
  bool otpResetPasswordSuccess = false;

  onPressConfirm() async {
    var code = otpCodeController.text.toString();
    var password = otpPasswordController.text.toString();
    var password_confirm = otpPasswordConfirmController.text.toString();

    if (code == "") {
      ToastUi.show(
        _context!,
        AppLang.local(_context!).enter_otp_code,
      );
      return;
    } else if (password == "") {
      ToastUi.show(_context!, AppLang.local(_context!).please_enter_password);
      return;
    } else if (password_confirm == "") {
      ToastUi.show(
          _context!, AppLang.local(_context!).please_enter_confirm_password);
      return;
    } else if (password.length < 6) {
      ToastUi.show(
          _context!, AppLang.local(_context!).password_must_be_at_last_6_digit);
      return;
    } else if (password != password_confirm) {
      ToastUi.show(
          _context!,
          AppLang.local(_context!)
              .password_and_confirm_password_is_not_matching);
      return;
    }

    var passwordConfirmResponse =
        await AuthApi.forgetPassword(_context!, password);

    if (passwordConfirmResponse.result == false) {
      ToastUi.show(_context!, passwordConfirmResponse.message);
    } else {
      ToastUi.show(_context!, passwordConfirmResponse.message);
    }
  }

  onTapResend() async {
    var passwordResendCodeResponse =
        await AuthApi.forgetPassword(_context!, "");

    if (passwordResendCodeResponse.result == false) {
      ToastUi.show(_context!, passwordResendCodeResponse.message);
    } else {
      ToastUi.show(_context!, passwordResendCodeResponse.message);
    }
  }
}
