import 'package:hive/hive.dart';
import 'package:money_management_app1/model/category_model/category_model.dart';


part 'transaction_model.g.dart';

@HiveType(typeId: 3)
class TransactionModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final double amount;
  @HiveField(3)
  final CategoryType type;
  @HiveField(4)
  final String? note;
  @HiveField(5)
  final CategoryModel category;
  @HiveField(6)
  final DateTime date;

  TransactionModel({
    required this.id,
    required this.date,
    required this.amount,
    required this.type,
    required this.category,
    this.note,
  });
}
