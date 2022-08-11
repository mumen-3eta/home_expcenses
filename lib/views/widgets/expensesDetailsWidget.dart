import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:home_expcenses/data_repo/iconList.dart';
import 'package:home_expcenses/helper/expenses_db_provider.dart';
import 'package:home_expcenses/helper/navHelper.dart';
import 'package:home_expcenses/models/expensesModel.dart';
import 'package:home_expcenses/views/screens/expensesDetailPage.dart';
import 'package:provider/provider.dart';

class ExpensesDetailsWidget extends StatelessWidget {
  ExpensesModel expensesModel;
  ExpensesDetailsWidget({required this.expensesModel});
  @override
  Widget build(BuildContext context) {
    return Consumer<Expenses_DB_provider>(
      builder: (context, provider, child) {
        return InkWell(
          onTap: () {
            DateTime date =
                DateTime.fromMillisecondsSinceEpoch(expensesModel.time);
            int year = date.year;
            int month = date.month;
            int day = date.day;
            String expDate = '$year-$month-$day';
            provider.changedate(expDate, expensesModel.time);
            NavHelper.navigateToWidget(
                ExpensesDetailPage(expensesModel: expensesModel));
          },
          child: Container(
            decoration: const BoxDecoration(
                border: Border(
                    top:
                        BorderSide(color: Color.fromARGB(255, 212, 209, 209)))),
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: icons[expensesModel.iconId].color,
                  radius: 15,
                  child: SvgPicture.asset(
                      fit: BoxFit.cover,
                      icons[expensesModel.iconId].path,
                      width: 18,
                      color: Colors.white),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  expensesModel.name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                Text(
                    (expensesModel.isExpenses ? '-' : '+') +
                        '${expensesModel.value}',
                    style: const TextStyle(color: Colors.blue))
              ],
            ),
          ),
        );
      },
    );
  }
}
