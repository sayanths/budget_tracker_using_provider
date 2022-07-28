import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_management_app1/utils/styles_color.dart';
import '../../home_screen/home_page_widget/home_page_widget.dart';

class AddStyleContainer extends StatelessWidget {
  final String mainTitle;
  final String subTitle;

  const AddStyleContainer(
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
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.white,
                  size: 30,
                )),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
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
      ),
    );
  }
}

DateTime selectedDate = DateTime.now();

class SetTheDate extends StatefulWidget {
  const SetTheDate({Key? key}) : super(key: key);

 

  @override
  State<SetTheDate> createState() => _SetTheDateState();
}

class _SetTheDateState extends State<SetTheDate> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: Text(
            "Date",
            style: listTileText,
          ),
        ),
        Expanded(
          child: TextButton(
            onPressed: () {
              _selectDate(context);
            },
            child: Row(
              children: [
                const Icon(Icons.date_range),
                const SizedBox(
                  width: 15,
                ),
                Text(
                  DateFormat('d MMM').format(selectedDate),
                  style: const TextStyle(
                      color: Color.fromARGB(255, 101, 96, 96),
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000, 31),
      lastDate: DateTime(2100, 31),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }
}
