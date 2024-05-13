import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:grostore/app_lang.dart';
import 'package:grostore/configs/style_config.dart';
import 'package:grostore/configs/theme_config.dart';
import 'package:grostore/custom_classes/system_data.dart';
import 'package:grostore/custom_ui/BoxDecorations.dart';
import 'package:grostore/custom_ui/Button.dart';
import 'package:grostore/custom_ui/Image_view.dart';
import 'package:grostore/custom_ui/common_appbar.dart';
import 'package:grostore/custom_ui/product_card.dart';
import 'package:grostore/custom_ui/shimmers.dart';
import 'package:grostore/custom_ui/toast_ui.dart';
import 'package:grostore/helpers/common_functions.dart';
import 'package:grostore/helpers/device_info_helper.dart';
import 'package:grostore/helpers/route.dart';
import 'package:grostore/presenters/cart_presenter.dart';
import 'package:grostore/presenters/product_details_presenter.dart';
import 'package:grostore/presenters/wishlist_presenter.dart';
import 'package:grostore/screens/auth/login.dart';
import 'package:grostore/screens/cart.dart';
import 'package:badges/badges.dart' as badges;
import 'package:provider/provider.dart';

class ProductDetails extends StatefulWidget {
  late String slug;

  ProductDetails({Key? key, required this.slug}) : super(key: key);

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  // WishlistPresenter wishlistPresenter =  WishlistPresenter();

  @override
  void initState() {
    Provider.of<ProductDetailsPresenter>(context, listen: false)
        .setContext(context);
    Future.delayed(Duration(seconds: 0)).then((value) {
      Provider.of<ProductDetailsPresenter>(context, listen: false)
          .iniState(widget.slug);
    });

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductDetailsPresenter>(builder: (context, data, child) {
      return Scaffold(
        backgroundColor: ThemeConfig.xxlightGrey,
        appBar: CommonAppbar.show(
            title: data.productInfo != null ? data.productInfo!.name : "",
            context: context),
        body: RefreshIndicator(
          onRefresh: data.onRefresh,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildSliderSection(data),
                buildProductNameSection(context, data),
                SizedBox(
                  height: 16,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: StyleConfig.padding),
                  child: Text(
                    AppLang.local(context).description,
                    style: StyleConfig.fs14fwBold,
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                data.isProductInfoInitial
                    ? Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: StyleConfig.padding),
                        child: Text(
                          data.productInfo?.shortDescription??"",
                          style: StyleConfig.fs14fwNormal.copyWith(height: 1.8),
                        ),
                      )
                    : Shimmers(width: getWidth(context), height: 150),
               const SizedBox(
                  height: 16,
                ),
                if (data.productInfo != null)
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: StyleConfig.padding),
                    child: ListView.separated(
                        physics:const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, variationIndex) {
                          return Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data.variations[variationIndex].name,
                                  style: StyleConfig.fs16fwBold,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Wrap(
                                  spacing: 10,
                                  children: List.generate(
                                      data.variations[variationIndex].values
                                          .length, (valueIndex) {
                                    return Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 5, vertical: 5),
                                      decoration: BoxDecorations.shadow(radius: 6)
                                          .copyWith(
                                              border: Border.all(
                                                  color: data
                                                          .variations[
                                                              variationIndex]
                                                          .values[valueIndex]
                                                          .isChosen
                                                      ? ThemeConfig.accentColor
                                                      : ThemeConfig.grey,
                                                  width: 2)),
                                      child: InkWell(
                                        onTap: () {
                                          data.onChangeVariation(
                                              variationIndex, valueIndex);
                                        },
                                        child: data.variations[variationIndex]
                                                    .id ==
                                                2
                                            ? Container(
                                                height: 40,
                                                width: 40,
                                                color: Color(int.parse(data
                                                    .variations[variationIndex]
                                                    .values[valueIndex]
                                                    .code)),
                                              )
                                            : Text(
                                                data.variations[variationIndex]
                                                    .values[valueIndex].name,
                                                style: StyleConfig.fs14fwNormal,
                                              ),
                                      ),
                                    );
                                  }),
                                )
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            height: 16,
                          );
                        },
                        itemCount: data.variations.length),
                  ),
                SizedBox(
                  height: 16,
                ),
                buildPriceAndQuantitySection(context, data),
                SizedBox(
                  height: 16,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: StyleConfig.padding),
                  child: Text(
                    AppLang.local(context).related_product_ucf,
                    style: StyleConfig.fs16fwBold,
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                buildRelatedProductSection(data),
              ],
            ),
          ),
        ),
        /*floatingActionButton: Container(
          //margin: EdgeInsets.symmetric(horizontal: StyleConfig.padding),
          width: getWidth(context),
          height: 70,
          //color: Colors.red,
          child:Button(
            shape: StyleConfig.buttonRadius(10),
            color: ThemeConfig.accentColor,
            minWidth: getWidth(context)-40,
            onPressed: (){},
            child: Text(AppLang.local(context).add_to_cart,style: StyleConfig.fs14cWhitefwNormal,),
          ),
        ),
*/

        // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        bottomNavigationBar: data.selectedVariation != null
            ? SizedBox(
                width: getWidth(context),
                height: 50,
                child: Button(
                  color: ThemeConfig.fontColor,
                  minWidth: getWidth(context) - 40,
                  onPressed: () {
                    if (SystemData.isLogIn) {
                      MakeRoute.go(context, Cart());
                    }else{
                      MakeRoute.go(context, Login());
                    }
                  },
                  child: Consumer<CartPresenter>(
                      builder: (context,data,child) {
                        return Padding(
                          padding:  EdgeInsets.symmetric(horizontal: StyleConfig.padding),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Total: ${showPrice(data.cartResponse.subTotal)}",style: StyleConfig.fs16cWhitefwBold,),
                              Text(
                               AppLang.local(context).go_to_cart,
                              style:  StyleConfig.fs16cWhitefwBold,
                            ),
                          ],
                      ),
                        );
                    }
                  ),
                ),
              )
            : null,
      );
    });
  }

  Widget relatedProductShimmer() {
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
          return Shimmers(
            width: 160,
            height: 186,
            radius: 8,
          );
        });
  }

  Widget buildRelatedProductSection(ProductDetailsPresenter data) {
    return data.isRelatedInitial
        ? GridView.builder(
            padding: EdgeInsets.only(
              left: StyleConfig.padding,
              right: StyleConfig.padding,
              bottom: StyleConfig.padding,
            ),
            shrinkWrap: true,
            physics:const NeverScrollableScrollPhysics(),
            gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.8),
            itemCount: data.relatedProducts.length,
            itemBuilder: (context, index) {
              return ProductCard(
                product: data.relatedProducts[index],
                context: this.context,
              );
            })
        : relatedProductShimmer();
  }

  Container buildPriceAndQuantitySection(
      BuildContext context, ProductDetailsPresenter data) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: StyleConfig.padding),
      height: 50,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                AppLang.local(context).price,
                style: StyleConfig.fs14fwBold,
              ),
              SizedBox(
                height: 6,
              ),
              data.isProductInfoInitial
                  ? Text(showPrice(data.selectedVariation!.price),
                      style: StyleConfig.fs16cRedfwBold)
                  : Shimmers(width: 100, height: 25),
            ],
          ),
          Spacer(),
          Consumer<WishlistPresenter>(
            // listenable: wishlistPresenter,
            builder: (context,wishlistPresenter,child) {
              return Button(
                onPressed: () {
                  if(SystemData.isLogIn) {
                    if(wishlistPresenter.isAddedWishlist) {
                        wishlistPresenter.deleteWishlist(data.productInfo!.id,context);
                      }else{
                      wishlistPresenter.addWishlist(data.productInfo!.id, context);
                    }

                    } else {
                    MakeRoute.go(context,const Login());
                  }
                },
                  child: Icon(wishlistPresenter.isAddedWishlist? Icons.favorite:Icons.favorite_border,color: ThemeConfig.red,size: 35,));
            },
          ),
          Button(
            minWidth:40,
            shape: StyleConfig.buttonRadius(6),
            color: ThemeConfig.accentColor,
            padding: EdgeInsets.symmetric(horizontal: 24,vertical: 12),
            onPressed: () {
              if (SystemData.isLogIn) {
                if (data.selectedVariation!.sock > 0) {
                  Provider.of<CartPresenter>(context, listen: false)
                      .addToCart(data.selectedVariation!.id,
                      data.quantity, context);
                } else {
                  ToastUi.show(context, "Stock out");
                }
              }else{
                MakeRoute.go(context, Login());
              }

            },
            child:Text(AppLang.local(context).add_to_cart,style: StyleConfig.fs14cWhitefwNormal,)
            /* Icon(
              Icons.add_shopping_cart_outlined,
              color: ThemeConfig.white,
              size: 18,
            ),*/
          ),
          /*Button(

            minWidth: 30,
            shape: CircleBorder(),
            color: ThemeConfig.fontColor,
            padding: EdgeInsets.all(8),
            onPressed: () {
              data.decrementQty();
            },
            child: Icon(
              Icons.remove,
              color: ThemeConfig.white,
              size: 18,
            ),
          ),
          Container(
              padding: EdgeInsets.symmetric(horizontal: 5),
              constraints: BoxConstraints(minWidth: 40),
              alignment: Alignment.center,
              child: Text(
                "${data.quantity}",
                style: StyleConfig.fs14fwBold,
              )),
          Button(
            minWidth: 30,
            shape: CircleBorder(),
            color: ThemeConfig.accentColor,
            padding: EdgeInsets.all(8),
            onPressed: () {
              data.incrementQty();
            },
            child: Icon(
              Icons.add,
              color: ThemeConfig.white,
              size: 18,
            ),
          ),*/
        ],
      ),
    );
  }

  Container buildProductNameSection(
      BuildContext context, ProductDetailsPresenter data) {
    return Container(
      height: 60,
      width: getWidth(context),
      color: ThemeConfig.white,
      child: Container(
          alignment: Alignment.bottomLeft,
          padding: EdgeInsets.only(left: StyleConfig.padding),
          decoration: BoxDecorations.customRadius(
              radius: BorderRadius.only(topLeft: Radius.circular(70)),
              color: ThemeConfig.xxlightGrey),
          child: data.isProductInfoInitial
              ? Text(
                  data.productInfo!.name,
                  style: StyleConfig.fs20fwBold,
                )
              : Shimmers(width: 170, height: 30)),
    );
  }

  Widget buildSliderSection(ProductDetailsPresenter data) {
    return Container(
      height: 200,
      decoration: BoxDecorations.customRadius(
          radius: BorderRadius.only(bottomRight: Radius.circular(70))),
      child: Column(
        children: [
          Stack(
            children: [
              CarouselSlider(
                items: data.isProductInfoInitial
                    ? buildImages(data)
                    : sliderShimmer(),
                options: CarouselOptions(
                  aspectRatio: 1,
                  height: 150,
                  enlargeCenterPage: true,
                  scrollDirection: Axis.horizontal,
                  autoPlay: true,
                  onPageChanged: (index, reason) {
                    data.onChangeBannerIndex(index);
                  },
                ),
              ),
              /*Positioned(
                  right: 10,
                  top: 10,
                  child: Button(
                    onPressed: () {
                      MakeRoute.go(context, const Cart());
                    },
                    shape: StyleConfig.buttonRadius(30),
                    padding: EdgeInsets.all(8),
                    color:ThemeConfig.amber,
                    minWidth: 35,
                    child: badges.Badge(
                      position: badges.BadgePosition.custom(end: 12, bottom: -15),
                      badgeStyle: badges.BadgeStyle(
                          shape: badges.BadgeShape.circle,
                          badgeColor: ThemeConfig.red,
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(width: 1, color: ThemeConfig.white)
                        //padding: EdgeInsets.all(5),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Image.asset(
                          getAssetIcon("cart.png"),
                          color: ThemeConfig.white,
                          height: 20,
                        ),
                      ),
                      badgeContent: Consumer<CartPresenter>(
                        builder: (context, cart, child) {
                          return Text(
                            "${cart.cartResponse.cartCount}",
                            style: TextStyle(fontSize: 10, color: Colors.white),
                          );
                        },
                      ),
                    ),
                  )
              )*/
            ],
          ),
         const SizedBox(
            height: 24,
          ),
          if (data.isProductInfoInitial)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: data.productInfo!.galleryImages.map((page) {
                int index = data.productInfo!.galleryImages.indexOf(page);
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 100),
                  width: data.currentSlider == index ? 20 : 8,
                  height: 8,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    // shape: BoxShape.circle,
                    borderRadius: BorderRadius.circular(5),
                    color: data.currentSlider == index
                        ? ThemeConfig.accentColor
                        : ThemeConfig.accentColor.withOpacity(0.4),
                  ),
                );
              }).toList(),
            ),
        ],
      ),
    );
  }

  Widget imageSample(String data) {
    //  print(data);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      child: ImageView(
        url: data,
        width: getWidth(context) - 40,
        height: 200,
      ),
    );
  }

  buildImages(ProductDetailsPresenter data) {
    List<Widget> sliders = [];
    data.productInfo!.galleryImages.forEach((image) {
      sliders.add(imageSample(image));
    });
    return sliders;
  }

  List<Widget> sliderShimmer() {
    return [
      Shimmers(width: getWidth(context) - 40, height: 200),
      Shimmers(width: getWidth(context) - 40, height: 200),
      Shimmers(width: getWidth(context) - 40, height: 200),
      Shimmers(width: getWidth(context) - 40, height: 200),
    ];
  }
}
