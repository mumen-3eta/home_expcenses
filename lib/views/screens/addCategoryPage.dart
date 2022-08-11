import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:home_expcenses/data_repo/iconList.dart';
import 'package:flutter/services.dart';
import 'package:home_expcenses/helper/category_db_provider.dart';
import 'package:home_expcenses/models/categoryModel.dart';
import 'package:home_expcenses/models/iconModel.dart';
import 'package:provider/provider.dart';

class AddCategoryPage extends StatelessWidget {
  bool isExpenses;
  AddCategoryPage({required this.isExpenses});
  TextEditingController categoryNameController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  categoryNameValidator(String? name) {
    if (name == null || name == '' || name.isEmpty) {
      return 'category name is required';
    }
  }

  @override
  Widget build(BuildContext context) {
    log(isExpenses.toString());
    return Consumer<Category_DB_provider>(
      builder: (context, provider, child) {
        return WillPopScope(
          onWillPop: () async {
            provider.resetIcons();
            return true;
          },
          child: Form(
            key: formKey,
            child: Scaffold(
              appBar: AppBar(
                title: const Text('Add Category'),
                actions: [
                  IconButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          CategoryModel category = CategoryModel(
                              name: categoryNameController.text,
                              iconId: provider.id == null ? 0 : provider.id!,
                              isExpenses: isExpenses);
                          provider.addNewCategory(category);
                          provider.resetIcons();
                          Navigator.of(context).pop();
                        }
                      },
                      icon: const Icon(Icons.done))
                ],
              ),
              body: Column(
                children: [
                  Container(
                    margin:
                        const EdgeInsets.symmetric(vertical: 7, horizontal: 5),
                    child: Row(
                      children: [
                        CircleAvatar(
                            radius: 15,
                            backgroundColor: provider.color,
                            child: SvgPicture.asset(
                              provider.path,
                              fit: BoxFit.cover,
                              width: 18,
                              color: Colors.white,
                            )),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: categoryNameController,
                            validator: (value) => categoryNameValidator(value),
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(15),
                            ],
                            decoration: const InputDecoration(
                              labelText: 'Category name',
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: GridView.count(
                        crossAxisCount: 5,
                        crossAxisSpacing: 4,
                        mainAxisSpacing: 8,
                        scrollDirection: Axis.vertical,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        children: List.generate(icons.length, (index) {
                          return GestureDetector(
                            onTap: () {
                              provider.selectIcon(index);
                            },
                            child: Center(
                              child: CircleAvatar(
                                  radius: 15,
                                  backgroundColor: icons[index].selected
                                      ? provider.color
                                      : Colors.grey.withOpacity(0.3),
                                  child: SvgPicture.asset(
                                    fit: BoxFit.cover,
                                    icons[index].path,
                                    width: 18,
                                    color: icons[index].selected
                                        ? Colors.white
                                        : Colors.black,
                                  )),
                            ),
                          );
                        }),
                      ),
                    ),
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
