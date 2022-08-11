import 'package:flutter/material.dart';
import 'package:home_expcenses/data_repo/iconList.dart';
import 'package:home_expcenses/helper/category_db_helper.dart';
import 'package:home_expcenses/helper/settingHelper.dart';
import 'package:home_expcenses/models/categoryModel.dart';

class Category_DB_provider extends ChangeNotifier {
  String path = icons[0].path;
  Color color = icons[0].color;
  int? id;

  Category_DB_provider() {
    bool? isFirstTime = SPhelper.sPhelper.sp!.getBool('isFirstTime');
    if (isFirstTime == null) {
      SPhelper.sPhelper.sp!.setBool('isFirstTime', false);
      addCategoriesOnce();
    }
    getAllCategory();
  }

  resetIcons() {
    color = icons[0].color;
    path = icons[0].path;
    id = null;
    for (int i = 0; i < icons.length; i++) {
      if (i == 0) {
        icons[i].selected = true;
      } else {
        icons[i].selected = false;
      }
    }
    notifyListeners();
  }

  selectIcon(int index) {
    path = icons[index].path;
    color = icons[index].color;
    icons[id ?? 0].selected = false;
    notifyListeners();
    id = index;
    icons[id!].selected = true;
    notifyListeners();
  }

  List<CategoryModel> allCategory = [];
  List<CategoryModel> expensesCategory = [];
  List<CategoryModel> incomeCategory = [];

  int? selectedCategory = 0;
  int? selectedIconsId = 0;
  bool? isExpenses = true;
  String? selectedName = '';
  bool? add = false;

  changeSelectedCategory(
      int id, int iconId, String name, bool isExps, bool ad) {
    selectedCategory = id;
    selectedIconsId = iconId;
    selectedName = name;
    isExpenses = isExps;
    add = ad;
    notifyListeners();
  }

  resetSelectedCategory() {
    changeSelectedCategory(allCategory.first.id!, allCategory.first.iconId,
        allCategory.first.name, allCategory.first.isExpenses, false);
  }

  addSelectedCategory() {
    changeSelectedCategory(allCategory.first.id!, allCategory.first.iconId,
        allCategory.first.name, allCategory.first.isExpenses, true);
  }

  fillLists(List<CategoryModel> category) {
    allCategory = category;
    changeSelectedCategory(category.first.id!, category.first.iconId,
        category.first.name, category.first.isExpenses, false);
    expensesCategory = category.where((element) => element.isExpenses).toList();
    incomeCategory =
        category.where((element) => !(element.isExpenses)).toList();
    notifyListeners();
  }

  getAllCategory() async {
    List<CategoryModel> category =
        await Category_DBhelper.dbhelper.selectAllCategory();

    fillLists(category);
  }

  addNewCategory(CategoryModel category) async {
    await Category_DBhelper.dbhelper.inserrNewCategory(category);
    getAllCategory();
  }

  deleteCategory(CategoryModel category) async {
    await Category_DBhelper.dbhelper.deleteOneCategory(category.id!);
    getAllCategory();
  }

  updateCategory(CategoryModel category) async {
    await Category_DBhelper.dbhelper.updateOneCategory(category);
    getAllCategory();
  }

  addCategoriesOnce() {
    List<CategoryModel> category = [
      CategoryModel(name: 'Electricity', iconId: 6, isExpenses: true),
      CategoryModel(name: 'Salary', iconId: 2, isExpenses: false),
      CategoryModel(name: 'Clothes', iconId: 11, isExpenses: true),
      CategoryModel(name: 'Food', iconId: 12, isExpenses: true),
      CategoryModel(name: 'Fruit', iconId: 13, isExpenses: true),
      CategoryModel(name: 'Transportation', iconId: 14, isExpenses: true),
      CategoryModel(name: 'Shopping', iconId: 15, isExpenses: true),
      CategoryModel(name: 'Home', iconId: 16, isExpenses: true),
      CategoryModel(name: 'Travel', iconId: 17, isExpenses: true),
      CategoryModel(name: 'Bills', iconId: 1, isExpenses: true),
      CategoryModel(name: 'Education', iconId: 21, isExpenses: true),
      CategoryModel(name: 'Snacks', iconId: 22, isExpenses: true),
      CategoryModel(name: 'Telephone', iconId: 24, isExpenses: true),
      CategoryModel(name: 'Baby', iconId: 25, isExpenses: true),
      CategoryModel(name: 'Sports', iconId: 26, isExpenses: true),
      CategoryModel(name: 'Tax', iconId: 28, isExpenses: true),
      CategoryModel(name: 'Health', iconId: 29, isExpenses: true),
      CategoryModel(name: 'Car', iconId: 31, isExpenses: true),
      CategoryModel(name: 'Office', iconId: 34, isExpenses: true),
      CategoryModel(name: 'Beauty', iconId: 38, isExpenses: true),
      CategoryModel(name: 'Rental', iconId: 39, isExpenses: false),
      CategoryModel(name: 'Grant', iconId: 40, isExpenses: false),
      CategoryModel(name: 'Refund', iconId: 41, isExpenses: false),
      CategoryModel(name: 'Award', iconId: 19, isExpenses: false),
      CategoryModel(name: 'Sale', iconId: 43, isExpenses: false),
      CategoryModel(name: 'Coupons', iconId: 44, isExpenses: false),
      CategoryModel(name: 'Others', iconId: 45, isExpenses: false),
    ];
    for (CategoryModel element in category) {
      addNewCategory(element);
    }
  }
}
