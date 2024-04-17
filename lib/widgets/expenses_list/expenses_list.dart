import 'package:expense_tracker/widgets/expenses.dart';
import 'package:expense_tracker/widgets/expenses_list/expense_item.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';

class ExpensesList extends StatelessWidget{
  ExpensesList({super.key, required this.expenses, required this.onRemoveExpense});

  final void Function(Expense expense) onRemoveExpense;
  final List<Expense> expenses;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
     itemBuilder: (ctx,index)=>Dismissible(
      key: ValueKey(expenses[index]), 
      background: Container(
        decoration: BoxDecoration(color: Theme.of(context).colorScheme.error.withOpacity(0.75),
        borderRadius: BorderRadius.circular(10),),
      margin: EdgeInsets.symmetric(
        horizontal: Theme.of(context).cardTheme.margin!.horizontal,
        vertical: Theme.of(context).cardTheme.margin!.vertical,
      ),
      child: const Icon(Icons.delete,
      color: Colors.white,),),
      onDismissed: (direction){
        onRemoveExpense(expenses[index]);
      },
      child: ExpenseItem(expenses[index])
      ) 
    );
  }
}