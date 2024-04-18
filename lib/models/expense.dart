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

class ExpenseBucket{
  ExpenseBucket({
    required this.category,
    required this.expenses,
  });
  
  ExpenseBucket.forCategory(List<Expense> allExpenses, 
  this.category) 
  : expenses = allExpenses 
  .where((expense) => expense.category == category).toList();

  final Category category;
  final List<Expense> expenses;

  double get totalExpenses{
    double sum = 0;

     for (final expense in expenses){
      sum += expense.amount;
     }
     return sum;
  }
}

class ExpenseTracker {
  
  Map<Category, double> categoryExpenses = {
    Category.food: 0,
    Category.entertainment: 0,
    Category.travel: 0,
    Category.bills: 0,
  };

  void addExpense(Expense expense) {
    if (categoryExpenses.containsKey(expense.category)) {
      categoryExpenses[expense.category] = (categoryExpenses[expense.category] ?? 0) + expense.amount;
    } else {
      print('Category ${expense.category} not found in categoryExpenses map.');
    }
  }

  void removeExpense(Expense expense) {
    if (categoryExpenses.containsKey(expense.category)) {
      categoryExpenses[expense.category] = (categoryExpenses[expense.category] ?? 0) - expense.amount;
    } else {
      print('Category ${expense.category} not found in categoryExpenses map.');
    }
  }
}
