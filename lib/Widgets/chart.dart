import 'package:budget_planner/Model/transaction.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'chart_bar.dart';

class Chart extends StatelessWidget {
  Chart(this._recentTransaction);

  final List<Transaction> _recentTransaction;

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      var totalSum = 0.0;
      for (var i = 0; i < _recentTransaction.length; i++) {
        if (_recentTransaction[i].date.day == weekDay.day &&
            _recentTransaction[i].date.month == weekDay.month &&
            _recentTransaction[i].date.year == weekDay.year) {
          totalSum += _recentTransaction[i].amount;
        }
      }
      print("$weekDay - $totalSum");
      return {'day': DateFormat.E().format(weekDay), 'amount': totalSum};
    });
  }

  double get _totalSpending {
    return _recentTransaction.fold(0.0, (sum, item) {
      return sum + item.amount;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: groupedTransactionValues.map((e) {
              var amount = double.parse(e['amount'].toString());
              double prc = amount == 0 ? 0 : amount / _totalSpending;
              return Flexible(
                  fit: FlexFit.tight,
                  child: ChartBar(e['day'].toString(), amount, prc));
            }).toList()),
      ),
    );
  }
}
