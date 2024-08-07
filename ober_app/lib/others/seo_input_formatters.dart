
import 'package:flutter/services.dart';

class CardExpFormatter extends TextInputFormatter{
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
      print(newValue.text);
    if(newValue.text.length==2 && !newValue.text.contains("/")&& !oldValue.text.contains("/")){
      return newValue.replaced(TextRange(start: 2, end: 2), "/");
    }
    return newValue;
  }

}