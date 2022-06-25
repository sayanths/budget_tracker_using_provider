import 'package:flutter/material.dart';
import 'package:money_management_app1/main.dart';
import 'package:money_management_app1/screens/db_functions/category/transation_db/transation_db.dart';
import 'package:money_management_app1/styles_color.dart';
import 'package:shared_preferences/shared_preferences.dart';

Widget spaceGive = const SizedBox(
  height: 10,
);
String name = '';

class AppBarShowsTotalBalanceIncomeAndExpnse extends StatefulWidget {
  const AppBarShowsTotalBalanceIncomeAndExpnse(
      {Key? key, this.heading, this.month, this.amount})
      : super(key: key);

  final String? heading;
  final String? month;
  final double? amount;

  @override
  State<AppBarShowsTotalBalanceIncomeAndExpnse> createState() =>
      _AppBarShowsTotalBalanceIncomeAndExpnseState();
}

class _AppBarShowsTotalBalanceIncomeAndExpnseState
    extends State<AppBarShowsTotalBalanceIncomeAndExpnse> {
  @override
  void initState() {
    getValidation();
    super.initState();
  }

  Future getValidation() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var obtainName = sharedPreferences.getString(sharedName);

    setState(() {
      name = obtainName!;
    });
  }

  @override
  Widget build(BuildContext context) {
    TransactionDb.instance.refresh();
    return Container(
      height: MediaQuery.of(context).size.height / 2.5,
      decoration: const BoxDecoration(
        gradient: LinearGradient(colors: [
          Color.fromARGB(255, 34, 94, 173),
          Color(0xff0096c7),
          Color(0xff0077b6),
        ]),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: ListView(
        children: [
          spaceGive,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 3, horizontal: 20),
                child: RichText(
                  text: TextSpan(children: [
                    TextSpan(text: 'Hey $name\n', style: mainHeading),
                    const TextSpan(text: 'Manage Your Money Easily'),
                  ]),
                ),
              ),
            ],
          ),
          spaceGive,
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 50, right: 50),
                child: Card(
                  child: Container(
                    height: MediaQuery.of(context).size.height / 10,
                    width: MediaQuery.of(context).size.width / 1,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 255, 255, 255),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Column(
                      children: [
                        spaceGive,
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: ValueListenableBuilder(
                            valueListenable:
                                TransactionDb.instance.balacneNotifier,
                            builder:
                                (BuildContext context, newValue, Widget? _) {
                              return RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(children: [
                                  const TextSpan(
                                    text: ' Total Balance\n',
                                    style: listTileText,
                                  ),
                                  TextSpan(
                                    text: newValue.toString(),
                                    style: const TextStyle(
                                      fontSize: 25,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ]),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              spaceGive,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height / 8.9,
                    width: MediaQuery.of(context).size.width / 3,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ValueListenableBuilder(
                          valueListenable:
                              TransactionDb.instance.incomeNotifier,
                          builder: (BuildContext context, double incomeValue,
                              Widget? _) {
                            return RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(children: [
                                const TextSpan(
                                  text: 'Income\n',
                                  style: listTileText,
                                ),
                                TextSpan(
                                  text: incomeValue.toString(),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green,
                                    fontSize: 25,
                                  ),
                                ),
                              ]),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height / 8.9,
                    width: MediaQuery.of(context).size.width / 3,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                    child: ValueListenableBuilder(
                      valueListenable: TransactionDb.instance.expenseNotifier,
                      builder: (BuildContext context, double expenseValue,
                          Widget? _) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(children: [
                                const TextSpan(
                                  text: 'Expense\n',
                                  style: listTileText,
                                ),
                                TextSpan(
                                  text: expenseValue.toString(),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red,
                                    fontSize: 25,
                                  ),
                                ),
                              ]),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
