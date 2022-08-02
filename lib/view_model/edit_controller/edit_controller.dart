import 'package:flutter/material.dart';
import 'package:money_management_app1/model/category_model/category_model.dart';

class EditController extends ChangeNotifier {
  DateTime? dateTime;
  CategoryType? categoryTypeSelected;
  CategoryModel? categoryModel;
  String? categoryId;
  String? categoryNametype;
  String? choice;

  datePick(BuildContext context, DateTime dbDate) async {
    final selectedDateTemp = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime.now());
    dateTime = selectedDateTemp ?? dbDate;

    notifyListeners();
  }

  setCategoryType(CategoryType type) {
    categoryTypeSelected = type;
    notifyListeners();
  }

  setDate(DateTime dateFromDb) {
    dateTime = dateFromDb;
    notifyListeners();
  }

  setCategoryModel(CategoryModel model) {
    categoryModel = model;
    notifyListeners();
  }

  setcategotyid(String? model) {
    categoryId = model;
    notifyListeners();
  }

  choiceChipRebuild(String choice) {
    this.choice = choice;
  }
}
