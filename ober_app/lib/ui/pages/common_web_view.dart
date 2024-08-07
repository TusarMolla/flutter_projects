import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';



class CommonWebView extends StatefulWidget {
   CommonWebView({super.key,required this.uri});
  Uri uri;

  @override
  State<CommonWebView> createState() => _CommonWebViewState();
}

class _CommonWebViewState extends State<CommonWebView> {

  WebViewController controller= WebViewController();
  bool isLoaded = false;

  @override
  void initState() {
    // TODO: implement initState
    controller = controller..loadRequest(widget.uri)..setJavaScriptMode(JavaScriptMode.unrestricted);
    controller.setNavigationDelegate(NavigationDelegate(
      onPageFinished: (str){
        isLoaded = true;
        setState(() {

        });
      },

    ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: isLoaded?SafeArea(child: WebViewWidget(controller: controller)):Center(child: CircularProgressIndicator(),),
    );
  }
}
