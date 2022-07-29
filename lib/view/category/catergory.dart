import 'package:flutter/material.dart';
import 'package:money_management_app1/model/category_model/category_model.dart';
import 'package:money_management_app1/utils/styles_color.dart';
import 'package:money_management_app1/view_model/category_db.dart/category_db.dart';
import 'package:money_management_app1/view/category/expense_category/expense_category.dart';
import 'package:money_management_app1/view/category/income_category/income_catergory.dart';
import 'package:provider/provider.dart';

import '../home_screen/home_page_widget/home_page_widget.dart';

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
   // Provider.of<CategoryDB>(context, listen: false).refreshUi();
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
