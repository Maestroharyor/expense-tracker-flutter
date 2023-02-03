import 'package:expensetracker/models/transaction.dart';
import 'package:expensetracker/widgets/chart.dart';
import 'package:expensetracker/widgets/new_transaction.dart';
import 'package:expensetracker/widgets/transaction_list.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Tracker',
      theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.amber,
          fontFamily: 'Quicksand',
          appBarTheme: AppBarTheme(
              textTheme: ThemeData.light().textTheme.copyWith(
                  titleLarge:
                      TextStyle(fontFamily: "OpenSans", fontSize: 20)))),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [];

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((element) {
      return element.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _addNewTransaction(String title, double amount) {
    final newTransaction = Transaction(
        id: DateTime.now().toString(),
        title: title,
        amount: amount,
        date: DateTime.now());

    setState(() {
      _userTransactions.add(newTransaction);
    });
    Navigator.of(context).pop();
  }

  void _removeATransaction(String title) {
    final newTransaction =
        _userTransactions.where((item) => item.title != title).toList();
    print(newTransaction);
    setState(() {
      _userTransactions:
      newTransaction;
    });
  }

  void startAddNewTransactions(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return NewTransaction(addNewTransaction: _addNewTransaction);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Expense Tracker',
          ),
          centerTitle: false,
          actions: [
            IconButton(
                onPressed: () {
                  startAddNewTransactions(context);
                },
                icon: Icon(Icons.add))
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            startAddNewTransactions(context);
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Chart(
              recentTransactions: _recentTransactions,
            ),
            TransactionList(
              transactions: _userTransactions,
              removeATransaction: _removeATransaction,
            )
            // UserTransaction(
            //   addNewUserTransaction: _addNewTransaction,
            //   transactionsList: _userTransactions,
            // )
          ],
        ));
  }
}
