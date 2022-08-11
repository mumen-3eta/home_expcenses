import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:home_expcenses/data_repo/iconList.dart';
import 'package:home_expcenses/helper/category_db_provider.dart';
import 'package:home_expcenses/helper/expenses_db_provider.dart';
import 'package:home_expcenses/models/expensesModel.dart';
import 'package:home_expcenses/views/widgets/selectExpensesListWidget.dart';
import 'package:provider/provider.dart';

class EditExpencePage extends StatefulWidget {
  ExpensesModel expensesModel;
  EditExpencePage({required this.expensesModel});
  @override
  State<EditExpencePage> createState() => _EditExpencePageState();
}

class _EditExpencePageState extends State<EditExpencePage> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController expensesValueController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    expensesValueController.text = widget.expensesModel.value.toString();
    return Consumer2<Expenses_DB_provider, Category_DB_provider>(
        builder: (context, expensesProvider, categoryProvider, child) {
      return WillPopScope(
          onWillPop: () async {
            expensesProvider.resetDate();
            categoryProvider.resetSelectedCategory();
            return true;
          },
          child: Scaffold(
              key: scaffoldKey,
              floatingActionButton: FloatingActionButton(
                child: const Icon(Icons.done),
                onPressed: () {
                  if (double.parse(expensesValueController.text) == 0) {
                    return;
                  }
                  widget.expensesModel.iconId =
                      categoryProvider.selectedIconsId!;
                  widget.expensesModel.name = categoryProvider.selectedName!;
                  widget.expensesModel.value =
                      double.parse(expensesValueController.text);
                  widget.expensesModel.time = expensesProvider.dateMiliseconds;
                  widget.expensesModel.isExpenses =
                      categoryProvider.isExpenses!;
                  expensesProvider.updateExpenses(widget.expensesModel);
                  categoryProvider.resetSelectedCategory();
                  Navigator.of(context).pop();
                },
              ),
              appBar: AppBar(
                title: const Text(''),
                bottom: PreferredSize(
                    preferredSize: const Size.fromHeight(60),
                    child: SizedBox(
                      height: 60,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          children: [
                            CircleAvatar(
                                radius: 15,
                                backgroundColor:
                                    icons[categoryProvider.selectedIconsId!]
                                        .color,
                                child: SvgPicture.asset(
                                  icons[categoryProvider.selectedIconsId!].path,
                                  fit: BoxFit.cover,
                                  width: 18,
                                  color: Colors.white,
                                )),
                            const Spacer(),
                            SizedBox(
                              width: 110,
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                controller: expensesValueController,
                                style: const TextStyle(color: Colors.white),
                                textDirection: TextDirection.rtl,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    )),
              ),
              body: SingleChildScrollView(
                  child: SizedBox(
                height: MediaQuery.of(context).size.height - 147,
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 15),
                      child: Material(
                        elevation: 5,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              InkWell(
                                onTap: () async {
                                  DateTime? pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate:
                                          DateTime.fromMillisecondsSinceEpoch(
                                              expensesProvider.dateMiliseconds),
                                      firstDate: DateTime(1950),
                                      lastDate: DateTime(2100));

                                  if (pickedDate != null) {
                                    int year = pickedDate.year;
                                    int month = pickedDate.month;
                                    int day = pickedDate.day;
                                    String formattedDate = '$year-$month-$day';
                                    expensesProvider.changedate(formattedDate,
                                        pickedDate.millisecondsSinceEpoch);
                                  } else {}
                                },
                                child: Container(
                                  padding: EdgeInsets.zero,
                                  height: 60,
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.calendar_month_outlined,
                                        color: Colors.grey,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      const Text('Date'),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(expensesProvider.date),
                                      const Spacer(),
                                      const Icon(
                                        Icons.arrow_forward_ios,
                                        color: Colors.grey,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 15),
                      child: Material(
                        elevation: 5,
                        child: DefaultTabController(
                            length: 2,
                            child: SizedBox(
                              height: 400,
                              child: Scaffold(
                                appBar: const PreferredSize(
                                  preferredSize: Size.fromHeight(100),
                                  child: TabBar(
                                    padding: EdgeInsets.symmetric(vertical: 20),
                                    tabs: [
                                      Text(
                                        "Expenses",
                                        style: TextStyle(color: Colors.blue),
                                      ),
                                      Text("Income",
                                          style: TextStyle(color: Colors.blue))
                                    ],
                                  ),
                                ),
                                body: TabBarView(
                                  children: <Widget>[
                                    SingleChildScrollView(
                                      child: Column(
                                        children: categoryProvider.allCategory
                                            .where(
                                                (element) => element.isExpenses)
                                            .map((e) => SelectExpensesWidget(
                                                category: e))
                                            .toList(),
                                      ),
                                    ),
                                    SingleChildScrollView(
                                      child: Column(
                                        children: categoryProvider.allCategory
                                            .where((element) =>
                                                !element.isExpenses)
                                            .map((e) => SelectExpensesWidget(
                                                category: e))
                                            .toList(),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )),
                      ),
                    ),
                  ],
                ),
              ))));
    });
  }
}
