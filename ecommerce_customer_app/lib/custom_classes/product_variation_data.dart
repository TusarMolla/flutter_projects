


class ProductVariationData{
  String name;
  int id;
  List<ProductVariationValue> values;
  ProductVariationData({
    required this.id,
  required this.name,
  required this.values,
  });

}

class ProductVariationValue {
  var id;
  String name;
  var code;
  bool isChosen;

  ProductVariationValue({
    required this.id,
    required this.isChosen,
    required this.name,
    this.code,
  });
}