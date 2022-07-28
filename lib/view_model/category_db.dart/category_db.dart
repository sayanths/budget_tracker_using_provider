// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_management_app1/model/category_model/category_model.dart';


const categorydbname = 'category_db_name';

abstract class CategoryDbFunctions {
  Future<List<CategoryModel>> getCategories();
  Future<void> insertCategory(CategoryModel model);
  Future<void> deleteCategory(String categoryId);
  Future<void> clearCategory();
}

class CategoryDB implements CategoryDbFunctions {
  CategoryDB.internal();

  static CategoryDB instance = CategoryDB.internal();

  factory CategoryDB() {
    return instance;
  }

  ValueNotifier<List<CategoryModel>> incomeCategoryListable = ValueNotifier([]);
  ValueNotifier<List<CategoryModel>> expesneCategoryListable =
      ValueNotifier([]);

  @override
  Future<void> insertCategory(CategoryModel value) async {
    final categoryDB = await Hive.openBox<CategoryModel>(categorydbname);
    categoryDB.put(value.id, value);
    refreshUi();
  }

  @override
  Future<List<CategoryModel>> getCategories() async {
    final categoryDB = await Hive.openBox<CategoryModel>(categorydbname);
    return categoryDB.values.toList();
  }

  Future<void> refreshUi() async {
    final allCategories = await getCategories();
    incomeCategoryListable.value.clear();
    expesneCategoryListable.value.clear();
    await Future.forEach(allCategories, (CategoryModel category) {
      if (category.type == CategoryType.income) {
        incomeCategoryListable.value.add(category);
      } else {
        expesneCategoryListable.value.add(category);
      }
    });

    // ignore: invalid_use_of_protected_member
    incomeCategoryListable.notifyListeners();

    // ignore: invalid_use_of_protected_member
    expesneCategoryListable.notifyListeners();
  }

  @override
  Future<void> deleteCategory(String categoryId) async {
    final categoryDB = await Hive.openBox<CategoryModel>(categorydbname);
    await categoryDB.delete(categoryId);
    refreshUi();
  }

  @override
  Future<void> clearCategory() async {
    final categoryDB = await Hive.openBox<CategoryModel>(categorydbname);
    categoryDB.clear();
  }
}
