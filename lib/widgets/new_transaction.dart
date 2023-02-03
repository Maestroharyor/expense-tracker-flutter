import 'dart:ffi';

import 'package:expensetracker/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addNewTransaction;

  NewTransaction({super.key, required this.addNewTransaction});

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime _selectedDate = DateTime.utc(1, 1, 2);

  void _handleSubmit() {
    if (amountController.text.isEmpty) {
      return;
    }
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);

    if (enteredTitle.isEmpty ||
        enteredAmount <= 0 ||
        _selectedDate == DateTime.utc(1, 1, 2)) {
      return;
    }
    widget.addNewTransaction(enteredTitle, enteredAmount, _selectedDate);
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2022),
            lastDate: DateTime.now())
        .then((value) => {
              // print(value),
              // print(value == DateTime.utc(1, 1, 1))

              if (value != null)
                {
                  setState(
                    () {
                      _selectedDate = value;
                    },
                  )
                }
            });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: InputDecoration(labelText: "Title"),
              keyboardType: TextInputType.name,
              onSubmitted: (_) => _handleSubmit(),
              controller: titleController,
            ),
            TextField(
              decoration: InputDecoration(labelText: "Amount"),
              keyboardType: TextInputType.number,
              onSubmitted: (_) => _handleSubmit(),
              controller: amountController,
            ),
            Container(
              height: 70,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(_selectedDate == DateTime.utc(1, 1, 2)
                      ? "No Date Chosen"
                      : 'Selected Date: ${DateFormat.yMd().format(_selectedDate)}'),
                  SizedBox(
                    width: 8,
                  ),
                  TextButton(
                      onPressed: () {
                        _presentDatePicker();
                      },
                      child: Text(
                        "Choose Date",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ))
                ],
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  _handleSubmit();
                },
                child: Text("Add transaction"))
          ],
        ),
      ),
    );
  }
}
