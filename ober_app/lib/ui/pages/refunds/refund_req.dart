



import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ober_app/blocs/refund_bloc.dart';
import 'package:ober_app/config/style_config.dart';
import 'package:ober_app/custom_widgets/buttons.dart';
import 'package:ober_app/custom_widgets/seoAppbar.dart';
import 'package:ober_app/custom_widgets/seo_forms.dart';
import 'package:ober_app/custom_widgets/seo_toast.dart';
import 'package:ober_app/events/refund_events.dart';
import 'package:ober_app/helpers/main_helper.dart';

class RefundReqPage extends StatelessWidget {
   RefundReqPage({super.key,required this.id});

   final id;

  TextEditingController bankNameController = TextEditingController();
  TextEditingController accountNumberController = TextEditingController();
  TextEditingController bankHolderNameController = TextEditingController();
  TextEditingController branchNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: SeoAppbar.build(title: getLocal(context).refund),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(StyleConfig.padding),
        child: Column(children: [
          SeoForms.textField(title: getLocal(context).bank_name, controller: bankNameController,isRequired: true),
          space(),
          SeoForms.textField(title: getLocal(context).account_holder_name, controller: bankHolderNameController,isRequired: true),
          space(),

          SeoForms.textField(title: getLocal(context).account_number, controller: accountNumberController,isRequired: true),
          space(),

          SeoForms.textField(title: getLocal(context).branch_name, controller: branchNameController,isRequired: true),
          space(),

          SeoForms.textField(title: getLocal(context).phone_number, controller: phoneNumberController,isRequired: true),
          space(),
          Buttons.round(onPress: (){
            var bankName = bankNameController.text.trim();
            var accountNo = accountNumberController.text.trim();
            var name = bankHolderNameController.text.trim();
            var branch = branchNameController.text.trim();
            var phone = phoneNumberController.text.trim();
            
            if(bankName.isEmpty || accountNo.isEmpty || name.isEmpty || branch.isEmpty || phone.isEmpty){
              SEOToast.show(context, getLocal(context).please_provide_all_info);
              return;
            }
            context.read<RefundBloc>().add(RefundRequest(id: id, bankName: bankName, holderName: name, branchName: branch, phoneNo: phone, context: context, accountNo: accountNo));
            
            
            
          }, child: Text(getLocal(context).submit))
        ],),
      ),
    );
  }

Widget  space (){
    return SizedBox(height: 10,);

  }
}
