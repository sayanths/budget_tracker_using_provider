import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_management_app1/model/category_model/category_model.dart';
import 'package:money_management_app1/model/transaction_model/transaction_model.dart';
import 'package:money_management_app1/utils/styles_color.dart';
import 'package:money_management_app1/view_model/category_db.dart/category_db.dart';
import 'package:money_management_app1/view/add_button/add_button_widget.dart/add_button_widget.dart';
import 'package:money_management_app1/view/home_screen/home_page_widget/home_page_widget.dart';
import 'package:money_management_app1/view_model/transation_db/transation_db.dart';

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

  late int amount;
  String note = "some expense";

  @override
  Widget build(BuildContext context) {
    TransactionDb.instance.refresh();
    CategoryDB.instance.refreshUi();
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
                          child: TextButton(
                            onPressed: () async {
                              final selectedDateTemp = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime.now());
                              if (selectedDateTemp == null) {
                                widget.datas.date;
                              } else {
                                setState(() {
                                  dateTime = selectedDateTemp;
                                });
                              }
                            },
                            child: Text(
                              dateTime == null
                                  ? ""
                                  : DateFormat('d MMM').format(dateTime!),
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 101, 96, 96),
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ChoiceChip(
                          label: Text(
                            "Income",
                            style: TextStyle(
                                color:
                                    _categoryTypeSelected == CategoryType.income
                                        ? Colors.white
                                        : Colors.black),
                          ),
                          selectedColor: const Color.fromARGB(255, 3, 86, 154),
                          selected: _categoryTypeSelected == CategoryType.income
                              ? true
                              : false,
                          onSelected: (value) {
                            setState(() {
                              _categoryTypeSelected = CategoryType.income;
                              categoryId = null;
                            });
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
                          selectedColor: const Color.fromARGB(255, 3, 86, 154),
                          selected:
                              _categoryTypeSelected == CategoryType.expense
                                  ? true
                                  : false,
                          onSelected: (value) {
                            setState(() {
                              _categoryTypeSelected = CategoryType.expense;
                              categoryId = null;
                            });
                          },
                        ),
                      ],
                    ),
                    spaceGive,
                    Row(
                      children: [
                        const Expanded(
                          child: Text(
                            "Category",
                            style: listTileText,
                          ),
                        ),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(width: 1,color: Colors.grey)
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                  hint: Text(widget.datas.category.name),
                                  value: categoryId,
                                  items: (_categoryTypeSelected ==
                                              CategoryType.income
                                          ? CategoryDB().incomeCategoryListable
                                          : CategoryDB().expesneCategoryListable)
                                      .value
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
                                  })),
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
      date: dateTime!,
      amount: parsedAmount,
      type: _categoryTypeSelected!,
      category: categoryModel!,
      note: notetText,
      id: widget.datas.id,
    );
    await TransactionDb().updateTransation(widget.datas.id, model);
    Navigator.of(context).pop();
    TransactionDb.instance.refresh();
  }
}
