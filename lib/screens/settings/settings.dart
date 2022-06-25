import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:money_management_app1/screens/db_functions/category/category_db.dart';
import 'package:money_management_app1/screens/db_functions/category/transation_db/transation_db.dart';
import 'package:money_management_app1/screens/home_screen/home_page.dart';
import 'package:money_management_app1/screens/home_screen/home_page_widget/home_page_widget.dart';
import 'package:money_management_app1/screens/settings/notification/local_noti.dart';
import 'package:money_management_app1/screens/settings/setting_widgets/settings_widget/setttings_widgets.dart';
import 'package:money_management_app1/screens/splash_screen.dart';
import 'package:money_management_app1/styles_color.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  void initState() {
    super.initState();
    NotificationApi().init(initScheduled: true);
  }

  void listenNotifications() {
    NotificationApi.onNotifications.listen(onClickNotifications);
  }

  onClickNotifications(String? payload) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const HomePage(),
    ));
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          final deffent = DateTime.now().difference(pressedtime);
          final isExit = deffent >= const Duration(seconds: 2);
          pressedtime = DateTime.now();

          if (isExit) {
            exitsnackbar();
            return false;
          } else {
            return true;
          }
        },
        child: SafeArea(
          child: Column(
            children: [
              const HeadingStyleContainer(
                  mainTitle: "Settings\n", subTitle: "Configure your Settings"),
              spaceGive,
              Container(
                width: MediaQuery.of(context).size.width / 1.2,
                height: MediaQuery.of(context).size.height / 12,
                decoration: BoxDecoration(
                  color: containerGreyColor,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                        onPressed: () {
                          timePicking(context: context);
                        },
                        child: const Text(
                          "Set Notifcation",
                          style: TextStyle(color: Colors.black),
                        )),
                  ],
                ),
              ),
              GestureDetector(
                  onTap: (() {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => const About()));
                  }),
                  child: const SettingsFullWidgets(title: "About")),
              const SettingsFullWidgets(title: "Version 1.0.1"),
              ElevatedButton(
                onPressed: () {
                  _showReset(context);
                },
                style: ElevatedButton.styleFrom(
                  primary: const Color.fromARGB(255, 0, 66, 120),
                  shape: const StadiumBorder(),
                ),
                child: const Text("Reset"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  timePicking({required context}) async {
    final TimeOfDay? pickedTIme = await showTimePicker(
      initialEntryMode: TimePickerEntryMode.dial,
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTIme != null && pickedTIme != TimeOfDay.now()) {
      setState(() {
        NotificationApi.showScheduledNotifications(
            title: "Hello, Friend",
            body: "📅We miss to add a new transaction, click here to add",
            scheduledTime: Time(pickedTIme.hour, pickedTIme.minute, 0));
      });
    }
    if (pickedTIme != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Notification done sucessfully"),
          duration: Duration(seconds: 1),
        ),
      );
    }
  }

  DateTime pressedtime = DateTime.now();

  exitsnackbar() {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        duration: Duration(seconds: 2),
        backgroundColor: Color.fromARGB(255, 66, 66, 66),
        content: Text(" Press back again to exit ")));
  }

  _showReset(BuildContext context) {
    showDialog(
        context: context,
        builder: ((context) {
          return AlertDialog(
            title: const Text(
              "This will earase all your data from your phone storage permentaly.So please make sure that it is okay from you clear all your transaction data and can't never backup.",
              style: TextStyle(fontSize: 16, fontFamily: 'RobotoMono'),
            ),
            actions: [
              TextButton(
                  onPressed: () async {
                    TransactionDb().clearTransaction();
                    CategoryDB().clearCategory();
                    final sharedPreferences =
                        await SharedPreferences.getInstance();
                    sharedPreferences.clear();
                    // ignore: use_build_context_synchronously
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) => const SplashScreen()),
                        (route) => false);
                  },
                  child: const Text("Processed")),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("cancel")),
            ],
          );
        }));
  }
}
