import 'package:flutter/material.dart';

import 'package:money_management_app1/utils/styles_color.dart';

import '../../../home_screen/home_page_widget/home_page_widget.dart';

class SettingsFullWidgets extends StatelessWidget {
  final String title;

  const SettingsFullWidgets({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(6.0),
        child: Container(
          width: MediaQuery.of(context).size.width / 1.2,
          height: MediaQuery.of(context).size.height / 12,
          decoration: BoxDecoration(
            color: containerGreyColor,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(title),
            ],
          ),
        ));
  }
}

class About extends StatelessWidget {
  const About({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 7,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
                Color.fromARGB(255, 2, 72, 130),
                Color.fromARGB(255, 8, 82, 173),
              ]),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    children: [
                      spaceGive,
                      spaceGive,
                      Row(
                        children: [
                          GestureDetector(
                              onTap: (() {
                                Navigator.of(context).pop();
                              }),
                              child: const Icon(
                                Icons.arrow_back_ios_new,
                                color: Colors.white,
                              )),
                          RichText(
                            text: const TextSpan(children: [
                              TextSpan(text: "About\n", style: mainHeading),
                              TextSpan(text: "All about me"),
                            ]),
                          ),
                        ],
                      ),
                      spaceGive,
                    ],
                  ),
                ),
              ],
            ),
          ),
          forSomeLongSpace,
          const Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              "This is an offline income expense tracker developed by Sayanth A.This app will help you to track your expenses and income which you can understand where you spend more money,and can controll your expense.",
              style: TextStyle(fontSize: 15, color: Colors.black),
            ),
          ),
        ],
      )),
    );
  }
}
