


import 'package:flutter/material.dart';
import 'package:grostore/custom_ui/common_appbar.dart';
import 'package:grostore/presenters/page_presenter.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Pages extends StatefulWidget {
  final String slug;

  const Pages({super.key, required this.slug});

  @override
  State<Pages> createState() => _PagesState();
}

class _PagesState extends State<Pages> {
  PagePresenter pagePresenter = PagePresenter();

  @override
  void initState() {
    // TODO: implement initState

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      pagePresenter.initState(widget.slug);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: pagePresenter,
      builder: (context,child) {
        return Scaffold(
          appBar: CommonAppbar.show(title: pagePresenter.pageInfo?.title??"", context: context),
        body:Padding(
          padding: const EdgeInsets.all(8.0),
          child: WebViewWidget(controller: pagePresenter.controller,),
        ) ,


        );
      }
    );
  }
}
