import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './transcation.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final List<Transaction> transactions = [
    Transaction(
        title: 'First Expense',
        id: 1,
        price: 10,
        currency: '\$',
        date: DateTime.now(),
        color: 0xff81D4FA),
    Transaction(
        title: 'Second Expense',
        id: 2,
        price: 20,
        currency: '\$',
        date: DateTime.now(),
        color: 0xff9FA8DA)
  ];
  // String titleInput;
  // String amountInput;
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Koumi App'),
        ),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                child: Card(
                  child: Text('Main Card'),
                  elevation: 10,
                ),
              ),
              Column(
                  children: transactions.map((tx) {
                return Card(
                  child: Row(children: [
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.white, style: BorderStyle.solid)),
                      child: Text(
                        tx.price.toString() + tx.currency,
                        style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold),
                      ),
                      padding: EdgeInsets.all(15),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.all(5),
                          child: Text(
                            'Name : ' + tx.title,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                            padding: EdgeInsets.all(5),
                            child: Text(
                                'Date : ' + DateFormat.yMMMd().format(tx.date),
                                style: TextStyle(color: Colors.black54))),
                      ],
                    )
                  ]),
                  elevation: 10,
                  color: Color(tx.color),
                );
              }).toList()),
              Card(
                  color: Colors.blueGrey[50],
                  elevation: 15,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
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
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(15),
                          child: TextField(
                            decoration: InputDecoration(labelText: 'Amount'),
                            controller: amountController,
                          ),
                        ),
                        Container(
                            child: FlatButton(
                                child: Text(
                                  'Add Transaction',
                                  style: TextStyle(color: Colors.blueAccent),
                                ),
                                onPressed: () {
                                  print(titleController.text);
                                  print(amountController.text);
                                })),
                      ])),
            ]),
      ),
    );
  }
}
