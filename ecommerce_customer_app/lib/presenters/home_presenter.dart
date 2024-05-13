import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:grostore/apis/banners_api.dart';
import 'package:grostore/apis/category_api.dart';
import 'package:grostore/apis/product_api.dart';
import 'package:grostore/app_lang.dart';
import 'package:grostore/custom_ui/Button.dart';
import 'package:grostore/custom_ui/Image_view.dart';
import 'package:grostore/custom_ui/toast_ui.dart';
import 'package:grostore/helpers/device_info_helper.dart';
import 'package:grostore/models/common/category_info.dart';
import 'package:grostore/models/home_banner_response.dart';
import 'package:grostore/models/product_mini_response.dart';
import 'package:grostore/models/category_response.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class HomePresenter extends ChangeNotifier {
  static BuildContext? context;

  setContext(BuildContext context) {
    HomePresenter.context = context;
  }

  int currentSlider = 0;

  List<Widget> homeBannerImages = [];
  List<CategoryInfo> topCategoryList = [];
  List<ProductMini> bestSellingProductList = [];
  List<ProductMini> products = [];
  int page = 1;

  bool isTopCategoryInitial = false;
  bool isHomeBannerInitial = false;
  bool isBestSellingProductInitial = false;
  bool isAllProductInitial = false;
  ScrollController homeScrollController = ScrollController();

  fetchAll() {
    getProducts();
    fetchBannerImages();
    fetchTopCategories();
    fetBestSellingProducts();
  }

  Widget bannerImageSimple(BannerData data) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      child: Button(
        minWidth: getWidth(context),
        onPressed: () {},
        child: ImageView(
          url: data.image,
          width: getWidth(context),
          height: 200,
        ),
      ),
    );
  }

  getProducts() async {
    var productResponse = await ProductApi.getAllProducts(page: page);

    if (productResponse.statusCode == 200) {
      if (productResponse.object.data.isEmpty && page>1) {
        ToastUi.simpleToast(
            context!, AppLang.local(context!).no_more_data);
        return;
      }
      page++;
      print(productResponse.object.data.length);
      isAllProductInitial = true;
      products.addAll(productResponse.object.data);
      notifyListeners();
    } else {
      ToastUi.simpleToast(
          context!, AppLang.local(context!).something_went_wrong);
    }
  }

  onChangeBannerIndex(index) {
    currentSlider = index;
    notifyListeners();
  }

  fetchBannerImages() async {
    homeBannerImages = [];
    var bannerOneResponse = await BannersApi.homeBanner(context!);
    if (bannerOneResponse.statusCode == 200) {
      bannerOneResponse.object.data.forEach((slider) {
        homeBannerImages.add(bannerImageSimple(slider));
      });
      isHomeBannerInitial = true;

      notifyListeners();
    }
  }

  fetchTopCategories() async {
    var categoryResponse = await CategoryApi.topCategory();
    if (categoryResponse.statusCode == 200) {
      topCategoryList.addAll(categoryResponse.object.data);
      isTopCategoryInitial = true;
      notifyListeners();
    }
  }

  fetBestSellingProducts() async {
    var productResponse = await ProductApi.bestSelling(context!);

    if (productResponse.statusCode == 200) {
      bestSellingProductList.addAll(productResponse.object.data);
      isBestSellingProductInitial = true;
      notifyListeners();
    } else {
      ToastUi.show(context!, AppLang.local(context!).something_went_wrong);
    }
  }

  reset() {
    page=1;
    currentSlider = 0;
    homeBannerImages = [];
    topCategoryList = [];
    bestSellingProductList = [];
    products.clear();
    isAllProductInitial = false;
    isTopCategoryInitial = false;
    isHomeBannerInitial = false;
    isBestSellingProductInitial = false;
  }

  Future<void> onRefresh() async {
    reset();
    fetchAll();
  }

  changeCurrentSlider(index) {
    currentSlider = index;
    notifyListeners();
  }

  mainScrollListener(BuildContext context) {
    homeScrollController.addListener(() {
      //print("position: " + xcrollController.position.pixels.toString());
      //print("max: " + xcrollController.position.maxScrollExtent.toString());

      if (homeScrollController.position.pixels ==
          homeScrollController.position.maxScrollExtent) {
        ToastUi.simpleToast(context, "Loading more...");
        getProducts();
      }
    });
  }

  initState(BuildContext context) {
    mainScrollListener(context);
    reset();
    fetchAll();
  }

  @override
  void dispose() {
    super.dispose();
    reset();
  }
}
