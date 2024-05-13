import 'package:flutter/material.dart';
import 'package:grostore/app_lang.dart';
import 'package:grostore/configs/theme_config.dart';
import 'package:grostore/custom_ui/Button.dart';
import 'package:grostore/custom_ui/category_ui.dart';
import 'package:grostore/custom_ui/common_appbar.dart';
import 'package:grostore/custom_ui/shimmers.dart';
import 'package:grostore/helpers/device_info_helper.dart';
import 'package:grostore/helpers/route.dart';
import 'package:grostore/presenters/categories_presenter.dart';
import 'package:grostore/screens/filter.dart';
import 'package:provider/provider.dart';

class Categories extends StatefulWidget {
  Categories({Key? key, this.fromBottomBar = true}) : super(key: key);
  bool fromBottomBar;

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  @override
  void initState() {
    // TODO: implement initState
    Provider.of<CategoriesPresenter>(context, listen: false)
        .setContext(context);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<CategoriesPresenter>(context, listen: false).initState();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeConfig.xxlightGrey,
      appBar: CommonAppbar.show(
          title: AppLang.local(context).categories,
          context: context,
          showBackButton: !widget.fromBottomBar),
      body: Consumer<CategoriesPresenter>(builder: (context, data, child) {
        return RefreshIndicator(
            onRefresh: data.onRefresh,
            child: data.isCategoryInit
                ? GridView.builder(
                    controller: data.scrollController,
                    padding: EdgeInsets.only(
                        left: 10,
                        right: 10,
                        top: 10,
                        bottom: widget.fromBottomBar ? 80 : 10),
                    itemCount: data.categories.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                            childAspectRatio: 1),
                    itemBuilder: (context, index) => Button(
                          minWidth: getWidth(context),
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            MakeRoute.go(
                                context,
                                Filter(
                                  category_id:
                                      data.categories[index].id.toString(),
                                ));
                          },
                          child: CategoryUi(
                              img: data.categories[index].thumbnailImage,
                              name: data.categories[index].name),
                        ))
                : Shimmers.gridShimmer(3, 15));
      }),
    );
  }
}
