import 'package:flutter/material.dart';
import 'package:grostore/app_lang.dart';
import 'package:grostore/configs/style_config.dart';
import 'package:grostore/configs/theme_config.dart';
import 'package:grostore/custom_classes/system_data.dart';
import 'package:grostore/custom_ui/Button.dart';
import 'package:grostore/custom_ui/category_ui.dart';
import 'package:grostore/custom_ui/common_appbar.dart';
import 'package:grostore/custom_ui/product_card.dart';
import 'package:grostore/custom_ui/shimmers.dart';
import 'package:grostore/helpers/common_functions.dart';
import 'package:grostore/helpers/device_info_helper.dart';
import 'package:grostore/helpers/route.dart';
import 'package:grostore/presenters/cart_presenter.dart';
import 'package:grostore/presenters/categories_presenter.dart';
import 'package:grostore/presenters/filter_presenter.dart';
import 'package:grostore/screens/auth/login.dart';
import 'package:grostore/screens/cart.dart';
import 'package:provider/provider.dart';

class Filter extends StatefulWidget {
  String? searchKey,
      sort_by,
      max_price,
      min_price,
      category_id,
      tag_id,
      per_page;
  bool isFocus;

  Filter(
      {Key? key,
      this.searchKey,
      this.sort_by,
      this.max_price,
      this.min_price,
      this.category_id,
      this.tag_id,
      this.per_page,
      this.isFocus=false})
      : super(key: key);

  @override
  State<Filter> createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<FilterPresenter>(context,listen: false).setContext(context);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    Provider.of<FilterPresenter>(context,listen: false).clearAll();
      if(!widget.isFocus) {
        Provider.of<FilterPresenter>(context, listen: false).setInitData(
            min_price: widget.min_price,
            max_price: widget.max_price,
            category_id: widget.category_id);
      Provider.of<FilterPresenter>(context, listen: false).initState();
      }
      Provider.of<FilterPresenter>(context, listen: false).getCategories();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeConfig.xxlightGrey,
      appBar: CommonAppbar.show(
          title: AppLang.local(context).filter,
          context: context,
          bottom: buildSearchOptions(context)),
      body: Consumer<FilterPresenter>(
          builder: (context, data, child) {
        return RefreshIndicator(
          onRefresh: data.onRefresh,
          child: buildProductSection(data),
        );
      }),
     bottomNavigationBar:BottomAppBar(
       color: ThemeConfig.white,
       child: Consumer<CartPresenter>(
         builder: (context, cart, child) {
           return Padding(
             padding:  EdgeInsets.symmetric(horizontal: StyleConfig.padding),
             child: Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                 Text(
                   "Your Cart: ${showPrice(cart.cartResponse.total)}",
                   style: StyleConfig.fs14fwNormal,
                 ),
                 Button(
                   color: ThemeConfig.green,
                     padding: EdgeInsets.symmetric(horizontal: 18,vertical: 8),
                     shape: StyleConfig.buttonRadius(5),
                     onPressed:  () {
                       if (SystemData.isLogIn) {
                         MakeRoute.go(context, Cart());
                       } else {
                         Navigator.push(
                             context, MaterialPageRoute(builder: (context) => Login()));
                         return;
                       }
                     },
                     child: Text("Go to Cart",style: StyleConfig.fs14cWhitefwNormal,))
               ],
             ),
           );
         },
       ),
     ) ,
     /* bottomSheet:BottomSheet(
        onClosing: (){}, builder: (context)=>Container(
        height: 250,
        width: getWidth(context),
        color: Colors.red,
        child: Consumer<FilterPresenter>(
            builder: (context, data, child) {
              return Column(
                children: [
                  spacer(height: 10),
                  headerTitle(AppLang.local(context).categories),
                  spacer(height: StyleConfig.xsSectionSpacer),
                  buildCategorySection(data),
                  spacer(height: StyleConfig.smSectionSpacer),
                  headerTitle(AppLang.local(context).price_range_ucf),
                  RangeSlider(
                    onChanged: (nPrice) {
                      data.onChangePrice(nPrice);
                      print(nPrice);
                    },
                    //onChangeEnd: data.onChangePrice,

                    min: 0,
                    max: 500,
                    values: data.price,
                  ),
                  Padding(
                    padding:
                    EdgeInsets.symmetric(horizontal: StyleConfig.padding),
                    child: Row(
                      children: [
                        Text(
                          data.price.start.round().toString(),
                          style: StyleConfig.fs14fwNormal,
                        ),
                        SizedBox(
                          width: StyleConfig.xsSectionSpacer,
                        ),
                        Text(
                          AppLang.local(context).to,
                          style: StyleConfig.fs14fwNormal,
                        ),
                        SizedBox(
                          width: StyleConfig.xsSectionSpacer,
                        ),
                        Text(
                          data.price.end.round().toString(),
                          style: StyleConfig.fs14fwNormal,
                        ),
                      ],
                    ),
                  )
                ],
              );
            }
        ),
      ))
*/
     /*bottomNavigationBar: Container(
       color: ThemeConfig.white,
      height: 280,
      width: getWidth(context),
      child: Consumer<FilterPresenter>(
          builder: (context, data, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                spacer(height: 10),
                headerTitle(AppLang.local(context).categories),
                spacer(height: StyleConfig.xsSectionSpacer),
                buildCategorySection(data),
                spacer(height: StyleConfig.smSectionSpacer),
                headerTitle(AppLang.local(context).price_range_ucf),
                RangeSlider(
                  onChanged: (nPrice) {
                    data.onChangePrice(nPrice);
                  },
                  min: 0,
                  max: 500,
                  values: (data.price),
                ),
                Padding(
                  padding:
                  EdgeInsets.symmetric(horizontal: StyleConfig.padding),
                  child: Row(
                    children: [
                      Text(
                        data.price.start.round().toString(),
                        style: StyleConfig.fs14fwNormal,
                      ),
                      SizedBox(
                        width: StyleConfig.xsSectionSpacer,
                      ),
                      Text(
                        AppLang.local(context).to,
                        style: StyleConfig.fs14fwNormal,
                      ),
                      SizedBox(
                        width: StyleConfig.xsSectionSpacer,
                      ),
                      Text(
                        data.price.end.round().toString(),
                        style: StyleConfig.fs14fwNormal,
                      ),
                    ],
                  ),
                ),
                Spacer(),
                Button(
                  color: ThemeConfig.green,
                    minWidth: getWidth(context),
                    padding: EdgeInsets.symmetric(vertical: 14),
                    onPressed: (){

                    },
                    child: Text(AppLang.local(context).filter,style: StyleConfig.fs16cWhitefwBold,))
              ],
            );
          }
      ),
    ),*/
    );
  }

  PreferredSize buildSearchOptions(BuildContext context) {
    return PreferredSize(
            preferredSize: Size(getWidth(context),50),
            child: Consumer<FilterPresenter>(
                builder: (context, data, child) {
                return Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: StyleConfig.padding14, vertical: 10),
                  width: getWidth(context),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(

                            border: Border.all(color: ThemeConfig.grey, width: 1),
                            borderRadius: BorderRadius.circular(8)),
                        padding: EdgeInsets.symmetric(
                            horizontal: StyleConfig.xsSectionSpacer, vertical: 10),

                        width: getWidth(context)-100,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: getWidth(context)-220,
                              child: TextField(
                                autofocus: widget.isFocus,
                                controller: data.searchTxt,
                                onEditingComplete: () {
                                  data.clearCategory();
                                  data.clearPriceRange();
                                  data.getFilteredProducts();
                                },
                                decoration: const InputDecoration.collapsed(hintText: "Search"),
                              ),
                            ),
                            SizedBox(
                              height: 30,
                              width: 30,

                              child: Button(
                                padding: EdgeInsets.zero,
                                minWidth: 30,
                                  onPressed: () {
                                    data.clearCategory();
                                    data.clearPriceRange();
                                    data.getFilteredProducts();
                                  },
                                  child: Icon(Icons.search,size:24,color: ThemeConfig.fontColor,)),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 60,
                        child: Button(
                          onPressed: (){
                            showFilterDialog();
                          },
                          shape: StyleConfig.buttonRadius(6),
                          color: ThemeConfig.green,
                            padding: EdgeInsets.symmetric( vertical: 16,horizontal: 10),
                          minWidth: 40,
                            child: Text(AppLang.local(context).filter,style: StyleConfig.fs14cWhitefwNormal,)),
                      )
                    ],
                  ),
                );
              }
            ),
    );
  }

  Widget buildCategorySection(FilterPresenter data) {
    return SizedBox(
      height: 87,
      child: data.isCategoryInit
          ? ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: StyleConfig.padding),
              itemBuilder: (context, index) {
                return SizedBox(
                  width: 100,
                  child: Button(
                    shape: StyleConfig.buttonRadius(0).copyWith(
                        side: BorderSide(
                            color: data.categories[index].id.toString() ==
                                    data.selectedCategoryId.toString()
                                ? ThemeConfig.accentColor
                                : ThemeConfig.noColor)),
                    padding: EdgeInsets.all(5),
                    onPressed: () {
                      data.onSelectCategory(data.categories[index].id);
                    },
                    child: CategoryUi(
                        img: data.categories[index].thumbnailImage,
                        name: data.categories[index].name),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(
                  width: 8,
                );
              },
              itemCount: data.categories.length)
          : Shimmers.horizontalList(8, 80, 80),
    );
  }

  Widget headerTitle(text) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: StyleConfig.padding),
      child: Text(
        text,
        style: StyleConfig.fs16fwBold,
      ),
    );
  }

  Widget spacer({height = 24}) {
    return SizedBox(
      height: double.parse(height.toString()),
    );
  }


  Widget  buildProductSection(FilterPresenter data){
    return GridView.builder(
        padding: EdgeInsets.symmetric(horizontal: StyleConfig.padding,vertical: StyleConfig.smSectionSpacer),
        physics: AlwaysScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 0.8),
        itemCount: data.products.length,
        itemBuilder: (context, index) {
          return ProductCard(
            product: data.products[index],context: this.context,);
        });
  }

  showFilterDialog(){
    showDialog(context: context, builder: (context)=>Consumer<FilterPresenter>(
      builder: (context,data,child) {
        return AlertDialog(

          title: Center(child: Text("Filter Form",style: StyleConfig.fs14fwBold,)),
          content: Container(
            height: getHeight(context)*0.28,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                headerTitle(AppLang.local(context).categories),
                spacer(height: StyleConfig.xsSectionSpacer),
                SizedBox(
                  width: getWidth(context),
                    child: buildCategorySection(data)),
                spacer(height: StyleConfig.smSectionSpacer),
                headerTitle(AppLang.local(context).price_range_ucf),
                RangeSlider(
                  onChanged: (nPrice) {
                    data.onChangePrice(nPrice);
                  },
                  min: 0,
                  max: 500,
                  values: (data.price),
                ),
                Padding(
                  padding:
                  EdgeInsets.symmetric(horizontal: StyleConfig.padding),
                  child: Row(
                    children: [
                      Text(
                        data.price.start.round().toString(),
                        style: StyleConfig.fs14fwNormal,
                      ),
                      SizedBox(
                        width: StyleConfig.xsSectionSpacer,
                      ),
                      Text(
                        AppLang.local(context).to,
                        style: StyleConfig.fs14fwNormal,
                      ),
                      SizedBox(
                        width: StyleConfig.xsSectionSpacer,
                      ),
                      Text(
                        data.price.end.round().toString(),
                        style: StyleConfig.fs14fwNormal,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          actions: [
            Button(
                shape: StyleConfig.buttonRadius(6),

                color: ThemeConfig.grey,
              onPressed: (){
                Navigator.pop(context);
              },
                child: Text(AppLang.local(context).close,style: StyleConfig.fs12cWhite,)),
            Button(
              shape: StyleConfig.buttonRadius(6),
              color: ThemeConfig.green,
                onPressed: (){
                  Navigator.pop(context);
                  data.clearKeyWord();
                  data.getFilteredProducts();
                }
                ,
                child: Text(AppLang.local(context).submit,style: StyleConfig.fs12cWhite))
          ],
        );
      }
    ));
  }

}
