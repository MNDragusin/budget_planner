import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:budget_planner/Model/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _transactions;

  TransactionList(this._transactions);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 530,
      child: _transactions.isEmpty
          ? Image.asset(
              "Assets/Images/waiting.png",
              fit: BoxFit.fitHeight,
            )
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return Card(
                  elevation: 5,
                  child: Row(
                    children: [
                      Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            border: Border.all(
                          color: Theme.of(context).primaryColor,
                          width: 2,
                        )),
                        child: Text(
                          "${_transactions[index].amount.toStringAsFixed(2)} RON",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Theme.of(context).primaryColor),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _transactions[index].title,
                            style: const TextStyle(fontSize: 18),
                          ),
                          Text(
                            DateFormat("EEE, d/M/y - H:m")
                                .format(_transactions[index].date),
                            style: const TextStyle(color: Colors.grey),
                          )
                        ],
                      )
                    ],
                  ),
                );
              },
              itemCount: _transactions.length,
            ),
    );
  }
}
