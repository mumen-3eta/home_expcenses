import 'dart:developer';
import 'package:home_expcenses/models/expensesModel.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Expenses_DBhelper {
  Expenses_DBhelper._();
  static Expenses_DBhelper dbhelper = Expenses_DBhelper._();
  static const String tableName = 'expenses';
  static const String expensesIdColumName = 'id';
  static const String expensesNameColumName = 'name';
  static const String expensesIconColumName = 'icon_id';
  static const String expensesValueColumName = 'value';
  static const String expensesTimeColumName = 'time';
  static const String isExpensesColumName = 'is_expenses';
  late Database database;
  initDatabase() async {
    database = await createConnectionWithDatabase();
  }

  Future<Database> createConnectionWithDatabase() async {
    String databasePath = await getDatabasesPath();
    String databaseName = 'expenses.db';
    String fullPath = join(databasePath, databaseName);
    Database database =
        await openDatabase(fullPath, version: 1, onCreate: (db, i) {
      log('table created');
      db.execute('''CREATE TABLE $tableName (
            $expensesIdColumName INTEGER PRIMARY KEY AUTOINCREMENT, 
            $expensesNameColumName TEXT, 
            $expensesIconColumName INTEGER,
            $isExpensesColumName INTEGER,
            $expensesValueColumName REAL,
            $expensesTimeColumName INTEGER)
            ''');
    }, onOpen: (db) {
      log('table opened');
    });

    return database;
  }

  insertNewExpenses(ExpensesModel expenses) async {
    int rowIndex = await database.insert(tableName, expenses.toMap());
    log(rowIndex.toString());
  }

  Future<List<ExpensesModel>> selectAllExpenses() async {
    List<Map<String, Object?>> expensesMap = await database.query(tableName);
    List<ExpensesModel> expenses =
        expensesMap.map((e) => ExpensesModel.fromMap(e)).toList();
    return expenses;
  }

  selectOneExpenses(int id) {
    database
        .query(tableName, where: '$expensesIdColumName = ?', whereArgs: [id]);
  }

  updateOneExpenses(ExpensesModel expenses) async {
    int rowIndex = await database.update(tableName, expenses.toMap(),
        where: '$expensesIdColumName = ?', whereArgs: [expenses.id]);
    log(rowIndex.toString());
  }

  deleteOneExpenses(int id) {
    database
        .delete(tableName, where: '$expensesIdColumName = ?', whereArgs: [id]);
  }
}
