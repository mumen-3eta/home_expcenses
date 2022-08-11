import 'package:flutter/material.dart';

class ChartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Chart'),
          bottom: TabBar(
            tabs: [
              Column(
                children: const [
                  Icon(
                    Icons.pie_chart_rounded,
                  ),
                  Text('CATEGORY')
                ],
              ),
              Column(
                children: const [
                  Icon(
                    Icons.insert_chart_sharp,
                  ),
                  Text('STATISTICS')
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
