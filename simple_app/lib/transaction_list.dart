import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './models/transcation.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactionsList;
  TransactionList(this.transactionsList);

  @override
  Widget build(BuildContext context) {
    return Column(
        children: transactionsList.map((tx) {
      return Card(
        child: Row(children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            decoration: BoxDecoration(
                border:
                    Border.all(color: Colors.white, style: BorderStyle.solid)),
            child: Text(
              tx.price.toStringAsFixed(2) + tx.currency,
              style: TextStyle(
                  fontStyle: FontStyle.italic, fontWeight: FontWeight.bold),
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
                  child: Text('Date : ' + DateFormat.yMMMd().format(tx.date),
                      style: TextStyle(color: Colors.black54))),
            ],
          ),
        ]),
        elevation: 10,
        color: Color(tx.color),
      );
    }).toList());
  }
}
