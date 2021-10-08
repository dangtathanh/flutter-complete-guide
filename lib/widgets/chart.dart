import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';
import '../widgets/chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  const Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );

      var totalSum = 0.0;
      for (var item in recentTransactions) {
        if (weekDay.year == (item.date?.year ?? -1) &&
            weekDay.month == (item.date?.month ?? -1) &&
            weekDay.day == (item.date?.day ?? -1)) {
          totalSum += item.amount;
        }
      }

      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum,
      };
    }).reversed.toList();
  }

  double get totalSpending{
    return groupedTransactionValues.fold(0.0, (sum, item) {
      return sum + (item['amount'] as double);
    });
  }

  double totalSpendingPct(double value, double total){
    if(total == 0)
    {
      return 0;
    }

    return value/total;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionValues.map((e) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                e['day'].toString(),
                e['amount'] as double,
                totalSpendingPct(
                  (e['amount'] as double),
                  totalSpending,
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
