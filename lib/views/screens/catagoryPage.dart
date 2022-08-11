import 'package:flutter/material.dart';
import 'package:home_expcenses/helper/navHelper.dart';
import 'package:home_expcenses/views/screens/addCategoryPage.dart';
import 'package:home_expcenses/views/screens/expensesListPage.dart';
import 'package:home_expcenses/views/screens/incomeListPage.dart';

class CategoryPage extends StatefulWidget {
  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage>
    with SingleTickerProviderStateMixin {
  TabController? tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Category Setting'),
          bottom: TabBar(
            tabs: const [Text('EXPENSES'), Text('INCOME')],
            controller: tabController,
          ),
        ),
        body: TabBarView(
          controller: tabController,
          children: [ExpensesList(), IncomeList()],
        ),
        bottomNavigationBar: GestureDetector(
          onTap: () {
            NavHelper.navigateToWidget(AddCategoryPage(
              isExpenses: tabController!.index == 0 ? true : false,
            ));
          },
          child: SizedBox(
            height: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.add_rounded, color: Colors.black),
                Text('ADD CATEGORY')
              ],
            ),
          ),
        ),
      ),
    );
  }
}
