// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:flutter/cupertino.dart';

import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';
import 'package:money_management_app1/model/category_model/category_model.dart';
import 'package:money_management_app1/model/transaction_model/transaction_model.dart';

const transationDbName = 'transation_db';

abstract class TransactionDbFunction {
  Future<void> addTransaction(TransactionModel obj);
  Future<List<TransactionModel>> getAllTransactions();
  Future<void> deleteTransaction(String transationid);
  Future<void> clearTransaction();
  Future<void> updateTransation(String id, TransactionModel transationUpdate);
}

class TransactionDb extends TransactionDbFunction with ChangeNotifier {
  TransactionDb._internal();
  static TransactionDb instance = TransactionDb._internal();

  factory TransactionDb() {
    return instance;
  }

  List<TransactionModel> transationListNotifier = [];
  

  ValueNotifier<List<TransactionModel>> incomeChartListNotifier =
      ValueNotifier([]);
  ValueNotifier<List<TransactionModel>> expenseChartListNotifier =
      ValueNotifier([]);

  @override
  Future<void> addTransaction(TransactionModel obj) async {
    final db = await Hive.openBox<TransactionModel>(transationDbName);
    await db.put(obj.id, obj);
    refresh();
  }

  double balacneNotifier = 0;
  double incomeNotifier = 0;
  double expenseNotifier = 0;

  List<TransactionModel> monthelyNotifier = [];
  List<TransactionModel> yesterdayNotifier = [];
  List<TransactionModel> todayNotifier = [];

  ValueNotifier<List<TransactionModel>> todayExpenseNotifier =
      ValueNotifier([]);
  ValueNotifier<List<TransactionModel>> yesterdayExpenseNotifier =
      ValueNotifier([]);

  getAlList() async {
    dynamic allList = await getAllTransactions();
    notifyListeners();
    return allList;
  }

  Future<void> refresh() async {
    var list = await getAllTransactions();
    list = list.reversed.toList();
    todayNotifier.clear();
    yesterdayNotifier.clear();
    todayExpenseNotifier.value.clear();
    yesterdayExpenseNotifier.value.clear();
    monthelyNotifier.clear();

    //for desending the date order that will appear in the main page
    list.sort(((a, b) => b.date.compareTo(a.date)));
    transationListNotifier.clear();
    transationListNotifier.addAll(list);

    incomeChartListNotifier.value.clear();
    expenseChartListNotifier.value.clear();
    balacneNotifier = 0;
    incomeNotifier = 0;
    expenseNotifier = 0;

    for (var data in list) {
      if (data.type == CategoryType.income) {
        incomeChartListNotifier.value.add(data);
      } else if (data.type == CategoryType.expense) {
        expenseChartListNotifier.value.add(data);
      }
    }

    String todayDate = DateFormat.yMd().format(DateTime.now());

    String yesterdayDate = DateFormat.yMd()
        .format(DateTime.now().subtract(const Duration(days: 1)));

    String monthlyDate = DateFormat.yMd()
        .format(DateTime.now().subtract(const Duration(days: 30)));

    await Future.forEach(list, (TransactionModel category) {
      balacneNotifier = balacneNotifier + category.amount;

      String databaseDate = DateFormat.yMd().format(category.date);

      if (todayDate == databaseDate) {
        todayNotifier.add(category);
      }

      if (yesterdayDate == databaseDate) {
        yesterdayNotifier.add(category);
      }

      if (monthlyDate == databaseDate) {
        monthelyNotifier.add(category);
      }

      if (category.type == CategoryType.income) {
        incomeNotifier = incomeNotifier + category.amount;
      } else if (category.type == CategoryType.expense) {
        if (todayDate == databaseDate) {
          todayExpenseNotifier.value.add(category);
        }
        if (yesterdayDate == databaseDate) {
          yesterdayExpenseNotifier.value.add(category);
        }
        expenseNotifier = expenseNotifier + category.amount;
      }
    });
    balacneNotifier = incomeNotifier - expenseNotifier;

    incomeChartListNotifier.notifyListeners();
    expenseChartListNotifier.notifyListeners();
    todayExpenseNotifier.notifyListeners();
    yesterdayExpenseNotifier.notifyListeners();
    notifyListeners();
  }

  @override
  Future<List<TransactionModel>> getAllTransactions() async {
    final db = await Hive.openBox<TransactionModel>(transationDbName);
    return db.values.toList();
  }

  @override
  Future<void> deleteTransaction(String transationid) async {
    final db = await Hive.openBox<TransactionModel>(transationDbName);
    await db.delete(transationid);
    refresh();
    notifyListeners();
  }

  @override
  Future<void> clearTransaction() async {
    final db = await Hive.openBox<TransactionModel>(transationDbName);
    await db.clear();
    notifyListeners();
  }

  @override
  Future<void> updateTransation(
      String index, TransactionModel transationUpdate) async {
    final db = await Hive.openBox<TransactionModel>(transationDbName);
    await db.put(index, transationUpdate);
    getAllTransactions();
    notifyListeners();
  }
}
