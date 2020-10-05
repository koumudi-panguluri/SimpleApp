import 'package:flutter/material.dart';
import 'package:simple_app/new_card_transaction.dart';
import './models/transcation.dart';
import './transaction_list.dart';
import './chart.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Koumi App",
      home: MyHomeApp(),
    );
  }
}

class MyHomeApp extends StatefulWidget {
  @override
  _MyHomeAppState createState() => _MyHomeAppState();
}

class _MyHomeAppState extends State<MyHomeApp> {
  // String titleInput;
  // String amountInput;
  static final List<int> colors = [
    0xff81D4FA,
    0xff9FA8DA,
    0xffED89B1,
    0xffD96B6B,
    0xffD96BBB,
  ];
  int colorCount = 0;
  final List<Transaction> _transactions = [
    // Transaction(
    //     title: 'First Expense',
    //     id: 1,
    //     price: 10,
    //     currency: '\$',
    //     date: DateTime.now(),
    //     color: 0xff81D4FA),
    // Transaction(
    //     title: 'Second Expense',
    //     id: 2,
    //     price: 20,
    //     currency: '\$',
    //     date: DateTime.now(),
    //     color: 0xff9FA8DA)
  ];

  void _addNewTransaction(
      String name, double amount, DateTime date, int index) {
    final newTx = Transaction(
        title: name,
        id: DateTime.now().toString(),
        price: amount,
        currency: '\$',
        date: date,
        color: colors[colorCount]);
    setState(() {
      // index = _transactions.indexOf(newTx);
      print("index $index length ${_transactions.length}");
      if (index == null || index < 0) {
        _transactions.add(newTx);
      } else {
        _transactions.insert(index, newTx);
        _transactions.removeAt(index + 1);
      }
      colorCount++;
      if (colorCount > 4) {
        colorCount = 0;
      }
    });
  }

  void _deleteTransaction(deleteTxId) {
    setState(() {
      _transactions.remove(deleteTxId);
    });
  }

  void onAddCard({BuildContext ctx, transactionData, index}) {
    showModalBottomSheet(
        context: ctx,
        builder: (builderCtx) {
          return GestureDetector(
            onTap: () {},
            behavior: HitTestBehavior.opaque,
            child: NewTransaction(_addNewTransaction, transactionData, index),
          );
        });
  }

  // sending only last week transaction information
  List<Transaction> get _recentTransactionsByWeek {
    final date = DateTime.now().subtract(Duration(days: 7));
    return _transactions.where((tx) {
      return tx.date.isAfter(date);
    }).toList();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Koumi App'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.add), onPressed: () => onAddCard(ctx: context))
        ],
      ),
      body: _transactions.isEmpty
          ? Container(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      "No Data Found Yet..! :)",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    )
                    // Image.asset(
                    //   'assets/noData.jpg',
                    //   fit: BoxFit.cover,
                    // )
                  ]),
            )
          : SingleChildScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Chart(_recentTransactionsByWeek),
                    // Container(
                    //   child: Card(
                    //     child: Text('Main Card'),
                    //     elevation: 10,
                    //   ),
                    // ),
                    //
                    TransactionList(
                        _transactions, _deleteTransaction, onAddCard),
                  ]),
            ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => onAddCard(ctx: context),
        backgroundColor: Colors.deepOrangeAccent[200],
      ),
    );
  }
}
