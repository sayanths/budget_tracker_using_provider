import 'package:flutter/cupertino.dart';
import 'package:money_management_app1/model/category_model/category_model.dart';

class AddController extends ChangeNotifier {
  DateTime? dateTime;
  CategoryType? categoryTypeSelected;
  CategoryModel? categoryModel;
  String? categoryId;
  String? categoryNametype;
  String? choice;
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
