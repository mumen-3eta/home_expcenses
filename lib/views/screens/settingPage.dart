import 'package:flutter/material.dart';
import 'package:home_expcenses/helper/settingHelper.dart';
import 'package:home_expcenses/helper/settingsProvider.dart';
import 'package:provider/provider.dart';

class SettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Settings'),
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    const Text('Dark Theme'),
                    const Spacer(),
                    Switch(
                        value: provider.isDark!,
                        onChanged: (change) {
                          provider.changeTheme(change);
                        })
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
