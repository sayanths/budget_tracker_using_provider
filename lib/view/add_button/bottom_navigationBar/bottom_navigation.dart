import 'package:flutter/material.dart';
import 'package:money_management_app1/view/add_button/add_button.dart';

import 'package:money_management_app1/view/home_screen/home_page.dart';
import 'package:money_management_app1/view/pie_chart/pie_chart.dart';

import '../../category/catergory.dart';
import '../../settings/settings.dart';


class BottomNavigationPage extends StatefulWidget {
  const BottomNavigationPage({Key? key}) : super(key: key);



  @override
  State<BottomNavigationPage> createState() => _BottomNavigationPageState();
}

class _BottomNavigationPageState extends State<BottomNavigationPage> {
  int _currentIndex = 0;
  final List screens = [
    const HomePage(),
    const PieChart(),
    const Category(),
    const Settings(),
  ];

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = const HomePage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        bucket: bucket,
        child: currentScreen,
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 60,
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
              Color.fromARGB(255, 4, 108, 194),
              Color.fromARGB(255, 8, 82, 152),
            ]),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: (() {
                  setState(() {
                    currentScreen = const HomePage();
                    _currentIndex = 0;
                  });
                }),
                icon: Icon(
                  Icons.home,
                  size: 40,
                  color: _currentIndex == 0
                      ? const Color.fromARGB(255, 94, 236, 255)
                      : const Color.fromARGB(255, 251, 249, 249),
                ),
              ),
              IconButton(
                  onPressed: (() {
                    setState(() {
                      currentScreen = const PieChart();
                      _currentIndex = 1;
                    });
                  }),
                  icon: Icon(
                    Icons.pie_chart,
                    size: 40,
                    color: _currentIndex == 1
                        ? const Color.fromARGB(255, 94, 236, 255)
                        : const Color.fromARGB(255, 251, 249, 249),
                  )),
              IconButton(
                  onPressed: (() {
                    setState(() {
                      currentScreen = const Category();
                      _currentIndex = 2;
                    });
                  }),
                  icon: Icon(
                    Icons.category,
                    size: 40,
                    color: _currentIndex == 2
                        ? const Color.fromARGB(255, 94, 236, 255)
                        : const Color.fromARGB(255, 251, 249, 249),
                  )),
              IconButton(
                  onPressed: (() {
                    setState(() {
                      currentScreen = const Settings();
                      _currentIndex = 3;
                    });
                  }),
                  icon: Icon(
                    Icons.settings,
                    size: 40,
                    color: _currentIndex == 3
                        ? const Color.fromARGB(255, 94, 236, 255)
                        : const Color.fromARGB(255, 251, 249, 249),
                  )),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 3, 106, 242),
        onPressed: (() {
          Navigator.of(context).push(
              MaterialPageRoute(builder: ((context) => const AddButton())));
        }),
        child: const Icon(
          Icons.add,
          size: 50,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
