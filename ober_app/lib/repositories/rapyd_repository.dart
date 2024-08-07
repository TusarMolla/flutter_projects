import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;
import 'package:ober_app/config/app_config.dart';




class RapyedReq{

  static makeSignature()async{
    var response = await makeRequest("get", "/v1/payment_methods/countries/IS");
    print(response);
  }

}



String generateString(int length) {
  const permittedChars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
  final random = Random();
  return List.generate(length, (index) => permittedChars[random.nextInt(permittedChars.length)]).join();
}

Future<Map<String, dynamic>> makeRequest(String method, String path, [Map<String, dynamic>? body]) async {
  final baseUrl = AppConfig.rapydApi;
  final secretKey = AppConfig.rapydSecretKey; // Never transmit the secret key by itself.
  final accessKey = AppConfig.rapydAccessKey; // The access key received from Rapyd.

  final idempotency = generateString(12); // Unique for each request.
  final salt = generateString(12); // Randomly generated for each request.
  final timestamp = (DateTime.now().millisecondsSinceEpoch / 1000).round(); // Current Unix time.

  final bodyString = body != null ? json.encode(body) : '';
  final sigString = '$method$path$salt$timestamp$accessKey$secretKey$bodyString';

  final hmacSha256 = Hmac(sha256, utf8.encode(secretKey)); // HMAC-SHA256
  final digest = hmacSha256.convert(utf8.encode(sigString));
  final signature = base64.encode(digest.bytes);


  final  headers = <String,String>{
    'Content-Type': 'application/json',
    'access_key': accessKey,
    'salt': salt,
    'timestamp': timestamp.toString(),
    'signature': signature,
    'idempotency': idempotency,
  };
  print(headers);
  print('$baseUrl$path');
  http.Response response;

  if (method.toLowerCase() == 'post') {
    response = await http.post(
      Uri.parse('$baseUrl$path'),
      headers: headers,
      body: bodyString,
    );

  } else {
    response = await http.get(
      Uri.parse('$baseUrl$path'),
      headers: headers,
    );
  }

  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    print(response.body);
    throw Exception('HTTP Error: ${response.statusCode} - ${response.reasonPhrase}');
  }
}