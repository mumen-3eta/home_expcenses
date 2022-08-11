import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:home_expcenses/data_repo/iconList.dart';
import 'package:home_expcenses/helper/category_db_provider.dart';
import 'package:home_expcenses/helper/expenses_db_provider.dart';
import 'package:home_expcenses/helper/navHelper.dart';
import 'package:home_expcenses/models/expensesModel.dart';
import 'package:home_expcenses/views/screens/editExpensesPage.dart';
import 'package:provider/provider.dart';

class ExpensesDetailPage extends StatelessWidget {
  ExpensesModel expensesModel;
  ExpensesDetailPage({required this.expensesModel});
  @override
  Widget build(BuildContext context) {
    return Consumer2<Expenses_DB_provider, Category_DB_provider>(
      builder: (context, expensesProvider, categoryProvider, child) {
        return WillPopScope(
          onWillPop: () async {
            expensesProvider.resetDate();
            return true;
          },
          child: Scaffold(
            appBar: AppBar(
              title: const Text('Detail'),
              actions: [
                IconButton(
                    onPressed: () {
                      expensesProvider.deleteExpenses(expensesModel);
                      expensesProvider.resetDate();
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.delete))
              ],
            ),
            body: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                children: [
                  Material(
                    elevation: 6,
                    child: Container(
                      height: 170,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 7),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 50,
                            child: Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor:
                                      icons[expensesModel.iconId].color,
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
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                const Spacer(),
                                Text(
                                    (expensesModel.isExpenses ? '-' : '+') +
                                        '${expensesModel.value}',
                                    style: const TextStyle(color: Colors.blue))
                              ],
                            ),
                          ),
                          Divider(
                            height: 1,
                            thickness: 1,
                            indent: 5,
                            endIndent: 5,
                            color: Colors.grey.withOpacity(0.4),
                          ),
                          SizedBox(
                            height: 50,
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.dashboard_rounded,
                                  color: Colors.black,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                const Text('Category'),
                                const Spacer(),
                                expensesModel.isExpenses
                                    ? const Text('Expenses')
                                    : const Text('Income'),
                              ],
                            ),
                          ),
                          Divider(
                            height: 1,
                            thickness: 1,
                            indent: 5,
                            endIndent: 5,
                            color: Colors.grey.withOpacity(0.4),
                          ),
                          SizedBox(
                            height: 50,
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.calendar_month,
                                  color: Colors.black,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                const Text('Date'),
                                const Spacer(),
                                Text(expensesProvider.date),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: 100,
                    child: ElevatedButton(
                        onPressed: () {
                          expensesProvider.changedate(
                              expensesProvider.date, expensesModel.time);
                          categoryProvider.changeSelectedCategory(
                              expensesModel.id!,
                              expensesModel.iconId,
                              expensesModel.name,
                              expensesModel.isExpenses,
                              false);
                          NavHelper.navigateToWidget(EditExpencePage(
                            expensesModel: expensesModel,
                          ));
                        },
                        child: Row(
                          children: const [
                            Icon(Icons.edit),
                            SizedBox(
                              width: 8,
                            ),
                            Text('EDIT')
                          ],
                        )),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
