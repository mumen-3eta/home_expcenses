import 'package:flutter/material.dart';
import 'package:home_expcenses/helper/category_db_helper.dart';
import 'package:home_expcenses/helper/category_db_provider.dart';
import 'package:home_expcenses/helper/expenses_db_helper.dart';
import 'package:home_expcenses/helper/expenses_db_provider.dart';
import 'package:home_expcenses/helper/navHelper.dart';
import 'package:home_expcenses/helper/settingHelper.dart';
import 'package:home_expcenses/helper/settingsProvider.dart';
import 'package:home_expcenses/views/screens/splashPage.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Category_DBhelper.dbhelper.initDatabase();
  await Expenses_DBhelper.dbhelper.initDatabase();
  await SPhelper.sPhelper.initSP();

  WidgetsApp.debugAllowBannerOverride = false;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  bool? isDark = SPhelper.sPhelper.sp!.getBool('dark');
  @override
  Widget build(BuildContext context) {
    if (isDark == null) {
      SPhelper.sPhelper.sp!.setBool('dark', false);
    }

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Category_DB_provider>(
          create: (context) {
            return Category_DB_provider();
          },
        ),
        ChangeNotifierProvider<Expenses_DB_provider>(
          create: (context) {
            return Expenses_DB_provider();
          },
        ),
        ChangeNotifierProvider<SettingsProvider>(
          create: (context) {
            return SettingsProvider();
          },
        )
      ],
      child: Consumer<SettingsProvider>(
        builder: (context, provider, child) {
          return MaterialApp(
            theme: provider.isDark! ? ThemeData.dark() : ThemeData.light(),
            navigatorKey: NavHelper.navkey,
            home: SplashPage(),
          );
        },
      ),
    );
  }
}
