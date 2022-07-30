import 'package:flutter/material.dart';
import 'package:money_management_app1/view/pie_chart/chart_functions/chart_functions.dart';
import 'package:money_management_app1/view_model/expense_list_controller/expense_list_controller.dart';
import 'package:money_management_app1/view_model/transation_db/transation_db.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ExpenseChart extends StatefulWidget {
  const ExpenseChart({Key? key}) : super(key: key);

  @override
  State<ExpenseChart> createState() => _ExpenseChartState();
}
class _ExpenseChartState extends State<ExpenseChart> {

  @override
  void initState() {
    TransactionDb.instance.refresh();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Column(
            children: [
              SizedBox(child: Consumer<ExpenseListController>(
                builder: (context, expnseList, child) {
                  return FutureBuilder(
                    builder: (BuildContext context,
                        AsyncSnapshot<dynamic> snapshot) {
                      return expnseList.connectedList.isEmpty
                          ? Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 60,
                                  ),
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
                                    hint: Text(expnseList.dropName.toString()),
                                    value: expnseList.dropName,
                                    items: expnseList.period.map((newList) {
                                      return DropdownMenuItem(
                                          value: newList, child: Text(newList));
                                    }).toList(),
                                    onChanged: (String? newvalue) {
                                      expnseList.expenseChart(newvalue);
                                    }),
                                SfCircularChart(
                                    palette: const <Color>[
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
                                        dataLabelSettings:
                                            const DataLabelSettings(
                                          isVisible: true,
                                        ),
                                        dataSource: expnseList.updateExpenseChart(),
                                        xValueMapper: (ChartData data, _) =>
                                            data.categories,
                                        yValueMapper: (ChartData data, _) =>
                                            data.amount,
                                      )
                                    ]),
                              ],
                            );
                    },
                  );
                },
              )),
            ],
          ),
        ],
      ),
    );
  }
}
