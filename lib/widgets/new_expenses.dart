import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:date_field/date_field.dart';
import 'package:expense_tracker/models/expense.dart';

class NewExpense extends StatefulWidget{
  const NewExpense({super.key, required this.onAddExpense});

  final void Function (Expense expense)  onAddExpense;

  @override
  State<StatefulWidget> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense>{

  final _titleController = TextEditingController();
  final _amountController =  TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.entertainment;

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    
    final pickedDate = await showDatePicker(
      context: context, 
      initialDate: now, 
      firstDate: firstDate, 
      lastDate: now);
      setState(() {
        _selectedDate = pickedDate;
      });
    
  }

  void _submitexpensedata(){
    final enteredAmount = double.tryParse(_amountController.text);
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;
    if (_titleController.text.trim().isEmpty || amountIsInvalid || _selectedDate == null ) {
      showDialog(context: context, builder: (ctx) => AlertDialog(
        title: const Text('Invalid input'),
        content: const Text('Please make sure a valid title, amount, date and category was entered'),
        actions: [
          TextButton(onPressed: (){
            Navigator.pop(ctx);
          }, 
          child: const Text('Okay'))
          ],
        )
      );
      return;
    }
  widget.onAddExpense(Expense
  (amount: enteredAmount, 
  date: _selectedDate!, 
  title: _titleController.text, 
  category: _selectedCategory),
  );
  Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16,50,16,16),
      child: Column(
        children: [
          TextField( 
            controller: _titleController,
            maxLength: 50,
            decoration: const InputDecoration(
              label: Text('Title'),
              ),
          ),
              Row(
                children: [
                    Expanded(
                      child: TextField(
                        controller: _amountController,
                        keyboardType: TextInputType.number,
                        maxLength: 10,
                        decoration: const InputDecoration(
                          prefixText: '\₹ ',
                          labelText: 'Amount',
                        ),
                      ),
                    ),
                    const SizedBox(width: 30,),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(_selectedDate== null? 'Select a date' : formatter.format(_selectedDate!)),
                          IconButton(onPressed: _presentDatePicker,
                          icon:const Icon(Icons.calendar_month))
                        ],
                      ),
                    ),
                  ],
                ),
          const SizedBox(height: 10,),
          Row(
            children: [
            DropdownButton(
              value: _selectedCategory,
              items: Category.values
              .map(
              (category) => DropdownMenuItem(
                value: category,
                child: Text(
                  category.name.toString(),
                  ),
                ),
              ).toList(),
             onChanged: (value){
              if (value == null ){
                return;
              }
              setState(() {
                _selectedCategory = value;
              });
             }),
            const Spacer(),
            TextButton(onPressed: (){
              Navigator.pop(context);
            }, child: const Text('Clear')),
            const SizedBox(width: 8,),
            ElevatedButton(onPressed: _submitexpensedata,
            child: const Text ('Save Expense'))
          ],),
          
        ]
      ),
    );
  }
}