import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:money_management_app1/components/delete_popup.dart';
import 'package:money_management_app1/model/category_model/category_model.dart';
import 'package:money_management_app1/utils/styles_color.dart';
import 'package:money_management_app1/view/home_screen/home_page_widget/home_page_widget.dart';
import 'package:money_management_app1/view/texttile_edit/texttile_edit.dart';
import 'package:money_management_app1/view_model/transation_db/transation_db.dart';
import 'package:provider/provider.dart';

class ItemList extends StatelessWidget {
  const ItemList({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Consumer<TransactionDb>(
      builder: (context, newList, child) {
        return newList.transationListNotifier.isEmpty
            ? Column(
                children: [
                  const Text(
                    "No transaction Added",
                    style: TextStyle(fontSize: 16, color: Colors.blueGrey),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Image.asset(
                    'assets/transactionpagelogo.png',
                    color: const Color.fromARGB(255, 214, 214, 244),
                    height: MediaQuery.of(context).size.height / 4,
                  )
                ],
              )
            : ListView.separated(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: ((BuildContext context, int index) {
                  final newValue = newList.transationListNotifier[index];
                  return Card(
                    child: Slidable(
                      endActionPane: ActionPane(
                        motion: const ScrollMotion(),
                        children: [
                          SlidableAction(
                            onPressed: (BuildContext context) {
                              showDialog(
                                context: context,
                                builder: ((context) {
                                  return TheDialogBox(newValue: newValue);
                                }),
                              );
                            },
                            backgroundColor:
                                const Color.fromARGB(255, 250, 250, 250),
                            foregroundColor:
                                const Color.fromARGB(255, 201, 5, 5),
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
                            backgroundColor:
                                const Color.fromARGB(255, 255, 255, 255),
                            foregroundColor:
                                const Color.fromARGB(255, 2, 152, 30),
                            icon: Icons.edit,
                            label: 'Edit',
                          ),
                        ],
                      ),
                      child: GestureDetector(
                        onTap: () {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            duration: Duration(seconds: 2),
                            backgroundColor: Color.fromARGB(255, 66, 66, 66),
                            content: Text("swipe for more "),
                          ));
                        },
                        child: SizedBox(
                          height: 90,
                          child: Padding(
                            padding: const EdgeInsets.only(
                              bottom: 15,
                              top: 15,
                            ),
                            child: ListTile(
                              leading: Container(
                                width: 80,
                                decoration: BoxDecoration(
                                  color: newValue.type== CategoryType.income
                                      ? const Color.fromARGB(255, 42, 139, 46)
                                      : const Color.fromARGB(255, 208, 34, 21),
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
                                        : const Color.fromARGB(
                                            255, 223, 29, 15),
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
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
                itemCount: newList.transationListNotifier.length >= 4
                    ? 4
                    : newList.transationListNotifier.length);
      },
    );
  }
}


String parseDate(DateTime date) {
  final datefrmt = DateFormat.MMMd().format(date);
  final splitDate = datefrmt.split(' ');
  return '${splitDate.last}\n${splitDate.first}';
}
