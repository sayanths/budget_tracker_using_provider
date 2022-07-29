// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:money_management_app1/view/add_button/add_button.dart';

import 'package:money_management_app1/view/home_screen/home_page.dart';
import 'package:money_management_app1/view/pie_chart/pie_chart.dart';
import 'package:money_management_app1/view_model/bottom_controller/bottom_model.dart';
import 'package:provider/provider.dart';

import '../../category/catergory.dart';
import '../../settings/settings.dart';

class BottomNaavigationBar extends StatelessWidget {
  BottomNaavigationBar({Key? key}) : super(key: key);
  List<dynamic> screens = [
    const HomePage(),
    const PieChart(),
    const Category(),
    const Settings(),
  ];

  
  @override
  Widget build(BuildContext context) {
    final screenindexprovider = Provider.of<ScreenIndexProvider>(context);
    int currentScreenIndex = screenindexprovider.fetchCurrentScreenIndex;
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        showSelectedLabels: false,
        elevation: 1.5,
        currentIndex: currentScreenIndex,
        onTap: (value) => screenindexprovider.updateScreenIndex(value),
        items: [
          BottomNavigationBarItem(
              label: 'Home',
              icon: Icon(
                  (currentScreenIndex == 0) ? Icons.home : Icons.home_outlined),
              backgroundColor: Colors.blue
               
              ),
          BottomNavigationBarItem(
            label: 'chart',
            icon: Icon((currentScreenIndex == 1)
                ? Icons.pie_chart_outline_outlined
                : Icons.pie_chart),
          ),
          BottomNavigationBarItem(
            label: 'category',
            icon: Icon((currentScreenIndex == 2)
                ? Icons.category_rounded
                : Icons.category),
          ),
          BottomNavigationBarItem(
            label: 'settings',
            icon: Icon((currentScreenIndex == 3)
                ? Icons.settings_applications
                : Icons.settings),
          ),
        ],
      ),
      body: screens[currentScreenIndex],
           floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 34, 137, 211),
        onPressed: (() {
          Navigator.of(context).push(
              MaterialPageRoute(builder: ((context) => const AddButton())));
        }),
        child: const Icon(
          Icons.add,
          size: 50,
        ),
      ),
     // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    
    );
  }
}