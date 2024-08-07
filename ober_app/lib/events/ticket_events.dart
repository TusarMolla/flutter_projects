import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:ober_app/custom_models/dropdown_model.dart';
import 'package:ober_app/events/seo_event.dart';


class TicketEvents extends SeoEvent{

}

class ResetData extends TicketEvents{
  BuildContext context;
  ResetData(this.context);
}

class ClearData extends TicketEvents{
}

class InitData extends TicketEvents{
 BuildContext context;


 InitData(this.context);
}

class OnPressDetails extends TicketEvents{
  BuildContext context;
  OnPressDetails(this.context);
}

class OnChangePriority extends TicketEvents{
  DropDownDataModel? dataModel;
  OnChangePriority(this.dataModel);
}

class OnSelectedFile extends TicketEvents{
  File? file;

  OnSelectedFile(this.file);
}
class OnSubmitTicket extends TicketEvents{
  BuildContext context;

  OnSubmitTicket(this.context);
}
class OnSubmitReplyTicket extends TicketEvents{
  BuildContext context;
  var id;
  OnSubmitReplyTicket(this.context,this.id);
}

class OnCloseTicket extends TicketEvents{
  var id;
  BuildContext context;
  OnCloseTicket({required this.id,required this.context});
}
class InitTicketReplies extends TicketEvents{
  var id;
  BuildContext context;
  InitTicketReplies({required this.id,required this.context});
}

class ClearTicketReplies extends TicketEvents{
  ClearTicketReplies();
}


class OnTicketDetails extends TicketEvents{
var id;

OnTicketDetails(this.id);
}

class OnSelectedReplyFile extends TicketEvents{
  File file;

  OnSelectedReplyFile(this.file);
}


