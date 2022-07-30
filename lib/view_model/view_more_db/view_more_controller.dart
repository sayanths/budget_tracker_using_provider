import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:money_management_app1/model/transaction_model/transaction_model.dart';

class ViewMoreController extends ChangeNotifier {
  ViewMoreController() {
    sortList();
  }
  List<TransactionModel> monthelyNotifier = [];
  List<TransactionModel> yesterdayNotifier = [];
  List<TransactionModel> todayNotifier = [];
  List<TransactionModel> allList = [];

  DateTime selectedMonth = DateTime.now();

  String todayDate = DateFormat.yMd().format(DateTime.now());

  String yesterdayDate =
      DateFormat.yMd().format(DateTime.now().subtract(const Duration(days: 1)));

  String monthlyDate = DateFormat.yMd()
      .format(DateTime.now().subtract(const Duration(days: 30)));

  dynamic dropDown = 'All';

  changeDropName(dynamic dropDown) {
    this.dropDown = dropDown;
    notifyListeners();
  }

  getData() async {
    final db = await Hive.openBox<TransactionModel>("transation_db");
    return db.values.toList();
  }

  List period = ['All', 'Today', 'Yesterday', 'Monthly'];

  sortList() async {
    allList.clear();
    todayNotifier.clear();
    var list = await getData();
    Future.forEach(list, (TransactionModel element) {
      String dbtodayDate = DateFormat.yMd().format(element.date);
      allList.add(element);
      if (todayDate == dbtodayDate) {
        todayNotifier.add(element);
      }
      if (yesterdayDate == dbtodayDate) {
        yesterdayNotifier.add(element);
      }
    });
    notifyListeners();
  }

  
}
