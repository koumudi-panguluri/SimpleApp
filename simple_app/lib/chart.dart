import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './chart_bar.dart';
import './models/transcation.dart';

class Chart extends StatelessWidget {
  final List<Transaction> _recentTransactions;
  Chart(this._recentTransactions);

  List<Map<String, Object>> get _userTransaction {
    return List.generate(7, (index) {
      var totalSum = 0.0;
      // var totalSumOfWeek = 0.0;
      final weekDay = DateTime.now().subtract(Duration(days: index));
      for (int i = 0; i < _recentTransactions.length; i++) {
        if (_recentTransactions[i].date.day == weekDay.day &&
            _recentTransactions[i].date.month == weekDay.month &&
            _recentTransactions[i].date.year == weekDay.year) {
          totalSum = totalSum + _recentTransactions[i].price;
        }
      }
      // totalSumOfWeek += totalSum;
      print(
          'day: ${DateFormat.E().format(weekDay).substring(0, 1)}, amount: $totalSum');
      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum,
        // 'percentage': totalSum == 0.0 ? 0.0 : (totalSum / totalSumOfWeek)
      };
    });
  }

  double get spendings {
    return _userTransaction.fold(0.0, (sum, item) {
      print("sum, ${sum + item['amount']}");
      return sum + item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    print(_userTransaction);
    return Card(
        color: Colors.white54,
        elevation: 6,
        margin: EdgeInsets.all(20),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: _userTransaction.map((data) {
              print('data,$data');
              return Flexible(
                fit: FlexFit.tight,
                child: ChartBar(
                    data['day'],
                    data['amount'],
                    data['amount'] == 0.0
                        ? 0.0
                        : (data['amount'] as double) / spendings),
              );
            }).toList()));
  }
}
