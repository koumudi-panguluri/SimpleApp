import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import './models/transcation.dart';

class NewTransaction extends StatefulWidget {
  final _addTransaction;
  final Transaction transactionData;
  final String id;
  NewTransaction(this._addTransaction, this.transactionData, this.id);
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  var titleController = TextEditingController();
  var amountController = TextEditingController();
  DateTime dateChoosed;
  var isLoading = false;
  void _submitFields() {
    final String textField = titleController.text;
    final double amountField = double.parse(amountController.text);
    if (textField.isEmpty || amountField <= 0 || dateChoosed == null) {
      return;
    }
    print("index ${widget.id}");
    setState(() {
      this.isLoading = true;
    });
    widget
        ._addTransaction(textField, amountField, dateChoosed, widget.id)
        .catchError((error) {
      showDialog(
          context: context,
          child: new AlertDialog(
            title: Text("Something went Wrong"),
            actions: <Widget>[
              Container(
                child: FlatButton(
                    onPressed: Navigator.of(context).pop,
                    child: Text(
                      "Cancel",
                      style: TextStyle(color: Colors.red),
                    )),
              )
            ],
          ));
    }).then((_) {
      setState(() {
        this.isLoading = false;
      });
      print("popped");
      Navigator.of(context).pop();
    });

    // if (widget.transactionData != null) {
    //   print('title: ${widget.transactionData.title}');
    // }
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
  void initState() {
    super.initState();
    if (widget.transactionData != null) {
      titleController =
          TextEditingController(text: widget.transactionData.title);
      amountController =
          TextEditingController(text: widget.transactionData.price.toString());
    } else {
      titleController = TextEditingController();
      amountController = TextEditingController();
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading == true
        ? Center(child: CircularProgressIndicator())
        : Card(
            color: Colors.blueGrey[50],
            elevation: 15,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
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
