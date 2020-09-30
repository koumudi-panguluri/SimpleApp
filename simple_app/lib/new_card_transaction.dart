import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  final Function _addTransaction;
  NewTransaction(this._addTransaction);
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  void _submitFields() {
    final String textField = titleController.text;
    final double amountField = double.parse(amountController.text);
    if (textField.isEmpty || amountField <= 0) {
      return;
    }
    widget._addTransaction(textField, amountField);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Colors.blueGrey[50],
        elevation: 15,
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Container(
              padding: EdgeInsets.all(15),
              child: Text(
                'Enter the Expenses',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54),
                textAlign: TextAlign.center,
              )),
          Container(
            padding: EdgeInsets.all(15),
            child: TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: titleController,
              onSubmitted: (_) => _submitFields(),
            ),
          ),
          Container(
            padding: EdgeInsets.all(15),
            child: TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => _submitFields(),
            ),
          ),
          Container(
              child: FlatButton(
                  child: Text(
                    'Add Transaction',
                    style: TextStyle(color: Colors.blueAccent),
                  ),
                  onPressed: () {
                    _submitFields();
                    print(titleController.text);
                    print(amountController.text);
                  })),
        ]));
  }
}
