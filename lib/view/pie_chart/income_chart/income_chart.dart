import 'package:flutter/material.dart';
import 'package:money_management_app1/view_model/income_controller/income_controller.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class IncomeChart extends StatelessWidget {
  const IncomeChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Column(
            children: [
              SizedBox(child: Consumer<IncomeChartController>(
                builder: (context, incomePieCntrl, child) {
                  return FutureBuilder(
                    builder: (BuildContext context,
                        AsyncSnapshot<dynamic> snapshot) {
                      return incomePieCntrl.filteredData.isEmpty
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
                                // DropdownButton(
                                //     hint: Text(
                                //         incomePieCntrl.dropName.toString()),
                                //     value: incomePieCntrl.dropName,
                                //     items: incomePieCntrl.period.map((newList) {
                                //       return DropdownMenuItem(
                                //           value: newList, child: Text(newList));
                                //     }).toList(),
                                //     onChanged: (String? newvalue) {
                                //       incomePieCntrl.changeDropName(newvalue);
                                //     }),
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
                                      PieSeries<ChartDat, String>(
                                        dataLabelSettings:
                                            const DataLabelSettings(
                                          isVisible: true,
                                        ),
                                        dataSource:
                                            incomePieCntrl.filteredData,
                                        xValueMapper: (ChartDat data, _) =>
                                            data.categories,
                                        yValueMapper: (ChartDat data, _) =>
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
