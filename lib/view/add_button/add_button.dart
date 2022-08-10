import 'package:flutter/material.dart';
import 'package:money_management_app1/model/category_model/category_model.dart';
import 'package:money_management_app1/model/transaction_model/transaction_model.dart';
import 'package:money_management_app1/utils/styles_color.dart';
import 'package:money_management_app1/view_model/add_controller/add_controller.dart';
import 'package:money_management_app1/view_model/category_db.dart/category_db.dart';
import 'package:money_management_app1/view/category/expense_category/expense_category.dart';
import 'package:money_management_app1/view/category/income_category/income_catergory.dart';
import 'package:money_management_app1/view_model/transation_db/transation_db.dart';
import 'package:provider/provider.dart';

import '../home_screen/home_page_widget/home_page_widget.dart';
import '../pie_chart/chart_functions/chart_functions.dart';
import 'add_button_widget.dart/add_button_widget.dart';

class AddButton extends StatefulWidget {
  const AddButton({Key? key}) : super(key: key);

  @override
  State<AddButton> createState() => _AddButtonState();
}

class _AddButtonState extends State<AddButton> {
  DateTime? dateTime;
  CategoryType? _categoryTypeSelected;
  CategoryModel? categoryModel;
  String? categoryId;
  String? categoryNametype;

  final amountEditingController = TextEditingController();
  final notesEditingController = TextEditingController();

  final formkey = GlobalKey<FormState>();

  @override
  void initState() {
    _categoryTypeSelected = CategoryType.income;
    super.initState();
  }

  String type = "income";
  late int amount;
  String note = "some expense";

  @override
  Widget build(BuildContext context) {
    TransactionDb.instance.refresh();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0),
        child: ListView(
          children: [
            const AddStyleContainer(
                mainTitle: "Add Transaction\n",
                subTitle: "Add your transaction"),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: formkey,
                child: Column(
                  children: [
                    spaceGive,
                    spaceGive,
                     Consumer<AddController>(
                      builder: (context, value, _) => Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ChoiceChip(
                            label: Text(
                              "Income",
                              style: TextStyle(
                                  color: _categoryTypeSelected ==
                                          CategoryType.income
                                      ? Colors.white
                                      : Colors.black),
                            ),
                            selectedColor:
                                const Color.fromARGB(255, 3, 86, 154),
                            selected: value.categoryTypeSelected ==
                                    CategoryType.income
                                ? true
                                : false,
                            onSelected: (val) {
                              context
                                  .read<AddController>()
                                  .choiceChipRebuild('Income');
                              context
                                  .read<AddController>()
                                  .setCategoryType(CategoryType.income);
                              _categoryTypeSelected =
                                  value.categoryTypeSelected;
                              value.setcategotyid(null);
                            },
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          ChoiceChip(
                            label: Text(
                              "Expense",
                              style: TextStyle(
                                  color: _categoryTypeSelected ==
                                          CategoryType.expense
                                      ? Colors.white
                                      : Colors.black),
                            ),
                            selectedColor:
                                const Color.fromARGB(255, 3, 86, 154),
                            selected: value.categoryTypeSelected ==
                                    CategoryType.expense
                                ? true
                                : false,
                            onSelected: (val) {
                              context
                                  .read<AddController>()
                                  .choiceChipRebuild('Expense');
                              context
                                  .read<AddController>()
                                  .setCategoryType(CategoryType.expense);
                              _categoryTypeSelected =
                                  value.categoryTypeSelected;
                              value.setcategotyid(null);
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    spaceGive,
                    const SetTheDate(),
                    spaceGive,
                    spaceGive,
                    Row(
                      children: [
                        const Expanded(
                            child: Text(
                          "Amount",
                          style: listTileText,
                        )),
                        Expanded(
                          child: TextFormField(
                            maxLength: 10,
                            controller: amountEditingController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              hintText: 'Enter the Amount',
                              border: OutlineInputBorder(),
                            ),
                            validator: (newvalue) {
                              if (newvalue == null || newvalue.isEmpty) {
                                return 'Please Enter Amount';
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    spaceGive,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Category",
                          style: listTileText,
                        ),
                        SizedBox(width: MediaQuery.of(context).size.width / 6),
                        Container(
                          padding: const EdgeInsets.only(top: 2, left: 5),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color:
                                      const Color.fromARGB(255, 187, 184, 184),
                                  width: 1)),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              hint: const Text('Category'),
                              value: categoryId,
                              items: (_categoryTypeSelected ==
                                          CategoryType.income
                                      ? CategoryDB().incomeCategoryListenable
                                      : CategoryDB().expesneCategoryListable)
                                  .map((e) {
                                return DropdownMenuItem(
                                  value: e.id,
                                  onTap: (() {
                                    // ignore: avoid_print
                                    print(e.toString());
                                    categoryModel = e;
                                  }),
                                  child: Text(e.name),
                                );
                              }).toList(),
                              onChanged: ((selectedValue) {
                                // ignore: avoid_print
                                print(selectedValue);
                                setState(() {
                                  categoryId = selectedValue.toString();
                                });
                              }),
                            ),
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              selecationCategory();
                            },
                            icon: const Icon(
                              Icons.add,
                              color: Color.fromARGB(255, 8, 121, 214),
                            )),
                      ],
                    ),
                    spaceGive,
                    spaceGive,
                    Row(
                      children: [
                        const Expanded(
                            child: Text(
                          "Note",
                          style: listTileText,
                        )),
                        Expanded(
                          child: TextFormField(
                            maxLines: 4,
                            maxLength: 30,
                            controller: notesEditingController,
                            keyboardType: TextInputType.name,
                            decoration: const InputDecoration(
                              hintText: 'Write something',
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please Enter Note';
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    spaceGive,
                    ElevatedButton(
                      onPressed: () {
                        formkey.currentState?.validate();

                        _addtransaction(context);
                        context.read<ChartDatas>().getdata();
                        TransactionDb().refresh();
                      },
                      style: ElevatedButton.styleFrom(
                        primary: const Color(0xffD47403),
                      ),
                      child: const Text("Add"),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _addtransaction(context) async {
    String id = DateTime.now().millisecondsSinceEpoch.toString();
    final amountText = amountEditingController.text;
    final notetText = notesEditingController.text;
    if (amountText.isEmpty || notetText.isEmpty || categoryId == null) {
      return;
    }

    final parsedAmount = double.tryParse(amountText);
    if (parsedAmount == null) {
      return;
    }

    if (categoryModel == null) {
      return;
    }

    final model = TransactionModel(
      date: selectedDate,
      amount: parsedAmount,
      type: _categoryTypeSelected!,
      category: categoryModel!,
      note: notetText,
      id: id,
    );
    await TransactionDb().addTransaction(model);

    Navigator.of(context).pop();
    TransactionDb.instance.refresh();
  }

  selecationCategory() {
    if (_categoryTypeSelected == CategoryType.income) {
      popupDialofForAddIncome(context, type);
    } else {
      popupDialofForAddExpense(context, type);
    }
  }
}
