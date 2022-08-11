import 'package:home_expcenses/helper/expenses_db_helper.dart';

class ExpensesModel {
  int? id;
  late int iconId;
  late String name;
  late double value;
  late int time;
  late bool isExpenses;

  ExpensesModel(
      {id,
      required this.iconId,
      required this.name,
      required this.value,
      required this.time,
      required this.isExpenses});

  Map<String, dynamic> toMap() {
    return {
      Expenses_DBhelper.expensesNameColumName: name,
      Expenses_DBhelper.expensesIconColumName: iconId,
      Expenses_DBhelper.expensesValueColumName: value,
      Expenses_DBhelper.expensesTimeColumName: time,
      Expenses_DBhelper.isExpensesColumName: isExpenses ? 1 : 0
    };
  }

  ExpensesModel.fromMap(Map<String, dynamic> map) {
    id = map[Expenses_DBhelper.expensesIdColumName];
    name = map[Expenses_DBhelper.expensesNameColumName];
    iconId = map[Expenses_DBhelper.expensesIconColumName];
    value = map[Expenses_DBhelper.expensesValueColumName];
    time = map[Expenses_DBhelper.expensesTimeColumName];
    isExpenses = map[Expenses_DBhelper.isExpensesColumName] == 1 ? true : false;
  }
}
