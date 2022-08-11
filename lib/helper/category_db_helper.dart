import 'dart:developer';
import 'package:home_expcenses/models/categoryModel.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Category_DBhelper {
  Category_DBhelper._();
  static Category_DBhelper dbhelper = Category_DBhelper._();
  static const String tableName = 'category';
  static const String categoryIdColumName = 'id';
  static const String categoryNameColumName = 'name';
  static const String categoryIconColumName = 'icon_id';
  static const String categoryIsExpensesColumName = 'is_expenses';
  late Database database;
  initDatabase() async {
    database = await createConnectionWithDatabase();
  }

  Future<Database> createConnectionWithDatabase() async {
    String databasePath = await getDatabasesPath();
    String databaseName = 'tasks.db';
    String fullPath = join(databasePath, databaseName);
    Database database =
        await openDatabase(fullPath, version: 1, onCreate: (db, i) {
      log('table created');
      db.execute('''CREATE TABLE $tableName (
            $categoryIdColumName INTEGER PRIMARY KEY AUTOINCREMENT, 
            $categoryNameColumName TEXT, 
            $categoryIconColumName INTEGER,
            $categoryIsExpensesColumName INTEGER)
            ''');
    }, onOpen: (db) {
      log('table opened');
    });

    return database;
  }

  inserrNewCategory(CategoryModel category) async {
    int rowIndex = await database.insert(tableName, category.toMap());
    log(rowIndex.toString());
  }

  Future<List<CategoryModel>> selectAllCategory() async {
    List<Map<String, Object?>> categoryMap = await database.query(tableName);
    List<CategoryModel> categorys =
        categoryMap.map((e) => CategoryModel.fromMap(e)).toList();
    return categorys;
  }

  selectOneCategory(int id) {
    database
        .query(tableName, where: '$categoryIdColumName = ?', whereArgs: [id]);
  }

  updateOneCategory(CategoryModel category) {
    database.update(tableName, category.toMap(),
        where: '$categoryIdColumName = ?', whereArgs: [category.id]);
  }

  deleteOneCategory(int id) {
    database
        .delete(tableName, where: '$categoryIdColumName = ?', whereArgs: [id]);
  }
}
