class CategoryModel {
  String? id;
  String? title;
  bool? isExpanded = false;
  bool? isSelected;
  double? height;
  List<CategoryModel> children;

  CategoryModel(
      {this.id,
      this.title,
      this.isExpanded,
      this.isSelected,
      this.children = const [],
      this.height});

// setLevelText() {
//   String tmpTxt = "";
//   for (int i = 0; i < level!; i++) {
//     tmpTxt += "–";
//   }
//   levelText = "$tmpTxt $levelText";
// }
}
