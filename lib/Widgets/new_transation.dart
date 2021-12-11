import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  NewTransaction(this._addTx, {Key? key}) : super(key: key);

  final Function _addTx;
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  void _submitData() {
    final enteredTitle = titleController.text;
    final enteredAmount = double.tryParse(amountController.text);

    if (enteredTitle.isEmpty || enteredAmount == null || enteredAmount <= 0) {
      return;
    }

    _addTx(enteredTitle, enteredAmount);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: const InputDecoration(labelText: "Title"),
              keyboardType: TextInputType.text,
              onSubmitted: (_) => _submitData(),
              controller: titleController,
            ),
            TextField(
              decoration: const InputDecoration(labelText: "Amount"),
              keyboardType: TextInputType.number,
              controller: amountController,
              onSubmitted: (_) => _submitData(),
            ),
            TextButton(
                onPressed: _submitData, child: const Text("Add transaction"))
          ],
        ),
      ),
    );
  }
}
