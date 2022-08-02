// import 'package:flutter/material.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:intl/intl.dart';
// import 'package:money_management_app1/model/transaction_model/transaction_model.dart';
// import 'package:money_management_app1/view/pie_chart/chart_functions/chart_functions.dart';
// import 'package:money_management_app1/view_model/transation_db/transation_db.dart';

// class ExpenseListController extends ChangeNotifier {
//   List<ChartData> connectedList =
//       chartLogic(TransactionDb.instance.expenseChartListNotifier.value);

//   List<ChartData> todayExpenseList =
//       chartLogic(TransactionDb.instance.todayExpenseNotifier.value);

//   List<ChartData> yesterdayExpenseList =
//       chartLogic(TransactionDb.instance.yesterdayExpenseNotifier.value);
//   String? dropName = 'All';
//   var period = ['All', 'Today', 'Yesterday'];

//   List<ChartData> updateExpenseChart() {
//     if (dropName == 'Today') {
//       return todayExpenseList;
//     } else if (dropName == 'Yesterday') {
//       return yesterdayExpenseList;
//     } else {
//       return connectedList;
//     }
//   }

//   expenseChart(dropName) {
//     this.dropName = dropName;
//   }
//     getData() async {
//     final db = await Hive.openBox<TransactionModel>("transation_db");
//     return db.values.toList();
//   }

//   String todayDate = DateFormat.yMd().format(DateTime.now());

//   String yesterdayDate =
//       DateFormat.yMd().format(DateTime.now().subtract(const Duration(days: 1)));
// sortExpensePieChart(){
  
// }
// }


