import 'package:flutter/material.dart';
import 'package:grostore/apis/category_api.dart';
import 'package:grostore/apis/order_api.dart';
import 'package:grostore/apis/product_api.dart';
import 'package:grostore/app_lang.dart';
import 'package:grostore/custom_ui/loading.dart';
import 'package:grostore/custom_ui/toast_ui.dart';
import 'package:grostore/models/common/category_info.dart';
import 'package:grostore/models/order/orders_response.dart';
import 'package:grostore/models/category_response.dart';
import 'package:grostore/models/product_mini_response.dart';

class FilterPresenter extends ChangeNotifier {
  static BuildContext? context;

  ScrollController scrollController = ScrollController();
  TextEditingController searchTxt = TextEditingController();

  setContext(BuildContext context) {
    FilterPresenter.context = context;
  }

  int page = 1;
  int selectedCategoryId = 0;
  bool isCategoryInit = false;
  List<CategoryInfo> categories = [];
  List<ProductMini> products = [];

  RangeValues price=RangeValues(0, 5);

//fetch data
  getCategories() async {
    var response = await CategoryApi.getCategories(page);
    if (response.statusCode == 200 && response.object.data.isNotEmpty) {
      categories.addAll(response.object.data);
      page++;
      isCategoryInit = true;
      notifyListeners();
    }
  }
  getFilteredProducts() async {
    products.clear();
    Loading.show(FilterPresenter.context!);
    var productResponse = await ProductApi.getAllProducts(
      categoryId: selectedCategoryId==0?'':selectedCategoryId.toString(),
      min_price: price.start==0?'':price.start.round().toString(),
      max_price: price.end==0?'':price.end.round().toString(),
      search: searchTxt.text.isEmpty?'':searchTxt.text.trim().toString()
    );
Loading.close();

if(productResponse.statusCode==200) {
      products.addAll(productResponse.object.data);
      if(products.isEmpty) {
        ToastUi.show(context!, AppLang.local(context!).data_is_not_available);
      }
      notifyListeners();
    }else{
      ToastUi.show(context!, AppLang.local(context!).something_went_wrong);
    }

  }

  clearCategory(){
    selectedCategoryId=0;
    notifyListeners();
  }
  clearPriceRange(){
    price=RangeValues(0, 0);
    notifyListeners();
  }
  clearKeyWord(){
    searchTxt.clear();
    notifyListeners();
  }

//handlers
  Future<void> onRefresh() async {
    await clearAll();
    await fetchAll();
    return;
  }

  onSelectCategory(id) {
    selectedCategoryId = int.parse(id.toString());
    notifyListeners();
  }
  onChangePrice(newPrice) {
    price = newPrice;

    notifyListeners();
  }

  //others
  scrollListener() {
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent <=
          scrollController.position.pixels) {
        getCategories();
      }
    });
  }

  clearAll() {
    page = 1;
    isCategoryInit = false;
    categories.clear();
    products = [];
    price=const RangeValues(0, 1);
    searchTxt.text = "";

    notifyListeners();
  }

  fetchAll() {
    getCategories();
  }

  initState() {
    clearAll();
    scrollListener();
    fetchAll();
    getFilteredProducts();
  }
  setInitData({searchKey,
    sort_by,
    max_price,
    min_price,
    category_id,
    tag_id,
    per_page}){

    selectedCategoryId=int.parse((category_id??"0").toString());
    price= RangeValues(double.parse((min_price??0.0).toString()), double.parse((max_price??0.0).toString()));
    getFilteredProducts();

  }

  @override
  void dispose() {
    // TODO: implement dispose
    clearAll();
    scrollController.dispose();
    super.dispose();
  }
}
