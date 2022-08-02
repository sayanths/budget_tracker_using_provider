import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:money_management_app1/model/category_model/category_model.dart';
import 'package:money_management_app1/model/transaction_model/transaction_model.dart';

class ExpenseController extends ChangeNotifier {
  ExpenseController() {
    getExpenseData();
  }
  List<TransactionModel> allExpenseList = [];

  List<ChartDat> getAllChartDatas = [];

  chartLogic(List<TransactionModel> model) {
    
    double value;
    String categoryName;
    List visited = [];
    List<ChartDat> thedata = [];
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
        thedata.add(ChartDat(categories: categoryName, amount: value));
      }
    }
    return thedata;
  }

  Future<List<TransactionModel>> getDatas() async {
 
    var rep = await Hive.openBox<TransactionModel>("transation_db");
    final list = rep.values.toList();
    return list;
  }

  getExpenseData() async {
    getAllChartDatas.clear;
    
    final list = await getDatas();
    Future.forEach(list, (TransactionModel element) {
      if (element.type == CategoryType.expense) {
        allExpenseList.add(element);
      }
    });
    getAllChartDatas = chartLogic(allExpenseList);
    notifyListeners();
  }
}

class ChartDat {
  String? categories;
  double? amount;
  ChartDat({required this.categories, required this.amount});
}
