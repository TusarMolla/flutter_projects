

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:grostore/apis/user_api.dart';
import 'package:grostore/app_lang.dart';
import 'package:grostore/custom_classes/system_data.dart';
import 'package:grostore/custom_ui/loading.dart';
import 'package:grostore/custom_ui/toast_ui.dart';
import 'package:grostore/models/user/addresses_response.dart';
import 'package:image_picker/image_picker.dart';

class UserPresenter extends ChangeNotifier{

  static BuildContext? context;
  setContext(BuildContext context){
    UserPresenter.context=context;
  }
  List<AddressInfo> addresses =[];
  bool isFetchAddress = false;
  final TextEditingController nameController =
  TextEditingController(text: SystemData.userInfo.name);

  final TextEditingController phoneController =
  TextEditingController(text: SystemData.userInfo.phone);

  TextEditingController emailController =
  TextEditingController(text:SystemData.userInfo.email);
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmController = TextEditingController();

  bool showPassword= false;
  bool showConfirmPassword = false;

  //for image uploading
  final ImagePicker _picker = ImagePicker();
  XFile? file;

  chooseAndUploadImage(context) async {
      file = await _picker.pickImage(source: ImageSource.gallery);
      notifyListeners();
  }

  Future<void> _onPageRefresh() async {}

  onPressUpdate(BuildContext context) async {
    var name = nameController.text.toString();
    var phone = phoneController.text.toString();
    File? tmpFile;
    if(file !=null){
      tmpFile =File(file!.path);
    }

    Loading.show(context);
    var response =
    await UserApi.updateProfile(file: tmpFile,name: name,phone: phone);
Loading.close();
    ToastUi.show(context,response.object.message);
    if (response.object.result)  {
      SystemData.userInfo.name = name;
      SystemData.userInfo.phone = phone;
    }
  }

  onPressUpdatePassword(BuildContext context) async {
    var password = passwordController.text.toString();
    var password_confirm = passwordConfirmController.text.toString();

    var change_password = password != "" ||
        password_confirm !=
            ""; // if both fields are empty we will not change user's password

    if (!change_password && password == "") {
      ToastUi.show(context, "Password is empty");
      return;
    }
    if (!change_password && password_confirm == "") {
      ToastUi.show(context, "Confirm Password is empty");
      return;
    }
    if (change_password && password.length < 6) {
      ToastUi.show(context, AppLang.local(context).password_must_be_at_last_6_digit);
      return;
    }
    if (change_password && password != password_confirm) {
      ToastUi.show(context, "Password and Confirm Password does not matched!");
      return;
    }

    var post_body = jsonEncode({"password": "$password","password_confirmation": "$password_confirm"});

    var res =
    await UserApi.updatePassword( post_body);
    ToastUi.show(context, res.object.message);
  }

  Future<void> refresh(){
    return Future(() => 0) ;
  }

  passwordShowHide(){
    showPassword=!showPassword;
    notifyListeners();
  }
  conPasswordShowHide(){
    showConfirmPassword=!showConfirmPassword;
    notifyListeners();
  }

  fetchAddresses()async{
    var res = await UserApi.getAddresses();
    addresses.clear();
    addresses.addAll(res.data);
    isFetchAddress=true;
    notifyListeners();
  }

  initState(){
    fetchAddresses();

  }

  addAddress(){
  }

  getCountries(){

  }

}