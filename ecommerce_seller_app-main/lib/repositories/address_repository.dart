import 'package:active_ecommerce_seller_app/api_request.dart';
import 'package:active_ecommerce_seller_app/app_config.dart';
import 'package:active_ecommerce_seller_app/data_model/country_response.dart';
import 'package:http/http.dart' as http;

class AddressRepository {
  Future<CountryResponse> getCountryList() async {
    String url = ("${AppConfig.BASE_URL}/countries");
    final response = await ApiRequest.get(
      url: url,
    );

    return countryResponseFromJson(response.body);
  }
}
