import 'package:flutter/material.dart';
import 'package:money_management_app1/screens/category/expense_category/expense_category.dart';
import 'package:money_management_app1/screens/category/income_category/income_catergory.dart';
import 'package:money_management_app1/screens/category_model/category_model.dart';
import 'package:money_management_app1/screens/db_functions/category/category_db.dart';
import 'package:money_management_app1/screens/home_screen/home_page_widget/home_page_widget.dart';
import 'package:money_management_app1/styles_color.dart';

class Category extends StatefulWidget {
  const Category({Key? key}) : super(key: key);


  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    CategoryDB().refreshUi();
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const HeadingStyleContainer(
              mainTitle: "Category\n", subTitle: "Add New Categories"),
          spaceGive,
          spaceGive,
          TabBar(
            unselectedLabelColor: Colors.black,
            indicator: const BoxDecoration(
              color: tabBarSelectedColor,
            ),
            controller: _tabController,
            tabs: const [
              Tab(
                text: 'Income',
              ),
              Tab(
                text: 'Expense',
              ),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children:   const [
                IncomeCategory(
                  type: CategoryType.income,
                ),
                ExpenseCategory(
                  type: CategoryType.expense,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
