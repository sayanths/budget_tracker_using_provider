import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_management_app1/model/category_model/category_model.dart';
import 'package:money_management_app1/model/transaction_model/transaction_model.dart';
import 'package:money_management_app1/utils/styles_color.dart';
import 'package:money_management_app1/view/home_screen/home_page_widget/home_page_widget.dart';
import 'package:money_management_app1/view_model/transation_db/transation_db.dart';

class ExpenseChartList extends StatelessWidget {
  const ExpenseChartList({Key? key}) : super(key: key);

 

  @override
  Widget build(BuildContext context) {
    // TransactionDb.instance.refresh();
    return ValueListenableBuilder(
        valueListenable: TransactionDb().expenseChartListNotifier,
        builder: (BuildContext context, List<TransactionModel> incomeList,
            Widget? _) {
          return ListView.separated(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: ((BuildContext context, int index) {
                final newValue = incomeList[index];
                return Card(
                  child: Container(
                    height: 80,
                    color: const Color.fromARGB(255, 250, 236, 198),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 14),
                      child: ListTile(
                        leading: Container(
                          width: 80,
                          decoration: BoxDecoration(
                            color: newValue.type == CategoryType.income
                                ? const Color.fromARGB(255, 42, 139, 46)
                                : const Color.fromARGB(255, 223, 29, 15),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            children: [
                              spaceGive,
                              Text(
                                parseDate(newValue.date),
                                textAlign: TextAlign.center,
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
                              color: newValue.type == CategoryType.income
                                  ? const Color.fromARGB(255, 42, 139, 46)
                                  : const Color.fromARGB(255, 223, 29, 15),
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
              itemCount: incomeList.length);
        });
  }
}

String parseDate(DateTime date) {
  final datefrmt = DateFormat.MMMd().format(date);
  final splitDate = datefrmt.split(' ');
  return '${splitDate.last}\n${splitDate.first}';
}
