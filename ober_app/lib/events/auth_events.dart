



import 'package:flutter/cupertino.dart';
import 'package:ober_app/events/seo_event.dart';

class AuthEvents extends SeoEvent{

}

class OnPressLogin extends AuthEvents{
  BuildContext context;

  OnPressLogin(this.context);
}

class OnPressSignUp extends AuthEvents{
  BuildContext context;

  OnPressSignUp(this.context);
}

class OnUpdatePassword extends AuthEvents{
  BuildContext context;

  OnUpdatePassword(this.context);
}


class PrivacyAgree extends AuthEvents{
  bool agree;

  PrivacyAgree(this.agree);
}

class ForgotPassword extends AuthEvents{
  BuildContext context;

  ForgotPassword(this.context);
}
class ResetPassword extends AuthEvents{
  BuildContext context;

  ResetPassword(this.context);
}