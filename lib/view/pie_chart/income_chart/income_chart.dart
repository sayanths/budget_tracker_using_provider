import 'package:flutter/material.dart';

import 'package:money_management_app1/view/pie_chart/chart_functions/chart_functions.dart';
import 'package:money_management_app1/view_model/income_pie_chart/icome_pie_chart.dart';
import 'package:money_management_app1/view_model/transation_db/transation_db.dart';
import 'package:provider/provider.dart';

import 'package:syncfusion_flutter_charts/charts.dart';

class IncomeChart extends StatefulWidget {
  const IncomeChart({Key? key}) : super(key: key);

  @override
  State<IncomeChart> createState() => _IncomeChartState();
}
class _IncomeChartState extends State<IncomeChart> {
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
              SizedBox(child: Consumer<IncomePieChartController>(
                builder: (context, incomePieCntrl, child) {
                  return FutureBuilder(
                    builder: (BuildContext context,
                        AsyncSnapshot<dynamic> snapshot) {
                      return incomePieCntrl.connectedList.isEmpty
                          ? Padding(
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 60,
                                  ),
                                  const Text(
                                    "No transaction Added",
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
                                    hint: Text(
                                        incomePieCntrl.dropName.toString()),
                                    value: incomePieCntrl.dropName,
                                    items: incomePieCntrl.period.map((newList) {
                                      return DropdownMenuItem(
                                          value: newList, child: Text(newList));
                                    }).toList(),
                                    onChanged: (String? newvalue) {
                                      incomePieCntrl.changeDropName(newvalue);
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
                                      text: 'Income category analysis',
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
                                        dataSource:
                                            incomePieCntrl.chartDataChecking(),
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
