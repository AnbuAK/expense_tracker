import 'dart:math';

import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/new_expenses.dart';

class Expenses extends StatefulWidget{
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses>{
  final List<Expense> _registeredExpenses = [
  ];

void _openAddExpenseOverlay () {
  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
   builder: (ctx) => NewExpense(onAddExpense: _addExpenses),
  );
}

void _addExpenses(Expense expense){
  setState(() {
    _registeredExpenses.add(expense);
  });
}

void _removeExpenses(Expense expense){
  final expenseIndex = _registeredExpenses.indexOf(expense);
  setState(() {
    _registeredExpenses.remove(expense);
  }
  );
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text('Expense Deleted'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: (){
            setState(() {
              _registeredExpenses.insert(expenseIndex, expense);
            });
          },
        ),
        )
  );
}

@override
  Widget build(BuildContext context) {

    Widget mainContent = const Center(child:Text('No Expense found, kindly add some'));

    if (_registeredExpenses.isNotEmpty){
      mainContent = ExpensesList(expenses: _registeredExpenses, onRemoveExpense: _removeExpenses,);

    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Expenses'),
        actions: [
          IconButton(onPressed:_openAddExpenseOverlay,
           icon: const Icon(Icons.add))
        ]),
      body: Column(children: [

        Expanded(child: mainContent,),  
      ]),
    );
  }

}