import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:home_expcenses/data_repo/iconList.dart';
import 'package:home_expcenses/helper/category_db_provider.dart';
import 'package:home_expcenses/helper/navHelper.dart';
import 'package:home_expcenses/models/categoryModel.dart';
import 'package:home_expcenses/views/screens/editCategoryPage.dart';
import 'package:provider/provider.dart';

class CategoryListWidget extends StatelessWidget {
  CategoryModel category;
  CategoryListWidget({required this.category});

  @override
  Widget build(BuildContext context) {
    return Consumer<Category_DB_provider>(
      builder: (context, provider, child) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 7, vertical: 5),
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 7),
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Delee Category'),
                          content:
                              const Text('This will not affict your bills'),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text("CANCEL")),
                            TextButton(
                                onPressed: () {
                                  provider.deleteCategory(category);
                                  Navigator.of(context).pop();
                                },
                                child: const Text("DELETE"))
                          ],
                        );
                      });
                },
                icon: const Icon(Icons.remove_circle),
                iconSize: 15,
                color: const Color.fromARGB(255, 25, 107, 175),
              ),
              const SizedBox(
                width: 7,
              ),
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
              // ignore: prefer_const_constructors
              IconButton(
                onPressed: () {
                  provider.selectIcon(category.iconId);
                  NavHelper.navigateToWidget(EditCategoryPage(
                    category: category,
                  ));
                },
                iconSize: 15,
                icon: const Icon(Icons.edit),
                color: Colors.grey,
              )
            ],
          ),
        );
      },
    );
  }
}
