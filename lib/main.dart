import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'Model/theme_data_model.dart';
import 'Widgets/chart.dart';
import 'Widgets/new_transation.dart';
import 'Model/dummy_data.dart';
import 'Model/transaction.dart';
import 'Widgets/transaction_list.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoApp(
        title: 'Flutter Demo',
        theme: ThemeDataModel.cupertinoThemeData(),
        home: MyHomePage(title: 'Budget Planner'),
      );
    }

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeDataModel.androidThemeData(),
      home: MyHomePage(title: 'Budget Planner'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = DummyData.getDummyTransactionList(10);

  List<Transaction> get _recentTransactions {
    return _transactions.where((tr) {
      return tr.date.isAfter(DateTime.now().subtract(const Duration(days: 7)));
    }).toList();
  }

  double get _appHeight {
    return MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        56; //56 is the default height of the appbar
  }

  void _startAddNewTransaction(BuildContext ctx) {
    if (Platform.isIOS) {
      showCupertinoModalPopup(
          context: ctx,
          builder: (_) {
            return NewTransaction(_addNewTransaction);
          });
      return;
    }

    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return NewTransaction(_addNewTransaction);
        });
  }

  void _addNewTransaction(
      String txTitle, double txAmount, DateTime selectedDateTime) {
    final newTx = Transaction(
        id: DateTime.now().toString(),
        title: txTitle,
        amount: txAmount,
        date: selectedDateTime);

    setState(() {
      _transactions.add(newTx);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _transactions.removeWhere((element) => element.id == id);
    });
  }

  Widget _buildBody() {
    if (Platform.isIOS) {
      return _buildCuppertinoScaffold();
    }

    return _buildMaterialScaffold();
  }

  Widget get _body {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: _appHeight * 0.3, child: Chart(_recentTransactions)),
        SizedBox(
            height: _appHeight * 0.67,
            child: TransactionList(_transactions, _deleteTransaction))
      ],
    );
  }

  Widget _buildCuppertinoScaffold() {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(widget.title),
        trailing: CupertinoButton(
            onPressed: () => _startAddNewTransaction(context),
            child: const Icon(
              CupertinoIcons.add,
              size: 30,
            )),
      ),
      child: SafeArea(child: _body),
    );
  }

  Widget _buildMaterialScaffold() {
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        actions: [
          IconButton(
              onPressed: () => _startAddNewTransaction(context),
              icon: const Icon(Icons.add))
        ],
        title: Text(widget.title),
      ),
      body: _body,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _startAddNewTransaction(context),
        tooltip: 'Add New',
        child: const Icon(Icons.add),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }
}
