import 'package:flutter/material.dart';
import 'package:grostore/apis/order_api.dart';
import 'package:grostore/apis/page_api.dart';
import 'package:grostore/apis/refund_api.dart';
import 'package:grostore/apis/wallet_api.dart';
import 'package:grostore/app_lang.dart';
import 'package:grostore/models/order/orders_response.dart';
import 'package:grostore/models/page_response.dart';
import 'package:grostore/models/refund_response.dart';
import 'package:grostore/models/wallet_history_response.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PagePresenter extends ChangeNotifier {
  static BuildContext? context;

  setContext(BuildContext context) {
    PagePresenter.context = context;
  }

  bool isInitPageInfo = false;
  PageInfo? pageInfo;

  WebViewController controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted);

  getRefundHistory(slug) async {
    var response = await PageApi.getPage(slug: slug);
    if (response.statusCode == 200) {
      pageInfo = response.object.data;

      controller.loadHtmlString(htmlBody(response.object.data.content));
      isInitPageInfo = true;
      notifyListeners();
    }
  }

  String htmlBody(htmlCode) {
    return """
<!DOCTYPE html>
<html>

<head>
  <title>Title of the document</title>
  <style>
  *{
  margin:0;
  padding:0;
  }
    #wrap {
      padding: 0;
      overflow: hidden;
    }
    #scaled-frame {
      zoom: 2;
      -moz-transform: scale(2);
      -moz-transform-origin: 0 0;
      -o-transform: scale(2);
      -o-transform-origin: 0 0;
      -webkit-transform: scale(2);
      -webkit-transform-origin: 0 0;
    }
    #scaled-frame {
      border: 0px;      
    }

    @media screen and (-webkit-min-device-pixel-ratio:0) {
      #scaled-frame {
        zoom: 2;
      }

    }
  </style>
</head>

<body>
  <div id="scaled-frame">
$htmlCode
  </div>
</body>

</html>
""";
  }

  fetchAll(slug) async {
    getRefundHistory(slug);
  }

  Future<void> onRefresh(slug) {
    clearAll();
    return fetchAll(slug);
  }

  clearAll() {
    pageInfo = null;
    isInitPageInfo = false;
    notifyListeners();
  }

  initState(slug) {
    fetchAll(slug);
  }
}
