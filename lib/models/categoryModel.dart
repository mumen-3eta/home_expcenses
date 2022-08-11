import 'package:home_expcenses/helper/category_db_helper.dart';

class CategoryModel {
  int? id;
  late String name;
  late int iconId;
  late bool isExpenses;

  CategoryModel(
      {required this.name, required this.iconId, required this.isExpenses});

  Map<String, dynamic> toMap() {
    return {
      Category_DBhelper.categoryNameColumName: name,
      Category_DBhelper.categoryIconColumName: iconId,
      Category_DBhelper.categoryIsExpensesColumName: isExpenses ? 1 : 0
    };
  }

  CategoryModel.fromMap(Map<String, dynamic> map) {
    id = map[Category_DBhelper.categoryIdColumName];
    name = map[Category_DBhelper.categoryNameColumName];
    iconId = map[Category_DBhelper.categoryIconColumName];
    isExpenses =
        map[Category_DBhelper.categoryIsExpensesColumName] == 1 ? true : false;
  }
}
