import 'package:flutter/material.dart';
import 'package:money_management_app1/model/category_model/category_model.dart';

import 'package:money_management_app1/view_model/category_db.dart/category_db.dart';
import 'package:money_management_app1/view/home_screen/home_page_widget/home_page_widget.dart';
import 'package:provider/provider.dart';

class ExpenseCategory extends StatelessWidget {
  final CategoryType type;

  const ExpenseCategory({
    Key? key,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
          child: Padding(
            padding: const EdgeInsets.only(top: 30, right: 30),
            child: Align(
              alignment: Alignment.topRight,
              child: OutlinedButton.icon(
                onPressed: () {
                  popupDialofForAddExpense(context, type);
                },
                icon: const Icon(Icons.add),
                label: const Text("Add Expense"),
              ),
            ),
          ),
        ),
        spaceGive,
        spaceGive,
        Flexible(
          flex: 6,
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.grey,
                    Color.fromARGB(255, 254, 254, 254),
                  ]),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Consumer<CategoryDB>(
                  builder: (context, expenseNotify, _) {
                    return GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              mainAxisSpacing: 5,
                              crossAxisSpacing: 5,
                              crossAxisCount: 5),
                      itemBuilder: ((context, index) {
                        var category =
                            expenseNotify.expesneCategoryListable[index];
                        return GestureDetector(
                          onTap: (() {
                            showDialog(
                                context: context,
                                builder: ((context) {
                                  return AlertDialog(
                                    title: const Text("Do you want to delete?"),
                                    actions: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          TextButton(
                                              onPressed: () {
                                                expenseNotify.deleteCategory(
                                                    category.id);
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text("Yes")),
                                          const SizedBox(
                                            width: 30,
                                          ),
                                          TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text("No")),
                                        ],
                                      ),
                                    ],
                                  );
                                }));
                          }),
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 250, 248, 248),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                category.name,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                            ),
                          ),
                        );
                      }),
                      itemCount: expenseNotify.expesneCategoryListable.length,
                    );
                  },
                )),
          ),
        ),
      ],
    );
  }
}

popupDialofForAddExpense(dynamic context, type) {
  final nameEditingController = TextEditingController();
  final formkey = GlobalKey<FormState>();
  showDialog(
    context: context,
    builder: (ctx) {
      return Form(
        key: formkey,
        child: AlertDialog(
          content: TextFormField(
              maxLength: 10,
              controller: nameEditingController,
              decoration:
                  const InputDecoration(hintText: 'Enter the Expense Category'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please Enter the Expense Category';
                } else {
                  return null;
                }
              }),
          actions: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () {
                      formkey.currentState?.validate();
                      final name = nameEditingController.text;
                      if (name.isEmpty) {
                        return;
                      } else {
                        final category = CategoryModel(
                            id: DateTime.now()
                                .millisecondsSinceEpoch
                                .toString(),
                            name: name,
                            type: CategoryType.expense);
                        CategoryDB().insertCategory(category);
                        Navigator.of(ctx).pop();
                      }
                    },
                    child: const Text("Save"),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text("cancel")),
                ],
              ),
            ),
          ],
        ),
      );
    },
  );
}
