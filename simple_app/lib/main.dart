import 'dart:convert';

import 'package:flutter/material.dart';
import './models/http_exceptions.dart';
import './new_card_transaction.dart';
import './models/transcation.dart';
import './transaction_list.dart';
import './chart.dart';
import 'package:http/http.dart' as http;

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
  var url = "https://flutter-63d7e.firebaseio.com/expense.json";
  List<Transaction> _transactions = [];

  Future<void> getData() {
    return http.get(url).then((value) {
      print("value ${json.decode(value.body)}");
      final data = json.decode(value.body) as Map<String, dynamic>;
      final List<Transaction> _getTransaction = [];
      data.forEach((key, value) {
        _getTransaction.add(Transaction(
            title: value['title'],
            id: key,
            price: value['price'],
            date: DateTime.parse(value['date']),
            currency: '\$',
            color: colors[colorCount]));
        colorCount++;
        if (colorCount > 4) {
          colorCount = 0;
        }
      });

      setState(() {
        _transactions = _getTransaction;
      });
    }).catchError((error) {
      print("error occured $error");
      throw error;
    });
  }

  Future<void> _addNewTransaction(
      String name, double amount, DateTime date, String id) {
    var newTx;
    final index = _transactions.indexWhere((tx) => tx.id == id);
    if (id == null) {
      return http
          .post(url,
              body: json.encode({
                'title': name,
                'price': amount,
                'date': date.toString(),
              }))
          .then((value) {
        print('decode: ${json.decode(value.body)}');
        newTx = Transaction(
            title: name,
            id: json.decode(value.body)['name'],
            price: amount,
            currency: '\$',
            date: date,
            color: colors[colorCount]);
        setState(() {
          print("id $id length ${_transactions.length}");
          _transactions.add(newTx);
          colorCount++;
          if (colorCount > 4) {
            colorCount = 0;
          }
        });
      }).catchError((error) {
        print("error occured");
        throw error;
      });
    } else {
      var patchUrl = "https://flutter-63d7e.firebaseio.com/expense/$id.json";
      return http
          .patch(patchUrl,
              body: json.encode({
                'title': name,
                'price': amount,
                'date': date.toString(),
              }))
          .then((value) {
        print("after edit ${json.decode(value.body)}");
        final newTx = Transaction(
            title: name,
            id: json.decode(value.body)['name'],
            price: amount,
            currency: '\$',
            date: date,
            color: colors[colorCount]);
        setState(() {
          _transactions[index] = newTx;
          colorCount++;
          if (colorCount > 4) {
            colorCount = 0;
          }
        });
      }).catchError((error) {
        print("error occured");
        throw error;
      });
    }
  }

  void _deleteTransaction(deleteTxId) async {
    String id = deleteTxId.id;
    final deleteUrl = "https://flutter-63d7e.firebaseio.com/expense/$id.json";
    final index = _transactions.indexWhere((tx) => tx.id == id);
    final response = await http.delete(deleteUrl);
    print("show delete response ${response.statusCode}");
    if (response.statusCode >= 400) {
      print("error occured");
      setState(() {
        _transactions.insert(index, deleteTxId);
      });
      throw HttpException('Deletion failed!');
    } else {
      setState(() {
        _transactions.remove(deleteTxId);
      });
    }
  }

  void onAddCard({BuildContext ctx, transactionData, id}) {
    showModalBottomSheet(
        context: ctx,
        builder: (builderCtx) {
          return GestureDetector(
            onTap: () {},
            behavior: HitTestBehavior.opaque,
            child: NewTransaction(_addNewTransaction, transactionData, id),
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

  @override
  void initState() {
    super.initState();
    print("Hello, Welcome to Koumi's App");
    getData().catchError((error) {
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
    });
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
