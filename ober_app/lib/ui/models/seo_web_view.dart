import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';





class SeoWebView extends StatefulWidget {
  const SeoWebView({super.key,required this.uri});

  final Uri uri;


  @override
  State<SeoWebView> createState() => _SeoWebViewState();
}

class _SeoWebViewState extends State<SeoWebView> {

  WebViewController controller = WebViewController()..setJavaScriptMode(JavaScriptMode.unrestricted);



  @override
  void initState() {
    controller.loadRequest(widget.uri);

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: WebViewWidget(controller: controller),
    );
  }
}
