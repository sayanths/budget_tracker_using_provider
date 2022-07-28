import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:money_management_app1/utils/styles_color.dart';
import 'package:money_management_app1/view_model/category_db.dart/category_db.dart';
import 'package:money_management_app1/view/home_screen/home_page_widget/home_page_widget.dart';
import 'package:money_management_app1/view/home_screen/listview_sperated_list.dart';
import 'package:money_management_app1/view/view_more/view_more.dart';
import 'package:money_management_app1/view_model/transation_db/transation_db.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);



  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    TransactionDb().refresh();
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: primaryColor));
        
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TransactionDb.instance.refresh();
    CategoryDB.instance.refreshUi();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(children: [
       const AppBarShowsTotalBalanceIncomeAndExpnse(),
      spaceGive,
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Recently Added"),
            InkWell(
              onTap: (() {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const ViewMoreList()));
              }),
              child: const Text(
                "View More",
                style: listTileText,
              ),
            ),
          ],
        ),
      ),
      spaceGive,
      Expanded(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromARGB(255, 255, 255, 255),
                  Color.fromARGB(255, 254, 254, 254),
                ]),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30)),
          ),
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: ItemList(),
          ),
        ),
      ),
    ]),
    );
  }
}
