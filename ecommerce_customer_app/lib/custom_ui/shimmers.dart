import 'package:flutter/material.dart';
import 'package:grostore/configs/style_config.dart';
import 'package:grostore/configs/theme_config.dart';
import 'package:shimmer/shimmer.dart';

class Shimmers extends StatelessWidget {
  late double width, height;
  double? radius;

  Shimmers(
      {Key? key, required this.width, required this.height, this.radius = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: Shimmer.fromColors(
        baseColor: ThemeConfig.xlightGrey,
        highlightColor: ThemeConfig.lightGrey,
        child: Container(
            decoration: BoxDecoration(
              color: ThemeConfig.mediumGrey,
              borderRadius:
                  radius != null ? BorderRadius.circular(radius!) : null,
            ),
            width: width,
            height: height),
      ),
    );
  }

  static list(int items, double width, double height) {
    return ListView.separated(
      physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Shimmers(width: width, height: height);
        },
        separatorBuilder: (context, index) {
          return const SizedBox(
            height: 10,
          );
        },
        itemCount: items);
  }

  static horizontalList(int items, double width, double height) {
    return ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: StyleConfig.padding),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Shimmers(width: width, height: height);
        },
        separatorBuilder: (context, index) {
          return SizedBox(
            width: 10,
          );
        },
        itemCount: items);
  }

  static gridShimmer(int crossAxisCount, int items,
      {double width: 160, double height: 186, double radius: 8}) {
    return GridView.builder(
        padding: EdgeInsets.symmetric(horizontal: StyleConfig.padding),
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 0.8),
        itemCount: items,
        itemBuilder: (context, index) {
          return Shimmers(
            width: double.parse(width.toString()),
            height: double.parse(height.toString()),
            radius: double.parse(radius.toString()),
          );
        });
  }
}
