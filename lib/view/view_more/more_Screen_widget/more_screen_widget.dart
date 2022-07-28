
import 'package:flutter/material.dart';
import 'package:money_management_app1/utils/styles_color.dart';

import '../../home_screen/home_page_widget/home_page_widget.dart';

class HeadingContainer extends StatelessWidget {
  const HeadingContainer({Key? key}) : super(key: key);

  

  @override
  Widget build(BuildContext context) {
    return Container(
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
                        TextSpan(
                            text: "Transaction Details\n", style: mainHeading),
                        TextSpan(text: "See All Transaction"),
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
    );
  }
}
