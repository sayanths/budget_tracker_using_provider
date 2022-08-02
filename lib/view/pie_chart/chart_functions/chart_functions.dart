import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:money_management_app1/model/transaction_model/transaction_model.dart';

//String chartdrop = 'todayIncomeNotifier';

class ChartData {
  String? categories;
  double? amount;
  ChartData({required this.categories, required this.amount});
}

class ChartDatas extends ChangeNotifier {
  ChartDatas() {
    getdata();
  }
  List<TransactionModel> allList = [];
  List<TransactionModel> todayList = [];
  List<ChartData> chartData = [];

  chartLogic(List<TransactionModel> model) {
    double value;
    String categoryName;
    List visited = [];
    List<ChartData> thedata = [];
    for (var i = 0; i < model.length; i++) {
      visited.add(0);
    }

    for (var i = 0; i < model.length; i++) {
      value = model[i].amount;
      categoryName = model[i].category.name;

      for (var j = i + 1; j < model.length; j++) {
        if (model[i].category.name == model[j].category.name) {
          value += model[j].amount;
          visited[j] = -1;
        }
      }
      if (visited[i] != -1) {
        thedata.add(ChartData(categories: categoryName, amount: value));
      }
    }
    return thedata;
  }

  Future<List<TransactionModel>> getDeatails() async {
    final obj = await Hive.openBox<TransactionModel>("transation_db");
    return obj.values.toList();
  }

  DateTime selectedmonth = DateTime.now();
  getdata() async {
    final list = await getDeatails();
    String format = DateFormat('yMMMM').format(selectedmonth);

    todayList.clear();
    Future.forEach(
      list,
      (TransactionModel element) {
        String formatData = DateFormat('yMMMM').format(element.date);
        allList.add(element);
        
        if (format == formatData) {
          todayList.add(element);
        }
      },
    );
    await getChartData();
  }

  getChartData() {
    chartData = chartLogic(todayList);
    if (kDebugMode) {
      print(chartData.length);
    }
    notifyListeners();
  }
}
