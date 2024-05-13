import 'package:flutter/material.dart';
import 'package:grostore/apis/category_api.dart';
import 'package:grostore/apis/order_api.dart';
import 'package:grostore/app_lang.dart';
import 'package:grostore/models/common/category_info.dart';
import 'package:grostore/models/order/orders_response.dart';
import 'package:grostore/models/category_response.dart';

class CategoriesPresenter extends ChangeNotifier {
  static BuildContext? context;

   ScrollController scrollController = ScrollController();
  setContext(BuildContext context) {
    CategoriesPresenter.context = context;
  }

  List<CategoryInfo> categories = [];
  int page = 1;
  bool isCategoryInit=false;

  getCategories() async {
    var response = await CategoryApi.getCategories(page);
    print(response.object.data);
    if (response.statusCode == 200 && response.object.data.isNotEmpty) {
      categories.addAll(response.object.data);
      page++;
      isCategoryInit=true;
      notifyListeners();
    }

  }

  fetchAll() {
    getCategories();
  }

  scrollListener(){
    scrollController.addListener(() {
      if(scrollController.position.maxScrollExtent <= scrollController.position.pixels){
        getCategories();
      }
    });
  }

  clearAll() {
    page = 1;
    isCategoryInit=false;
    categories.clear();
    notifyListeners();
  }

 Future<void> onRefresh()async{
    await clearAll();
   return fetchAll();
  }

  initState() {
    onRefresh();
    scrollListener();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    clearAll();
    scrollController.dispose();
    super.dispose();
  }
}
