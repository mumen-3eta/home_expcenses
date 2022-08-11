import 'package:home_expcenses/models/expensesModel.dart';

class DayModel {
  late String date;
  late List<ExpensesModel> exps;
  late double expenses;
  late double income;

  calculateExpenses() {
    expenses = 0;
    income = 0;
    for (ExpensesModel element in exps) {
      if (element.isExpenses) {
        expenses += element.value;
      } else {
        income += element.value;
      }
    }
  }
}
