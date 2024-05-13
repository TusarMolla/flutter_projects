import 'package:flutter/material.dart';
import 'package:grostore/app_lang.dart';
import 'package:grostore/configs/style_config.dart';
import 'package:grostore/configs/theme_config.dart';
import 'package:grostore/custom_ui/Button.dart';
import 'package:grostore/custom_ui/common_appbar.dart';
import 'package:grostore/custom_ui/shimmers.dart';
import 'package:grostore/presenters/wishlist_presenter.dart';
import 'package:provider/provider.dart';
import '../custom_ui/product_card.dart';



class Wishlist extends StatefulWidget {
  const Wishlist({Key? key}) : super(key: key);

  @override
  State<Wishlist> createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> {

  WishlistPresenter data = WishlistPresenter();

  @override
  void initState() {
    // TODO: implement initState
    Provider.of<WishlistPresenter>(context,listen: false).setContext(context);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // Provider.of<WishlistPresenter>(context,listen: false).initState();
      data.initState();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        appBar: CommonAppbar.show(title: AppLang.local(context).wishlist, context: context),
        body: ListenableBuilder(
          listenable: data,
          builder: (context,child) {
            return Container(
              child: data.isWishlistInit?buildProductSection():Shimmers.gridShimmer(2, 10),
            );
          }
        ),
      );
  }
  Widget  buildProductSection(){
    return RefreshIndicator(
      onRefresh: data.reFresh,
      child: GridView.builder(
          padding: EdgeInsets.symmetric(horizontal: StyleConfig.padding,vertical: StyleConfig.smSectionSpacer),
          physics: AlwaysScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 0.8),
          itemCount: data.wishlists.length,
          itemBuilder: (context, index) {
            return Stack(
              fit: StackFit.expand,
              children: [
                ProductCard(
                  product: data.wishlists[index].product,context: this.context,),
                Positioned(
                  right: 0,
                  top: 0,
                  child: Button(
                    shape: StyleConfig.buttonRadius(25),
                    color: ThemeConfig.lightGrey,
                    onPressed: (){
                      data.deleteWishlist(data.wishlists[index].product.id,context);
                    },
                    minWidth: 10.0,
                    minHeight: 10.0,
                    padding: EdgeInsets.all(5),
                    child: Icon(Icons.delete,size: 24,color: Colors.red,),

                  ),
                )
              ],
            );
          }),
    );
  }
}
