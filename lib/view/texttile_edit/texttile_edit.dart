

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_management_app1/model/category_model/category_model.dart';
import 'package:money_management_app1/model/transaction_model/transaction_model.dart';
import 'package:money_management_app1/utils/styles_color.dart';
import 'package:money_management_app1/view/category/expense_category/expense_category.dart';
import 'package:money_management_app1/view/category/income_category/income_catergory.dart';
import 'package:money_management_app1/view_model/category_db.dart/category_db.dart';
import 'package:money_management_app1/view/add_button/add_button_widget.dart/add_button_widget.dart';
import 'package:money_management_app1/view/home_screen/home_page_widget/home_page_widget.dart';
import 'package:money_management_app1/view_model/edit_controller/edit_controller.dart';
import 'package:money_management_app1/view_model/transation_db/transation_db.dart';
import 'package:provider/provider.dart';

class EditPage extends StatefulWidget {
  final TransactionModel datas;

  const EditPage({Key? key, required this.datas}) : super(key: key);

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
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
    super.initState();
    _categoryTypeSelected = widget.datas.category.type;
    dateTime = widget.datas.date;
    categoryModel = widget.datas.category;
    amountEditingController.text = widget.datas.amount.toString();
    notesEditingController.text = widget.datas.note.toString();
  }

  @override
  void dispose() {
    super.dispose();
  }

  String type = "income";
  late int amount;
  String note = "some expense";

  @override
  Widget build(BuildContext context) {
    TransactionDb.instance.refresh();
    //  CategoryDB.instance.refreshUi();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0),
        child: ListView(
          children: [
            const AddStyleContainer(
                mainTitle: "Edit Transaction\n",
                subTitle: "Edit your transaction"),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: formkey,
                child: Column(
                  children: [
                    spaceGive,
                    spaceGive,
                    Row(
                      children: [
                        const Expanded(
                          child: Text(
                            "Date",
                            style: listTileText,
                          ),
                        ),
                        Expanded(
                          child: Consumer<EditController>(
                            builder: (context, value, child) => TextButton(
                              onPressed: () async {
                                context
                                    .read<EditController>()
                                    .datePick(context, widget.datas.date);
                              },
                              child: Text(
                                value.dateTime == null
                                    ? widget.datas.date.toString()
                                    : DateFormat('d MMM')
                                        .format(value.dateTime!),
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 101, 96, 96),
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    spaceGive,
                    Row(
                      children: [
                        const Expanded(
                          child: Text(
                            "Amount",
                            style: listTileText,
                          ),
                        ),
                        Expanded(
                          child: TextFormField(
                            maxLength: 10,
                            controller: amountEditingController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              hintText: 'Enter the Amount',
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please Enter Amount';
                              } else {
                                return null;
                              }
                            },
                          ),
                        )
                      ],
                    ),
                    spaceGive,
                    spaceGive,
                    Consumer<EditController>(
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
                                  .read<EditController>()
                                  .choiceChipRebuild('Income');
                              context
                                  .read<EditController>()
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
                                  .read<EditController>()
                                  .choiceChipRebuild('Expense');
                              context
                                  .read<EditController>()
                                  .setCategoryType(CategoryType.expense);
                              _categoryTypeSelected =
                                  value.categoryTypeSelected;
                              value.setcategotyid(null);
                            },
                          ),
                        ],
                      ),
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
                              child: Consumer<EditController>(
                            builder: (context, value, _) => DropdownButton(
                              value: value.categoryId,
                              icon: const Icon(Icons.keyboard_arrow_down),
                              hint: value.categoryTypeSelected ==
                                      widget.datas.type
                                  ? Text(widget.datas.category.name)
                                  : const Text(
                                      'Select Category',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black54),
                                    ),
                              items: (value.categoryTypeSelected ==
                                          CategoryType.income
                                      ? context
                                          .read<CategoryDB>()
                                          .incomeCategoryListenable
                                      : context
                                          .read<CategoryDB>()
                                          .expesneCategoryListable)
                                  .map(
                                (e) {
                                  return DropdownMenuItem(
                                    value: e.id,
                                    onTap: () {
                                      value.categoryModel = e;
                                    },
                                    child: Text(e.name),
                                  );
                                },
                              ).toList(),
                              onChanged: (String? selectedValue) {
                                // ignore: avoid_print
                                print('category id=$selectedValue');
                                value.setcategotyid(selectedValue!);
                               
                              },
                            ),
                          )),
                        ),
                        IconButton(
                            onPressed: () {
                              selecationCategory(context, type);
                            },
                            icon: const Icon(
                              Icons.add,
                              color: Color.fromARGB(255, 8, 121, 214),
                            )),
                      ],
                    ),
                    spaceGive,
                    Row(
                      children: [
                        const Expanded(
                          child: Text(
                            "Notes",
                            style: listTileText,
                          ),
                        ),
                        Expanded(
                          child: TextFormField(
                            maxLength: 30,
                            controller: notesEditingController,
                            onChanged: ((value) {
                              note = value;
                            }),
                            maxLines: 5,
                            decoration: const InputDecoration(
                              hintText: 'Write Something',
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please write something';
                              } else {
                                return null;
                              }
                            },
                          ),
                        )
                      ],
                    ),
                    spaceGive,
                    ElevatedButton(
                      onPressed: () {
                        formkey.currentState?.validate();
                        _updateTransaction(context);

                        TransactionDb().refresh();
                      },
                      style: ElevatedButton.styleFrom(
                        primary: const Color(0xffD47403),
                      ),
                      child: const Text("save Edit"),
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

  Future<void> _updateTransaction(context) async {
    final amountText = amountEditingController.text;
    final notetText = notesEditingController.text;
    categoryId = Provider.of<EditController>(context, listen: false).categoryId;
    categoryId ??= widget.datas.category.id;
    dateTime = Provider.of<EditController>(context, listen: false).dateTime;
    _categoryTypeSelected = Provider.of<EditController>(context, listen: false)
        .categoryTypeSelected;

    // log(dateTime.toString());
    // log(amountText.toString());
    // log(_categoryTypeSelected.toString());
    // log(categoryModel.toString());
    // log(notetText.toString());
    // log(widget.datas.id.toString());
    // log(categoryId.toString());

    if (amountText.isEmpty || notetText.isEmpty || categoryId == null) {
      print('amount,note,categoryid');
      return;
    }

    final parsedAmount = double.tryParse(amountText);
    if (parsedAmount == null) {
      print('parsedamountnull');
      return;
    }

    if (categoryModel == null) {
      print('modl null');
      return;
    }

    final model = TransactionModel(
      date: dateTime!,
      amount: parsedAmount,
      type: _categoryTypeSelected!,
      category: categoryModel!,
      note: notetText,
      id: widget.datas.id,
    );

    await Provider.of<TransactionDb>(context, listen: false)
        .updateTransation(widget.datas.id, model);

    Navigator.of(context).pop();
    TransactionDb.instance.refresh();
  }

  selecationCategory(context, type) {
    if (_categoryTypeSelected == CategoryType.income) {
      popupDialofForAddIncome(context, type);
    } else {
      popupDialofForAddExpense(context, type);
    }
  }
}
