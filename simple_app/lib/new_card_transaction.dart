import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function _addTransaction;
  NewTransaction(this._addTransaction);
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime dateChoosed;
  void _submitFields() {
    final String textField = titleController.text;
    final double amountField = double.parse(amountController.text);
    if (textField.isEmpty || amountField <= 0 || dateChoosed == null) {
      return;
    }
    widget._addTransaction(textField, amountField, dateChoosed);
    Navigator.of(context).pop();
  }

  void _selectedDate() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime.now())
        .then((date) {
      if (date == null) {
        return;
      }
      setState(() {
        dateChoosed = date;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Colors.blueGrey[50],
        elevation: 15,
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
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
            padding: EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  dateChoosed == null
                      ? 'No Date Choosen!'
                      : DateFormat.yMMMd().format(dateChoosed),
                  style: TextStyle(color: Colors.black54),
                ),
                FlatButton(
                    // padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                    child: Text(
                      'Choose Date',
                      style: TextStyle(color: Colors.blue),
                    ),
                    onPressed: _selectedDate)
              ],
            ),
          ),
          Container(
              padding: EdgeInsets.all(10),
              child: RaisedButton(
                  color: Colors.blue[100],
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
