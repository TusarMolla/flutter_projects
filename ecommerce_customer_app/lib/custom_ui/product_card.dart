import 'package:flutter/material.dart';
import 'package:grostore/configs/style_config.dart';
import 'package:grostore/configs/theme_config.dart';
import 'package:grostore/custom_classes/system_data.dart';
import 'package:grostore/custom_ui/Button.dart';
import 'package:grostore/custom_ui/Image_view.dart';
import 'package:grostore/custom_ui/BoxDecorations.dart';
import 'package:grostore/helpers/common_functions.dart';
import 'package:grostore/helpers/route.dart';
import 'package:grostore/models/product_mini_response.dart';
import 'package:grostore/presenters/cart_presenter.dart';
import 'package:grostore/screens/auth/login.dart';
import 'package:grostore/screens/product_details.dart';
import 'package:provider/provider.dart';


class ProductCard extends StatelessWidget {
  late  ProductMini product;
 late BuildContext context;
   ProductCard({Key? key,required this.product,required this.context}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      width: 160,
      height: 160,
      decoration: BoxDecorations.shadow(radius: 8),
      //padding: EdgeInsets.all(8),
      child: Stack(
        children: [
          Button(
            minWidth: 160,
            onPressed: (){
              MakeRoute.productRoute(this.context, ProductDetails(slug: product.slug));
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    width: 160,
                   // padding: EdgeInsets.only(top: 10),
                    alignment: Alignment.center,
                    child: Hero(
                      tag: product,
                        child: ImageView(url: product.thumbnailImage,width: 134,height: 92,))),
                Padding(
                  padding: const EdgeInsets.only(left: 12.0,top: 12),
                  child: Text(product.categories.first.name,style: StyleConfig.fs10,),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12.0,top: 4),
                  child: Text(product.name,style: StyleConfig.fs14fwBold,maxLines: 2,),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12.0,top: 8),
                  child: Text(showPrice(product.price),style: StyleConfig.fs14cRedfwBold,),
                ),

              ],
            ),
          ),
          Positioned(
              bottom: -4,
              right: -4,
              child: Button.minSize(
                color: ThemeConfig.fontColor,
                onPressed: (){
                  if(SystemData.isLogIn){
                    if(product.variations.length==1) {
                      Provider.of<CartPresenter>(context, listen: false)
                          .addToCart(product.variations.first.id, 1, context);
                    }else{
                      MakeRoute.productRoute(this.context, ProductDetails(slug: product.slug));

                    }
                  }else{
                    MakeRoute.productRoute(this.context, Login());

                  }

                },
                width: 40,
                height: 40,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(8),bottomRight: Radius.circular(8))),
                child: Icon(Icons.add,color: ThemeConfig.white,),
              )),
        ],
      ),

    );
  }
}
