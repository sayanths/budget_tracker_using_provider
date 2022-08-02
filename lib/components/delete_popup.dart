// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:money_management_app1/model/transaction_model/transaction_model.dart';
import 'package:money_management_app1/view_model/income_controller/income_controller.dart';
import 'package:money_management_app1/view_model/transation_db/transation_db.dart';
import 'package:provider/provider.dart';

class TheDialogBox extends StatelessWidget {
  const TheDialogBox({
    Key? key,
    required this.newValue,
  }) : super(key: key);

  final TransactionModel newValue;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Do you want to delete?"),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
                onPressed: () async {
                  await context
                      .read<TransactionDb>()
                      .deleteTransaction(newValue.id);
                  context.read<IncomeChartController>().dispose();

                  // await context
                  //     .read<IncomeChartController>()
                  //     .getAllIncomeData();

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
  }
}
