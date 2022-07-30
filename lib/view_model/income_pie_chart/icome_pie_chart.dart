import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:money_management_app1/model/transaction_model/transaction_model.dart';
import 'package:money_management_app1/view/pie_chart/chart_functions/chart_functions.dart';
import 'package:money_management_app1/view_model/transation_db/transation_db.dart';

class IncomePieChartController extends ChangeNotifier {
  IncomePieChartController() {
    sortIncomePieChart();
  }
  List<TransactionModel> todayIncomeNotifier = [];
  List<TransactionModel> yesterdayIncomeNotifier = [];
  List<TransactionModel> completeIncomePieChartNotifier = [];
  List<ChartData> connectedList =
      chartLogic(TransactionDb.instance.incomeChartListNotifier.value);
  late List<ChartData> todayListGraph = chartLogic(todayIncomeNotifier);
  late List<ChartData> yesterdayListGraph = chartLogic(yesterdayIncomeNotifier);

  String? dropName = 'All';
  var period = [
    'All',
    'Today',
    'Yesterday',
  ];

  changeDropName(dynamic dropName) {
    this.dropName = dropName;
    notifyListeners();
  }

  getData() async {
    final db = await Hive.openBox<TransactionModel>("transation_db");
    return db.values.toList();
  }

  String todayDate = DateFormat.yMd().format(DateTime.now());

  String yesterdayDate =
      DateFormat.yMd().format(DateTime.now().subtract(const Duration(days: 1)));

  sortIncomePieChart() async {
    todayIncomeNotifier.clear();
    yesterdayIncomeNotifier.clear();
    completeIncomePieChartNotifier.clear();

    var list = await getData();
    Future.forEach(list, (TransactionModel element) {
    //   balacneNotifier.value = balacneNotifier.value + element.amount;
      String dbtodayDate = DateFormat.yMd().format(element.date);
      completeIncomePieChartNotifier.add(element);
      if (todayDate == dbtodayDate) {
        todayIncomeNotifier.add(element);
      }
      if (yesterdayDate == dbtodayDate) {
        yesterdayIncomeNotifier.add(element);
      }
    });
    notifyListeners();
  }

  List<ChartData> chartDataChecking() {
    if (dropName == 'Today') {
      return todayListGraph;
    } else if (dropName == 'Yesterday') {
      return yesterdayListGraph;
    } else {
      return connectedList;
    }
  }

//  double balacneNotifier = 0;
//  double incomeNotifier = 0;

}
