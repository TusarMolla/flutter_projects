


import 'package:flutter/material.dart';
import 'package:ober_app/events/seo_event.dart';

class RefundEvents extends SeoEvent{

}


class OnInit extends RefundEvents{

}


class RefundRequest extends RefundEvents{
  var id;
 var bankName, holderName,branchName,phoneNo,accountNo;
 BuildContext context;

  RefundRequest(
      {
       required this.id,
        required this.bankName,
        required this.holderName,
        required this.branchName,
        required this.phoneNo,
        required this.context,
        required this.accountNo

      });
}