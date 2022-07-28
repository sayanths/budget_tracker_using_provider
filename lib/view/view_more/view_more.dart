import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:money_management_app1/model/category_model/category_model.dart';
import 'package:money_management_app1/model/transaction_model/transaction_model.dart';
import 'package:money_management_app1/utils/styles_color.dart';
import 'package:money_management_app1/view/texttile_edit/texttile_edit.dart';
import 'package:money_management_app1/view/view_more/more_Screen_widget/more_screen_widget.dart';
import 'package:money_management_app1/view_model/transation_db/transation_db.dart';
import 'package:month_year_picker/month_year_picker.dart';
import '../add_button/add_button_widget.dart/add_button_widget.dart';
import '../home_screen/home_page_widget/home_page_widget.dart';

class ViewMoreList extends StatefulWidget {
  const ViewMoreList({Key? key}) : super(key: key);

  @override
  State<ViewMoreList> createState() => _ViewMoreListState();
}

ValueNotifier<bool> visibleMonth = ValueNotifier(false);
DateTime selectedMonth = DateTime.now();

class _ViewMoreListState extends State<ViewMoreList> {
  @override
  void initState() {
    updateData();
    super.initState();
  }

  String? _dropName = 'All';

  @override
  Widget build(BuildContext context) {
    var period = [
      'All',
      'Today',
      'Yesterday',
      'Monthly',
    ];
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            const HeadingContainer(),
            spaceGive,
            spaceGive,
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: DropdownButton(
                        hint: Text(_dropName.toString()),
                        value: _dropName,
                        items: period.map((e) {
                          return DropdownMenuItem(value: e, child: Text(e));
                        }).toList(),
                        onChanged: (String? value) {
                          setState(() {
                            _dropName = value;
                          });
                        }),
                  ),
                ),
                ValueListenableBuilder(
                  valueListenable: visibleMonth,
                  builder: (BuildContext context, bool value, Widget? _) {
                    return Visibility(
                        visible: value,
                        child: TextButton(
                            onPressed: () {
                              pickDate(context);
                            },
                            child: Text(
                                DateFormat('MMMM').format(selectedMonth))));
                  },
                ),
              ],
            ),
            spaceGive,
            spaceGive,
            ValueListenableBuilder(
                valueListenable: valueChecking(context),
                builder: (BuildContext context, List<TransactionModel> newList,
                    Widget? _) {
                  return newList.isEmpty
                      ? Column(
                          children: const [Text("No  transaction Added")],
                        )
                      : ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: ((BuildContext context, int index) {
                            final newValue = newList[index];
                            return Slidable(
                              endActionPane: ActionPane(
                                motion: const ScrollMotion(),
                                children: [
                                  SlidableAction(
                                    onPressed: (BuildContext context) {
                                      showDialog(
                                        context: context,
                                        builder: ((context) {
                                          return AlertDialog(
                                            title: const Text(
                                                "Do you want to delete?"),
                                            actions: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  TextButton(
                                                      onPressed: () {
                                                        TransactionDb()
                                                            .deleteTransaction(
                                                                newValue.id
                                                                    .toString());
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child: const Text("Yes")),
                                                  const SizedBox(
                                                    width: 30,
                                                  ),
                                                  TextButton(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child: const Text("No")),
                                                ],
                                              ),
                                            ],
                                          );
                                        }),
                                      );
                                    },
                                    backgroundColor: const Color.fromARGB(
                                        255, 255, 255, 255),
                                    foregroundColor:
                                        const Color.fromARGB(255, 175, 2, 2),
                                    icon: Icons.delete,
                                    label: 'Delete',
                                  ),
                                  SlidableAction(
                                    onPressed: (BuildContext context) {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => EditPage(
                                            datas: newValue,
                                          ),
                                        ),
                                      );
                                    },
                                    backgroundColor: const Color.fromARGB(
                                        255, 255, 255, 255),
                                    foregroundColor:
                                        const Color.fromARGB(255, 38, 157, 2),
                                    icon: Icons.edit,
                                    label: 'Edit',
                                  ),
                                ],
                              ),
                              child: Container(
                                height: 90,
                                color: const Color.fromARGB(255, 250, 236, 198),
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 14),
                                  child: ListTile(
                                    leading: Container(
                                      width: 80,
                                      decoration: BoxDecoration(
                                        color:
                                            newValue.type == CategoryType.income
                                                ? const Color.fromARGB(
                                                    255, 42, 139, 46)
                                                : const Color.fromARGB(
                                                    255, 208, 34, 21),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Column(
                                        children: [
                                          spaceGive,
                                          Text(
                                            parseDate(newValue.date),
                                            style: listTextDate,
                                          )
                                        ],
                                      ),
                                    ),
                                    title: Text(
                                      newValue.note.toString(),
                                      style: listTileText,
                                    ),
                                    trailing: Text(
                                      '₹${newValue.amount}',
                                      style: TextStyle(
                                          color: newValue.type ==
                                                  CategoryType.income
                                              ? const Color.fromARGB(
                                                  255, 42, 139, 46)
                                              : const Color.fromARGB(
                                                  255, 223, 29, 15),
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                          separatorBuilder: ((BuildContext context, int index) {
                            return const SizedBox(
                              height: 10,
                            );
                          }),
                          itemCount: newList.length);
                }),
          ],
        ),
      ),
    );
  }

  ValueNotifier<List<TransactionModel>> valueChecking(context) {
    visibleMonth.value = false;
    if (_dropName == 'Today') {
      return TransactionDb.instance.todayNotifier;
    } else if (_dropName == 'Yesterday') {
      return TransactionDb.instance.yesterdayNotifier;
    } else if (_dropName == 'Monthly') {
      visibleMonth.value = true;

      return TransactionDb.instance.monthelyNotifier;
    } else {
      return TransactionDb.instance.transationListNotifier;
    }
  }

  pickDate(context) async {
    final selected = await showMonthYearPicker(
        context: context,
        initialDate: selectedMonth,
        firstDate: DateTime(2020),
        lastDate: selectedDate);

    setState(() {
      selectedMonth = selected ?? DateTime.now();
    });

    TransactionDb.instance.monthelyNotifier.value.clear();
    updateData();
    // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
    TransactionDb.instance.monthelyNotifier.notifyListeners();
  }

  updateData() async {
    Future.forEach(TransactionDb.instance.transationListNotifier.value,
        (TransactionModel model) {
      if (model.date.month == selectedMonth.month &&
          model.date.year == selectedMonth.year) {
        TransactionDb.instance.monthelyNotifier.value.add(model);
      }
    });
  }
}

String parseDate(DateTime date) {
  final datefrmt = DateFormat.MMMd().format(date);
  final splitDate = datefrmt.split(' ');
  return '${splitDate.last}\n${splitDate.first}';
}
