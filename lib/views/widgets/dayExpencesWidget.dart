import 'package:flutter/material.dart';
import 'package:home_expcenses/models/dayModel.dart';
import 'package:home_expcenses/views/widgets/expensesDetailsWidget.dart';

class DayExpwncesWidget extends StatelessWidget {
  DayModel dayModel;
  DayExpwncesWidget({required this.dayModel});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 7, vertical: 5),
      child: Material(
        elevation: 5,
        child: Column(
          children: [
            Container(
              color: Color.fromARGB(255, 212, 209, 209),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                child: Row(
                  children: [
                    Text(dayModel.date),
                    const Spacer(),
                    dayModel.expenses == 0
                        ? const SizedBox()
                        : Text('expenses -${dayModel.expenses}'),
                    const SizedBox(width: 5),
                    dayModel.income == 0
                        ? const SizedBox()
                        : Text('income +${dayModel.income}'),
                  ],
                ),
              ),
            ),
            ...dayModel.exps
                .map((e) => ExpensesDetailsWidget(expensesModel: e))
                .toList(),
          ],
        ),
      ),
    );
  }
}
