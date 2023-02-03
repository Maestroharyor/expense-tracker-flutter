import 'package:expensetracker/models/transaction.dart';
import 'package:expensetracker/widgets/chart_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;
  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      var totalSum = 0.00;

      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalSum += recentTransactions[i].amount;
        }
      }

      return {
        "day": DateFormat.E().format(weekDay).substring(0, 1),
        "amount": totalSum
      };
    }).reversed.toList();
  }

  double get totalTransactions {
    return groupedTransactionValues.fold(
        0.00,
        (previousValue, element) =>
            previousValue + (element['amount'] as double));
  }

  const Chart({super.key, required this.recentTransactions});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.all(20),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionValues
              .map((data) => Flexible(
                        fit: FlexFit.tight,
                        child: ChartBar(
                            label: '${data['day']}',
                            spendingAmount: (data['amount'] as double),
                            spendingPercent: totalTransactions == 0.0
                                ? 0.0
                                : (data['amount'] as double) /
                                    totalTransactions),
                      )
                  // Text('${data['day']} : ${data['amount']}')
                  )
              .toList(),
        ),
      ),
    );
  }
}
