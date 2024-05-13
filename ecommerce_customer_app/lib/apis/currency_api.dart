import 'package:grostore/api_request.dart';
import 'package:grostore/configs/app_config.dart';
import 'package:grostore/helpers/shared_value_helper.dart';
import 'package:grostore/models/currency_response.dart';
import 'package:grostore/models/response_model.dart';

class CurrencyApi {
  Future<ResponseModel<CurrencyResponse>> getList() async {
    var url = "${AppConfig.apiUrl}/currencies";
    Map<String, String> header = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "App-Language": app_language.$,
    };
    ApiResponse response = await ApiRequest.get(url, header);

    if (response.result) {
      return ResponseModel(response.statusCode,currencyResponseFromJson(response.body));
    } else {
      return ResponseModel(response.statusCode,CurrencyResponse(data: []));
    }
  }
}
