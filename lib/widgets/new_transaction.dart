import 'dart:ffi';

import 'package:expensetracker/models/transaction.dart';
import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  final Function addNewTransaction;

  NewTransaction({super.key, required this.addNewTransaction});

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  void _handleSubmit() {
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0) {
      return;
    }
    widget.addNewTransaction(enteredTitle, enteredAmount);
  }

  void _presentDatePicker() {
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2022),
        lastDate: DateTime.now());
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
                children: [
                  Text("No Date Chosen"),
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
