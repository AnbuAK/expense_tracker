import 'dart:math';
import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/new_expenses.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [];
  final ExpenseTracker expenseTracker = ExpenseTracker();
  

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(onAddExpense: _addExpenses),
    );
  }

  void _addExpenses(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _removeExpenses(Expense expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(seconds: 3),
      content: const Text('Expense Deleted'),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () {
          setState(() {
            _registeredExpenses.insert(expenseIndex, expense);
          });
        },
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    List<PieChartSectionData> sections = [];
    Widget mainContent =
        const Center(child: Text('No Expense found, kindly add some'));

    sections = expenseTracker.categoryExpenses.entries
        .map((entry) => PieChartSectionData(
              value: entry.value,
              title: '${entry.key.toString().split('.').last}',
              color: _getColorForCategory(entry.key),
              badgeWidget: Icon(
                _getIconForCategory(entry.key),
                size: 20,
                color: Colors.white,
              ),
            ))
        .toList();

    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _registeredExpenses,
        onRemoveExpense: _removeExpenses,
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('My Expenses'), actions: [
        IconButton(
            onPressed: _openAddExpenseOverlay, icon: const Icon(Icons.add))
      ]),
      body: Column(children: [
        // Container(
        //   height:300,
        //   child: Center(child: PieChart(
        //     PieChartData(sections: sections),
        //   ),)
        //   ),
        Expanded(
          child: mainContent,
        ),
      ]),
    );
  }
  Color _getColorForCategory(Category category) {
    switch (category) {
      case Category.food:
        return Color.fromARGB(255, 239, 130, 122);
      case Category.entertainment:
        return Color.fromARGB(255, 100, 171, 229);
      case Category.travel:
        return Color.fromARGB(255, 155, 249, 158);
      case Category.bills:
        return Color.fromARGB(255, 237, 224, 101);
      default:
        return Colors.grey; // Default color
    }
  }
  IconData _getIconForCategory(Category category) {
  switch (category) {
    case Category.food:
      return Icons.fastfood;
    case Category.entertainment:
      return Icons.movie;
    case Category.travel:
      return Icons.directions_car;
    case Category.bills:
      return Icons.receipt;
    default:
      return Icons.error; // Default icon
  }
}
}
