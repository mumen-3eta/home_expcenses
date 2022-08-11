import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:home_expcenses/data_repo/iconList.dart';
import 'package:home_expcenses/helper/expenses_db_helper.dart';
import 'package:home_expcenses/models/dayModel.dart';
import 'package:home_expcenses/models/expensesModel.dart';
import 'package:home_expcenses/models/file.dart';

class Expenses_DB_provider extends ChangeNotifier {
  late String date;
  late int dateMiliseconds;

  changedate(String newDate, int dateMili) {
    date = newDate;
    dateMiliseconds = dateMili;
    notifyListeners();
  }

  resetDate() {
    DateTime dateTime = DateTime.now();
    int year = dateTime.year;
    int month = dateTime.month;
    int day = dateTime.day;
    dateMiliseconds = dateTime.millisecondsSinceEpoch;
    date = '$year-$month-$day';
    notifyListeners();
  }

  List<ExpensesModel> allExpenses = [];
  Map<String, List<ExpensesModel>> sortedList = {};
  List<DayModel> allDays = [];

  Expenses_DB_provider() {
    DateTime dateTime = DateTime.now();
    int year = dateTime.year;
    int month = dateTime.month;
    int day = dateTime.day;
    date = '$year-$month-$day';
    dateMiliseconds = dateTime.millisecondsSinceEpoch;
    getAllExpenses();
  }

  fillLists(List<ExpensesModel> expenses) {
    allExpenses.clear();
    sortedList.clear();
    allDays.clear();
    allExpenses = expenses;
    for (ExpensesModel element in allExpenses) {
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
    List<String> days = sortedList.keys.toList();
    for (String element in days) {
      DayModel day = DayModel();
      day.date = element;
      day.exps = sortedList[element]!;
      day.calculateExpenses();
      allDays.add(day);
    }
    allDays.sort(mySortComparison);
    calculateThisMonthExpenses();
    notifyListeners();
  }

  int mySortComparison(DayModel a, DayModel b) {
    List<String> aNumber = a.date.split('-');
    List<String> bNumber = b.date.split('-');
    int aYear = int.parse(aNumber[0]);
    int aMontth = int.parse(aNumber[1]);
    int aDay = int.parse(aNumber[2]);

    int bYear = int.parse(bNumber[0]);
    int bMontth = int.parse(bNumber[1]);
    int bDay = int.parse(bNumber[2]);
    if (aYear < bYear) {
      return 1;
    } else if (aYear > bYear) {
      return -1;
    } else if (aMontth < bMontth) {
      return 1;
    } else if (aMontth > bMontth) {
      return -1;
    } else if (aDay < bDay) {
      return 1;
    } else {
      return -1;
    }
  }

  getAllExpenses() async {
    List<ExpensesModel> expenses =
        await Expenses_DBhelper.dbhelper.selectAllExpenses();
    fillLists(expenses);
  }

  addNewExpenses(ExpensesModel expense) async {
    await Expenses_DBhelper.dbhelper.insertNewExpenses(expense);
    getAllExpenses();
  }

  deleteExpenses(ExpensesModel expense) async {
    await Expenses_DBhelper.dbhelper.deleteOneExpenses(expense.id!);
    getAllExpenses();
  }

  updateExpenses(ExpensesModel expense) async {
    await Expenses_DBhelper.dbhelper.updateOneExpenses(expense);
    getAllExpenses();
  }

  List<ExpensesModel> thisMonthExpenses = [];
  late String thisMonth = '';
  late double thisMonthExpens = 0;
  late double thisMonthIncome = 0;

  calculateThisMonthExpenses() {
    thisMonthExpens = 0;
    thisMonthIncome = 0;
    thisMonthExpenses.clear();
    DateTime dateTime = DateTime.now();
    int year = dateTime.year;
    int month = dateTime.month;
    thisMonth = '$year-$month';
    for (DayModel element in allDays) {
      if (element.date.substring(0, 6) == thisMonth) {
        thisMonthExpenses.addAll(element.exps);
      }
    }
    for (ExpensesModel element in thisMonthExpenses) {
      if (element.isExpenses) {
        thisMonthExpens += element.value;
      } else {
        thisMonthIncome += element.value;
      }
    }
  }
}
