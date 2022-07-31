import 'package:flutter/material.dart';
import 'package:money_management_app1/main.dart';
import 'package:money_management_app1/utils/styles_color.dart';
import 'package:money_management_app1/view/home_screen/widgets/widgets.dart';
import 'package:money_management_app1/view_model/transation_db/transation_db.dart';
import 'package:provider/provider.dart';
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
          Consumer<TransactionDb>(
            builder: (context, value, child) {
              return Column(
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
                              child: BalanceShow(
                                mainText: ' Total Balance\n',
                                typeText: value.balacneNotifier.toString(),
                                color: Colors.black,
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
                            BalanceShow(
                              mainText: 'Income\n',
                              typeText: value.incomeNotifier.toString(),
                              color: const Color.fromARGB(255, 0, 121, 4),
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
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            BalanceShow(
                              mainText: 'Expense\n',
                              typeText: value.expenseNotifier.toString(),
                              color: const Color.fromARGB(255, 209, 15, 1),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

