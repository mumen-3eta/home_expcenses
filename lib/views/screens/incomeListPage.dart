import 'package:flutter/material.dart';
import 'package:home_expcenses/helper/category_db_provider.dart';
import 'package:home_expcenses/views/widgets/categoryListWidget.dart';
import 'package:provider/provider.dart';

class IncomeList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<Category_DB_provider>(
      builder: (context, provider, child) {
        return SingleChildScrollView(
          child: Column(
            children: provider.incomeCategory
                .map((e) => CategoryListWidget(
                      category: e,
                    ))
                .toList(),
          ),
        );
      },
    );
  }
}
