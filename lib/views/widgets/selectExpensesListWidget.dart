import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:home_expcenses/data_repo/iconList.dart';
import 'package:home_expcenses/helper/category_db_provider.dart';
import 'package:home_expcenses/models/categoryModel.dart';
import 'package:home_expcenses/models/expensesModel.dart';
import 'package:provider/provider.dart';

class SelectExpensesWidget extends StatelessWidget {
  CategoryModel category;
  SelectExpensesWidget({required this.category});
  @override
  Widget build(BuildContext context) {
    return Consumer<Category_DB_provider>(
      builder: (context, provider, child) {
        return InkWell(
          onTap: () {
            provider.changeSelectedCategory(category.id!, category.iconId,
                category.name, category.isExpenses, true);
          },
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: .7),
            decoration: const BoxDecoration(
                border: Border(
                    top:
                        BorderSide(color: Color.fromARGB(255, 212, 209, 209)))),
            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 10),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 15,
                  backgroundColor: icons[category.iconId].color,
                  child: SvgPicture.asset(
                      fit: BoxFit.cover,
                      icons[category.iconId].path,
                      width: 18,
                      color: Colors.white),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(category.name),
                const Spacer(),
                (provider.selectedCategory == category.id && provider.add!)
                    ? const Icon(
                        Icons.done,
                        color: Colors.blue,
                      )
                    : const SizedBox()
              ],
            ),
          ),
        );
      },
    );
  }
}
