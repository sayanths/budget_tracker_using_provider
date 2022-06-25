import 'package:flutter/material.dart';
import 'package:money_management_app1/screens/category_model/category_model.dart';
import 'package:money_management_app1/screens/db_functions/category/category_db.dart';
import 'package:money_management_app1/screens/home_screen/home_page_widget/home_page_widget.dart';

class IncomeCategory extends StatefulWidget {
  final CategoryType type;

  const IncomeCategory({
    super.key,
    required this.type,
  });

  @override
  State<IncomeCategory> createState() => _IncomeCategoryState();
}

class _IncomeCategoryState extends State<IncomeCategory> {
  final nameEditingController = TextEditingController();

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
                  popupDialofForAddIncome(context, widget.type);
                },
                icon: const Icon(Icons.add),
                label: const Text("Add Category"),
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
              child: ValueListenableBuilder(
                valueListenable: CategoryDB().incomeCategoryListable,
                builder: (BuildContext context, List<CategoryModel> incomeList,
                    Widget? _) {
                  return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisSpacing: 5,
                            crossAxisSpacing: 5,
                            crossAxisCount: 5),
                    itemBuilder: ((context, index) {
                      final incomect = incomeList[index];
                      return GestureDetector(
                        onTap: (() {
                          showDialog(
                            context: context,
                            builder: ((context) {
                              return AlertDialog(
                                title: const Text("Do you want to delete?"),
                                actions: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      TextButton(
                                          onPressed: () {
                                            CategoryDB()
                                                .deleteCategory(incomect.id);
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
                            }),
                          );
                        }),
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 255, 255, 255),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Flexible(
                              child: Text(
                                incomect.name,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                    itemCount: incomeList.length,
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

 

  
}
 final fomekeySecond = GlobalKey<FormState>();
 popupDialofForAddIncome(dynamic context, type) {
    final nameEditingController = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          content: Form(
            key: fomekeySecond,
            child: TextFormField(
                maxLength: 10,
              controller: nameEditingController,
              decoration:
                  const InputDecoration(hintText: 'Enter the Income Category'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please Enter the income category';
                } else {
                  return null;
                }
              },
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () {
                      fomekeySecond.currentState?.validate();

                      final name = nameEditingController.text;
                      if (name.isEmpty) {
                        return;
                      } else {
                        final category = CategoryModel(
                            id: DateTime.now()
                                .millisecondsSinceEpoch
                                .toString(),
                            name: name,
                            type: CategoryType.income);
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
                    child: const Text("cancel"),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }