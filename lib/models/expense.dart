import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();

const uuid=Uuid();

enum Category {food, entertainment, travel, bills }

const categoryIcons ={
  Category.food: Icons.lunch_dining,
  Category.entertainment: Icons.movie,
  Category.travel: Icons.train,
  Category.bills: Icons.receipt,
};

class Expense{
  Expense({required this.amount,
   required this.date,
    required this.title,
    required this.category}
    ) : id = uuid.v4();

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;


  String get formattedDate{
    return formatter.format(date);
  }
}