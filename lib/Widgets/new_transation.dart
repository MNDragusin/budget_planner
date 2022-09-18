import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  NewTransaction(this._addTx, {Key? key}) : super(key: key);

  final Function _addTx;

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _currentSelectedDateTime;

  void _submitData() {
    final enteredTitle = _titleController.text;
    final enteredAmount = double.tryParse(_amountController.text);

    if (enteredTitle.isEmpty || enteredAmount == null || enteredAmount <= 0) {
      return;
    }

    _currentSelectedDateTime ??= DateTime.now();

    widget._addTx(enteredTitle, enteredAmount, _currentSelectedDateTime);
    Navigator.of(context).pop();
  }

  void _showDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime.now())
        .then((selectedDateTime) {
      if (selectedDateTime == null) {
        return;
      }

      setState(() {
        _currentSelectedDateTime = selectedDateTime;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.only(
            left: 10,
            top: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: const InputDecoration(labelText: "Title"),
              keyboardType: TextInputType.text,
              onSubmitted: (_) => _submitData(),
              controller: _titleController,
            ),
            TextField(
              decoration: const InputDecoration(labelText: "Amount"),
              keyboardType: TextInputType.number,
              controller: _amountController,
              onSubmitted: (_) => _submitData(),
            ),
            Container(
              height: 60,
              child: Row(
                children: [
                  Text(_currentSelectedDateTime == null
                      ? "No date selected"
                      : DateFormat.yMd().format(_currentSelectedDateTime!)),
                  TextButton(
                      onPressed: _showDatePicker,
                      child: Text(
                        "Select a date",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ))
                ],
              ),
            ),
            ElevatedButton(
                onPressed: _submitData, child: const Text("Add transaction"))
          ],
        ),
      ),
    );
  }
}
