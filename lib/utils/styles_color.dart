import 'package:flutter/material.dart';
import 'package:money_management_app1/view/home_screen/home_page_widget/home_page_widget.dart';


const primaryColor = Color(0xff069CCB);

const incmExpTile = TextStyle(
    fontWeight: FontWeight.bold, fontSize: 17, fontFamily: 'RobotoMono');
const mainHeading = TextStyle(fontWeight: FontWeight.bold, fontSize: 30);
const expenseColor = TextStyle(color: Colors.red, fontFamily: 'RobotoMono');
const incomeColor = TextStyle(color: Colors.green, fontFamily: 'RobotoMono');
Widget forSomeLongSpace = const SizedBox(
  height: 50,
);
const listTextDate = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 16,
    color: Colors.white,
    fontFamily: 'RobotoMono');
const listTileText = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 16,
    color: Colors.black,
    fontFamily: 'RobotoMono');

const tabBarSelectedColor = Color.fromARGB(255, 35, 131, 210);

const containerGreyColor = Color(0xffD3D2CD);

class HeadingStyleContainer extends StatelessWidget {
  final String mainTitle;
  final String subTitle;

  const HeadingStyleContainer(
      {Key? key, required this.mainTitle, required this.subTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 7,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        gradient: LinearGradient(colors: [
          Color.fromARGB(255, 4, 78, 139),
          Color.fromARGB(255, 28, 126, 219),
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
                RichText(
                  text: TextSpan(children: [
                    TextSpan(text: mainTitle, style: mainHeading),
                    TextSpan(text: subTitle),
                  ]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
