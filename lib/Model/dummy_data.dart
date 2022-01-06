import 'dart:math';

import 'package:budget_planner/Model/transaction.dart';

class DummyData {
  static final _random = new Random();
  static int _getRandomInt(int start, int end) {
    return start + _random.nextInt(end);
  }

  static List<Transaction> getDummyTransactionList(int count) {
    List<Transaction> transactions = List.generate(count, (index) {
      return Transaction(
          id: "$index",
          title: "Title_$index",
          amount: (10 + index).toDouble(),
          date: DateTime.now().subtract(Duration(days: _getRandomInt(0, 7))));
    });
    return transactions;
  }
}
