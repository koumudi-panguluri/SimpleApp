import 'package:flutter/material.dart';
import 'package:simple_app/new_card_transaction.dart';
import './models/transcation.dart';
import './transaction_list.dart';

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
    0xffED89B1,
    0xffD96B6B,
    0xffD96BBB,
    0xff81D4FA,
    0xff9FA8DA,
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

  void _addNewTransaction(String name, double amount) {
    final newTx = Transaction(
        title: name,
        id: 3,
        price: amount,
        currency: '\$',
        date: DateTime.now(),
        color: colors[colorCount]);
    setState(() {
      _transactions.add(newTx);
      colorCount++;
      if (colorCount > 4) {
        colorCount = 0;
      }
    });
  }

  void onAddCard(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (builderCtx) {
          return GestureDetector(
            onTap: () {},
            behavior: HitTestBehavior.opaque,
            child: NewTransaction(_addNewTransaction),
          );
        });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Koumi App'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.add), onPressed: () => onAddCard(context))
        ],
      ),
      body: _transactions.isEmpty
          ? Container(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Image.asset(
                      'assets/noData.jpg',
                      fit: BoxFit.cover,
                    )
                  ]),
            )
          : SingleChildScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      child: Card(
                        child: Text('Main Card'),
                        elevation: 10,
                      ),
                    ),
                    //
                    TransactionList(_transactions),
                  ]),
            ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => onAddCard(context),
        backgroundColor: Colors.deepOrangeAccent[200],
      ),
    );
  }
}
