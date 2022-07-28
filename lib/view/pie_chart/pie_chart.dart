import 'package:flutter/material.dart';
import 'package:money_management_app1/utils/styles_color.dart';

import 'package:money_management_app1/view/home_screen/home_page_widget/home_page_widget.dart';

import 'expense_chart/expense_chart.dart';
import 'income_chart/income_chart.dart';

class PieChart extends StatefulWidget {
  const PieChart({Key? key}) : super(key: key);

  

  @override
  State<PieChart> createState() => _PieChartState();
}

class _PieChartState extends State<PieChart>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

 
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const HeadingStyleContainer(
              mainTitle: "Chart\n", subTitle: "Transaction Statics"),
          spaceGive,
          spaceGive,
          TabBar(
              indicatorColor: tabBarSelectedColor,
              indicator: const BoxDecoration(
                color: tabBarSelectedColor,
              ),
              unselectedLabelColor: Colors.black,
              labelColor: Colors.white,
              controller: _tabController,
              tabs: const [
                Tab(
                  text: 'Income',
                ),
                Tab(
                  text: 'Expense',
                ),
              ]),
              
          Expanded(
            child: TabBarView(controller: _tabController, children:  const [
              IncomeChart(),
              ExpenseChart(),
            ]),
          ),
        ],
      ),
    );
  }
}
