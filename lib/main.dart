import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:money_management_app1/model/category_model/category_model.dart';
import 'package:money_management_app1/model/transaction_model/transaction_model.dart';
import 'package:money_management_app1/view_model/category_db.dart/category_db.dart';
import 'package:money_management_app1/components/splash_screen.dart';
import 'package:money_management_app1/view_model/transation_db/transation_db.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:timezone/data/latest.dart' as tz;
// ignore: depend_on_referenced_packages
import 'package:flutter_localizations/flutter_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  tz.initializeTimeZones();

  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  );

  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(CategoryModelAdapter().typeId)) {
    Hive.registerAdapter(CategoryModelAdapter());
  }

  if (!Hive.isAdapterRegistered(CategoryTypeAdapter().typeId)) {
    Hive.registerAdapter(CategoryTypeAdapter());
  }

  if (!Hive.isAdapterRegistered(TransactionModelAdapter().typeId)) {
    Hive.registerAdapter(TransactionModelAdapter());
  }

  TransactionDb().refresh;
  CategoryDB.instance.refreshUi();

  runApp(const MyApp());
}

const String sharedName = 'say';
const String sharedCheck = 'check';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

 

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      localizationsDelegates: [
        GlobalWidgetsLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        MonthYearPickerLocalizations.delegate,
      ],
      debugShowCheckedModeBanner: false,
      title: 'Money Manager App',
      home: SplashScreen(),
    );
  }
}
