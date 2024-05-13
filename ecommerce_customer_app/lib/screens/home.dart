
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:grostore/app_lang.dart';
import 'package:grostore/configs/style_config.dart';
import 'package:grostore/configs/theme_config.dart';
import 'package:grostore/custom_ui/BoxDecorations.dart';
import 'package:grostore/custom_ui/Button.dart';
import 'package:grostore/custom_ui/category_ui.dart';
import 'package:grostore/custom_ui/product_card.dart';
import 'package:grostore/custom_ui/shimmers.dart';
import 'package:grostore/helpers/common_functions.dart';
import 'package:grostore/helpers/device_info_helper.dart';
import 'package:grostore/helpers/route.dart';
import 'package:grostore/presenters/home_presenter.dart';
import 'package:grostore/screens/filter.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  String? id;

  Home({Key? key, this.id}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    // TODO: implement initState
    Provider.of<HomePresenter>(context,listen: false).setContext(context);
    Provider.of<HomePresenter>(context, listen: false).initState(context);

    super.initState();
  }

  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   Provider.of<HomePresenter>(context, listen: false).dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ThemeConfig.xxlightGrey,
        appBar: buildSearchOption(context),
        body: Consumer<HomePresenter>(builder: (context, data, child) {
          return RefreshIndicator(
            onRefresh: data.onRefresh,
            child: SingleChildScrollView(
              controller: data.homeScrollController,
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildSliderSection(data),
                    SizedBox(
                      height: 14,
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: StyleConfig.padding),
                      child: Row(
                        children: [
                          Text(
                            AppLang.local(context).top_categories_ucf,
                            style: StyleConfig.fs16fwBold,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Image.asset(
                            getAssetIcon("fire.png"),
                            height: 20,
                            width: 20,
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    buildTopCategorySection(data),
                    SizedBox(
                      height: 14,
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: StyleConfig.padding),
                      child: Row(
                        children: [
                          Text(
                            AppLang.local(context).best_selling_products_ucf,
                            style: StyleConfig.fs16fwBold,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Image.asset(
                            getAssetIcon("fire.png"),
                            height: 20,
                            width: 20,
                          )
                        ],
                      ),
                    ),
                   const SizedBox(
                      height: 10,
                    ),
                    Container(
                     // color: Colors.red,
                      height:200,
                        child: buildBestSellingProductSection(data)),
                   const SizedBox(height: 14,),
                    Padding(
                      padding:
                      EdgeInsets.symmetric(horizontal: StyleConfig.padding),
                      child: Row(
                        children: [
                          Text(
                            AppLang.local(context).all_products_ucf,
                            style: StyleConfig.fs16fwBold,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Image.asset(
                            getAssetIcon("fire.png"),
                            height: 20,
                            width: 20,
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    allProducts(data),
                    const SizedBox(
                      height: 14,
                    ),

                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Container buildTopCategorySection(HomePresenter data) {
    return Container(
      height: 87,
      child: data.isTopCategoryInitial
          ? ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: StyleConfig.padding),
              itemBuilder: (context, index) {
                return Button(
                  minWidth: 40,
                  onPressed: (){
                    MakeRoute.go(context, Filter(category_id:data.topCategoryList[index].id.toString() ,));
                  },
                  child: SizedBox(
                    width: 100,
                    child: CategoryUi(

                        img: data.topCategoryList[index].thumbnailImage,
                        name: data.topCategoryList[index].name),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(
                  width: 8,
                );
              },
              itemCount: data.topCategoryList.length)
          : categoryShimmer(),
    );
  }

  SizedBox buildSliderSection(HomePresenter data) {
    return SizedBox(
      height: 170,
      child: CarouselSlider(
        items:
            data.isHomeBannerInitial ? data.homeBannerImages : sliderShimmer(),
        options: CarouselOptions(
          aspectRatio: 2,
          viewportFraction: 0.94,
          height: 150,
         // enlargeCenterPage: true,
          scrollDirection: Axis.horizontal,
          autoPlay: true,
          onPageChanged: (index, reason) {
            data.onChangeBannerIndex(index);
          },
        ),
      ),
    );
  }

  PreferredSize buildSearchOption(BuildContext context) {
    return PreferredSize(
        preferredSize: Size(getWidth(context), 54),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 14),
          margin: EdgeInsets.only(top:12, left: 24, right: 24),
          width: getWidth(context),
          decoration: BoxDecorations.shadow(radius: 6.0),
          child: Button(
            onPressed: ()=>MakeRoute.go(context, Filter(isFocus: true,)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  getAssetIcon("search.png"),
                  height: 16,
                  width: 16,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  AppLang.local(context).search_product_ucf,
                  style: StyleConfig.fs12cGrey,
                )
              ],
            ),
          ),
        ));
  }

  List<Widget> sliderShimmer() {
    return [
      Shimmers(width: getWidth(context) - 40, height: 200),
      Shimmers(width: getWidth(context) - 40, height: 200),
      Shimmers(width: getWidth(context) - 40, height: 200),
      Shimmers(width: getWidth(context) - 40, height: 200),
    ];
  }

  ListView categoryShimmer() {
    return ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: StyleConfig.padding),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Shimmers(
            width: 76,
            height: 87,
            radius: 6.0,
          );
        },
        separatorBuilder: (context, index) {
          return SizedBox(
            width: 8,
            height: 10,
          );
        },
        itemCount: 10);
  }

  Widget allProductShimmer() {
    return GridView.builder(
        padding: EdgeInsets.symmetric(horizontal: StyleConfig.padding),
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 0.8),
        itemCount: 10,
        itemBuilder: (context, index) {
          return Shimmers(width: 160, height: 186,radius: 8,);
        });
  }
  
Widget  buildBestSellingProductSection(HomePresenter data){
   return
     data.isBestSellingProductInitial
      // false
           ?
       ListView.separated(
         padding: EdgeInsets.symmetric(horizontal: StyleConfig.padding),
         scrollDirection: Axis.horizontal,
           itemBuilder: (context, index) {
         return ProductCard(
           product: data.bestSellingProductList[index],context: this.context,);
       }, separatorBuilder: (context,index)=>SizedBox(width: 10,), itemCount: data.bestSellingProductList.length)
       :Shimmers.horizontalList(10, 160, 160);
  }



Widget  allProducts(HomePresenter data){
   return data.isAllProductInitial?GridView.builder(
        padding: EdgeInsets.only(left: StyleConfig.padding,right: StyleConfig.padding,bottom: 20),

       shrinkWrap: true,
       physics: NeverScrollableScrollPhysics(),

       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
           crossAxisCount: 2,
           crossAxisSpacing: 16,
           mainAxisSpacing: 16,
           childAspectRatio: 0.8),
        itemCount: data.products.length,
        itemBuilder: (context, index) {
          return ProductCard(
              product: data.products[index],context: this.context,);
        }):allProductShimmer();
  }
}
