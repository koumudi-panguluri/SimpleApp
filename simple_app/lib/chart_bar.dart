import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String day;
  final double amount;
  final double percentage;
  ChartBar(this.day, this.amount, this.percentage);
  @override
  Widget build(BuildContext context) {
    print('details in chart bar $day, $amount, $percentage');
    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          Container(
            child: FittedBox(
              child: Text(
                '\$${amount.toStringAsFixed(0)}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(height: 4),
          Container(
            height: 60,
            width: 10,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1.0),
                      color: Color.fromRGBO(220, 220, 200, 10),
                      borderRadius: BorderRadius.circular(10)),
                ),
                FractionallySizedBox(
                  heightFactor: percentage,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10)),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 4),
          Text(day)
        ],
      ),
    );
  }
}
