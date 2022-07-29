import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:money_management_app1/main.dart';
import 'package:money_management_app1/utils/styles_color.dart';
import 'package:money_management_app1/view/add_button/bottom_navigationBar/bottom_navigation.dart';
import 'package:money_management_app1/view/home_screen/home_page_widget/home_page_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';



class NameTypingScreen extends StatefulWidget {
  const NameTypingScreen({Key? key}) : super(key: key);

  

  @override
  State<NameTypingScreen> createState() => _NameTypingScreenState();
}

class _NameTypingScreenState extends State<NameTypingScreen> {
  final _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 238, 237, 237),
      body: ListView(
        children: [
          Column(
            children: [
             spaceGive,
             spaceGive,
              const Text(
                "welcome",
                style: TextStyle(fontSize: 20),
              ),
              const Center(
                child: Text(
                  "Budget Tracker",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 8, 100, 176),
                  ),
                ),
              ),
              spaceGive,
              
              LottieBuilder.asset(
                "assets/typingscreeen.json",
                height: 200,
              ),
              forSomeLongSpace,
              BlurryContainer(
                blur: 200,
                width:360,
                height: 250,
                elevation: 3,
                color: const Color.fromARGB(0, 196, 189, 189),
                padding: const EdgeInsets.all(8),
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                child: Column(
                  children: [
                    spaceGive,
                    spaceGive,
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Enter your name",
                            style: TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontSize: 20,fontFamily: 'RobotoMono'),
                          )),
                    ),
                    spaceGive,
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                            hintText: '(optional)',
                            border: OutlineInputBorder()),
                      ),
                    ),
                    spaceGive,
                    ElevatedButton(
                        onPressed: () async {
                          final SharedPreferences shared =
                              await SharedPreferences.getInstance();
                          shared.setString(sharedName, _nameController.text);
                          shared.setBool(sharedCheck, true);
                  
                          // ignore: use_build_context_synchronously
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) =>
                                       BottomNaavigationBar()));
                        },
                        child: const Text("submit")),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
