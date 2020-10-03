import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './models/transcation.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactionsList;
  final Function deleteTx;
  TransactionList(this.transactionsList, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return Column(
        children: transactionsList.map((tx) {
      return Card(
        child: Row(children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            // decoration: BoxDecoration(
            //     color: Colors.white60,
            //     border:
            //         Border.all(color: Colors.white, style: BorderStyle.solid),
            //     borderRadius: BorderRadius.circular(50)),
            child: CircleAvatar(
              radius: 30,
              backgroundColor: Colors.white60,
              foregroundColor: Colors.black,
              child: Container(
                padding: EdgeInsets.all(6),
                child: FittedBox(
                  child: Text(
                    '${tx.currency} ${tx.price.toStringAsFixed(2)}',
                    style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
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
          Container(
            child: Expanded(
              child: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  deleteTx(tx);
                },
                color: Colors.black87,
              ),
            ),
          )
        ]),
        elevation: 10,
        color: Color(tx.color),
      );
    }).toList());
  }
}
