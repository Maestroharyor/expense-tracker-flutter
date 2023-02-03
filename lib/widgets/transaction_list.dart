import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function removeATransaction;
  const TransactionList(
      {super.key,
      required this.transactions,
      required this.removeATransaction});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Container(
        height: 500,
        child: transactions.isEmpty
            ? Column(
                children: [
                  Text("No Transactions Added Yet..."),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 200,
                    child: Image.asset(
                      "assets/images/waiting.png",
                      fit: BoxFit.cover,
                    ),
                  )
                ],
              )
            : ListView.builder(
                itemBuilder: (ctx, index) {
                  return Card(
                    elevation: 5,
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: FittedBox(
                            child: Text(
                              '\$${transactions[index].amount.toStringAsFixed(2)}',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                      title: Text(
                        transactions[index].title,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        DateFormat.yMMMd().format(transactions[index].date),
                        style: TextStyle(color: Colors.grey),
                      ),
                      trailing: IconButton(
                          onPressed: () {
                            removeATransaction(transactions[index].id);
                          },
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red,
                          )),
                    ),
                    // // child: Container(
                    //   padding: EdgeInsets.all(10),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: [
                    //       Row(
                    //         children: [
                    //           Container(
                    //             child: Text(
                    //               '\$${transactions[index].amount.toStringAsFixed(2)}',
                    //               style: TextStyle(
                    //                   color: Colors.white,
                    //                   fontWeight: FontWeight.bold,
                    //                   fontSize: 20),
                    //             ),
                    //             padding: EdgeInsets.all(20),
                    //             color: Theme.of(context).primaryColor,
                    //           ),
                    //           SizedBox(
                    //             width: 20,
                    //           ),
                    //           Column(
                    //             crossAxisAlignment: CrossAxisAlignment.start,
                    //             children: [
                    //               Text(
                    //                 transactions[index].title,
                    //                 style: TextStyle(
                    //                     fontSize: 20,
                    //                     fontWeight: FontWeight.bold),
                    //               ),
                    //               SizedBox(
                    //                 height: 6,
                    //               ),
                    //               Text(
                    //                 DateFormat.yMMMd()
                    //                     .format(transactions[index].date),
                    //                 style: TextStyle(color: Colors.grey),
                    //               ),
                    //             ],
                    //           ),
                    //         ],
                    //       ),
                    //       IconButton(
                    //           onPressed: () {
                    //             removeATransaction(transactions[index].title);
                    //           },
                    //           icon: Icon(
                    //             Icons.delete,
                    //             color: Colors.red,
                    //           ))
                    //     ],
                    //   ),
                    // ),
                  );
                },
                itemCount: transactions.length,
                // children: transactions
                //     .map((tx) =>
                //    )
                //     .toList(),
              ),
      ),
    );
  }
}
