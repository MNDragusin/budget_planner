import 'package:budget_planner/Model/transaction.dart';

class DummyData {
  static List<Transaction> getDummyTransactionList(int count) {
    List<Transaction> transactions = List.generate(count, (index) {
      return Transaction(
          id: "$index",
          title: "Title_$index",
          amount: (10 + index).toDouble(),
          date: DateTime.now());
    });
    return transactions;
  }
}
