import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:budget_planner/Model/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _transactions;
  final Function _delTx;

  TransactionList(this._transactions, this._delTx);

  @override
  Widget build(BuildContext context) {
    return _transactions.isEmpty
        ? Image.asset(
            "Assets/Images/waiting.png",
            fit: BoxFit.fitHeight,
          )
        : ListView.builder(
            itemBuilder: (ctx, index) {
              return Card(
                key: ValueKey(_transactions[index].id),
                elevation: 5,
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: FittedBox(
                          child: Text(_transactions[index].amount.toString())),
                    ),
                  ),
                  title: Text(
                    _transactions[index].title,
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  subtitle: Text(
                      DateFormat.yMMMEd().format(_transactions[index].date),
                      style: Theme.of(context).textTheme.subtitle1),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    color: Theme.of(context).colorScheme.error,
                    onPressed: () => _delTx(_transactions[index].id),
                  ),
                ),
              );
            },
            itemCount: _transactions.length,
          );
  }
}
