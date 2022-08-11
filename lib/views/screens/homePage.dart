import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:home_expcenses/helper/category_db_provider.dart';
import 'package:home_expcenses/helper/expenses_db_provider.dart';
import 'package:home_expcenses/helper/navHelper.dart';
import 'package:home_expcenses/views/screens/addExpencePage.dart';
import 'package:home_expcenses/views/screens/catagoryPage.dart';
import 'package:home_expcenses/views/screens/chartPage.dart';
import 'package:home_expcenses/views/screens/settingPage.dart';
import 'package:home_expcenses/views/widgets/dayExpencesWidget.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ScrollController hideButtonController;
  late bool isVisible;
  @override
  initState() {
    super.initState();
    isVisible = true;
    hideButtonController = ScrollController();
    hideButtonController.addListener(() {
      if (hideButtonController.position.atEdge) {
        if (isVisible) {
          setState(() {
            isVisible = false;
          });
        }
      }
      if (hideButtonController.position.userScrollDirection ==
          ScrollDirection.forward) {
        if (!isVisible) {
          setState(() {
            isVisible = true;
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<Expenses_DB_provider, Category_DB_provider>(
      builder: (context, expensesProvider, categoryProvider, child) {
        log(expensesProvider.allDays.length.toString());
        return Scaffold(
          body: CustomScrollView(controller: hideButtonController, slivers: [
            SliverPersistentHeader(
              delegate: CustomSliverAppBarDelegate(
                  expandedHeight: 150, provider: expensesProvider),
              pinned: true,
            ),
            SliverToBoxAdapter(
              child: Column(
                children: expensesProvider.allDays
                    .map((e) => DayExpwncesWidget(dayModel: e))
                    .toList(),
              ),
            ),
            //buildBody(provider)
          ]),
          floatingActionButton: AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            child: isVisible
                ? FloatingActionButton(
                    child: const Icon(Icons.add_rounded),
                    onPressed: () {
                      categoryProvider.addSelectedCategory();
                      NavHelper.navigateToWidget(AddExpencePage());
                    },
                  )
                : const SizedBox(),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
          bottomNavigationBar: AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            child: isVisible
                ? BottomAppBar(
                    shape: const CircularNotchedRectangle(),
                    notchMargin: 5,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        IconButton(
                          icon: const Icon(
                            Icons.dashboard_customize_rounded,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            NavHelper.navigateToWidget(CategoryPage());
                          },
                        ),
                      ],
                    ),
                  )
                : const SizedBox(),
          ),
        );
      },
    );
  }

  Widget buildBody(Expenses_DB_provider provider) => SliverToBoxAdapter(
        child: Column(
          children: provider.allDays
              .map((e) => DayExpwncesWidget(dayModel: e))
              .toList(),
        ),
      );
}

class CustomSliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  Expenses_DB_provider provider;

  CustomSliverAppBarDelegate(
      {required this.expandedHeight, required this.provider});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      fit: StackFit.expand,
      //overFlow: Overflow.visible,
      children: [
        buildAppBar(shrinkOffset, provider),
        buildBackground(shrinkOffset, provider),
      ],
    );
  }

  double appear(double shrinkOffset) => shrinkOffset / expandedHeight;

  double disappear(double shrinkOffset) => 1 - shrinkOffset / expandedHeight;

  Widget buildAppBar(double shrinkOffset, Expenses_DB_provider provider) =>
      Opacity(
        opacity: appear(shrinkOffset),
        child: AppBar(
          title: Column(
            children: [
              Row(
                children: [
                  const Spacer(),
                  Text('-${provider.thisMonthExpens}'),
                ],
              ),
              Row(
                children: [
                  Text(provider.thisMonth),
                  const Spacer(),
                  Text('+${provider.thisMonthIncome}'),
                ],
              )
            ],
          ),
          centerTitle: true,
        ),
      );

  Widget buildBackground(double shrinkOffset, Expenses_DB_provider provider) =>
      Opacity(
        opacity: disappear(shrinkOffset),
        child: AppBar(
          toolbarHeight: 140,
          title: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 13),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.calendar_month,
                          size: 15,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          '${provider.thisMonth} Balance',
                          style: const TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                      onPressed: () {
                        NavHelper.navigateToWidget(SettingPage());
                      },
                      icon: const Icon(
                        Icons.settings,
                      ))
                ],
              ),
              Row(
                children: [
                  Text(
                    (provider.thisMonthIncome - provider.thisMonthExpens)
                        .toString(),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    'Expenses: -${provider.thisMonthExpens}',
                    style: const TextStyle(fontSize: 15),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    'Income: +${provider.thisMonthIncome}',
                    style: const TextStyle(fontSize: 15),
                  ),
                ],
              ),
            ],
          ),
        ),
      );

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight + 20;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
