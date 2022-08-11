import 'package:home_expcenses/models/expensesModel.dart';

List<ExpensesModel> dumyexpenses = [
  ExpensesModel(
      iconId: 1, name: 'dddd', value: 5, time: 1659369000000, isExpenses: true),
  ExpensesModel(
      iconId: 2,
      name: 'defdd',
      value: 2,
      time: 1659455400000,
      isExpenses: true),
  ExpensesModel(
      iconId: 3,
      name: 'fddd',
      value: 6,
      time: 1659541800000,
      isExpenses: false),
  ExpensesModel(
      iconId: 4,
      name: 'dddfg',
      value: 9,
      time: 1659628200000,
      isExpenses: true),
  ExpensesModel(
      iconId: 5,
      name: 'ddfgdd',
      value: 10,
      time: 1659714600000,
      isExpenses: false),
  ExpensesModel(
      iconId: 5,
      name: 'ddfgdd',
      value: 10,
      time: 1659714600000,
      isExpenses: true),
];

Map<String, List<ExpensesModel>> sortedList = {};

sortToMap() {
  for (ExpensesModel element in dumyexpenses) {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(element.time);
    int year = date.year;
    int month = date.month;
    int day = date.day;
    String key = "$year-$month-$day";
    List<ExpensesModel>? exps = sortedList[key];
    if (exps != null) {
      exps.add(element);
    } else {
      exps = [element];
    }
    sortedList[key] = exps;
  }
}
