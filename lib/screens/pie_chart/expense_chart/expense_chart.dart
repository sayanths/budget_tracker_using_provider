import 'package:flutter/material.dart';
import 'package:money_management_app1/screens/db_functions/category/category_db.dart';
import 'package:money_management_app1/screens/db_functions/category/transation_db/transation_db.dart';
import 'package:money_management_app1/screens/pie_chart/chart_functions/chart_functions.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ExpenseChart extends StatefulWidget {
  const ExpenseChart({super.key});

  @override
  State<ExpenseChart> createState() => _ExpenseChartState();
}

class _ExpenseChartState extends State<ExpenseChart> {
  List<ChartData> connectedList =
      chartLogic(TransactionDb.instance.expenseChartListNotifier.value);

  List<ChartData> todayExpenseList =
      chartLogic(TransactionDb.instance.todayExpenseNotifier.value);

  List<ChartData> yesterdayExpenseList =
      chartLogic(TransactionDb.instance.yesterdayExpenseNotifier.value);
  String? _dropName = 'All';
  var period = ['All', 'Today', 'Yesterday'];
  @override
  void initState() {
    TransactionDb.instance.refresh();
    CategoryDB.instance.refreshUi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Column(
            children: [
              SizedBox(child: FutureBuilder(
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  return connectedList.isEmpty
                      ? Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            children: [
                              const SizedBox(height: 60,),
                              const Text(
                                "No Transaction Added",
                                style: TextStyle(
                                    color: Colors.black45, fontSize: 16),
                              ),
                              Image.asset(
                                'assets/incomechart.png',
                                height: 300,
                              ),
                            ],
                          ),
                        )
                      : Column(
                          children: [
                            DropdownButton(
                                hint: Text(_dropName.toString()),
                                value: _dropName,
                                items: period.map((newList) {
                                  return DropdownMenuItem(
                                      value: newList, child: Text(newList));
                                }).toList(),
                                onChanged: (String? value) {
                                  setState(() {
                                    _dropName = value;
                                  });
                                }),
                            SfCircularChart(
                                palette:const <Color>[
                                  Colors.amber,
                                  Colors.brown,
                                  Colors.green,
                                  Colors.redAccent,
                                  Colors.blueAccent,
                                  Colors.teal
                                ],
                                legend: Legend(
                                    isVisible: true,
                                    borderColor: Colors.black54,
                                    borderWidth: 1),
                                title: ChartTitle(
                                  text: 'Expense category analysis',
                                  textStyle: const TextStyle(
                                      color: Colors.black54,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500),
                                ),
                                series: <CircularSeries>[
                                  PieSeries<ChartData, String>(
                                    dataLabelSettings: const DataLabelSettings(
                                      isVisible: true,
                                    ),
                                    dataSource: updateExpenseChart(),
                                    xValueMapper: (ChartData data, _) =>
                                        data.categories,
                                    yValueMapper: (ChartData data, _) =>
                                        data.amount,
                                  )
                                ]),
                          ],
                        );
                },
              )),
            ],
          ),
         
        ],
      ),
    );
  }

  List<ChartData> updateExpenseChart() {
    if (_dropName == 'Today') {
      return todayExpenseList;
    } else if (_dropName == 'Yesterday') {
      return yesterdayExpenseList;
    } else {
      return connectedList;
    }
  }
}
