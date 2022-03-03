import 'package:expense_manager/models/transaction.dart';
import 'package:expense_manager/widgets/chart_bar.dart';
import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';
import 'package:collection/collection.dart';

class Chart extends StatelessWidget {
  final List<Transaction> transactions;
  Chart(this.transactions);

  Map<String, double> get groupedTransactionValues {
    final today = DateTime.now();
    Map<String, double> perDaySum = {};
    perDaySum.addEntries(Iterable.generate(7, (index) {
      var otherDay = today.subtract(Duration(days: index));
      var otherDayName = DateFormat.E().format(otherDay);
      return MapEntry(otherDayName, 0);
    }));
    for (var i = 0; i < transactions.length; i++) {
      var transactionTimestamp = transactions[i].date;
      var transactionDayName = DateFormat.E().format(transactionTimestamp);
      int gap = today.difference(transactionTimestamp).inDays;
      if (gap <= 7) {
        perDaySum[transactionDayName] =
            perDaySum[transactionDayName]! + transactions[i].amount;
      }
    }
    return perDaySum;
  }

  @override
  Widget build(BuildContext context) {
    Map<String, double> perDaySum = groupedTransactionValues;
    print(perDaySum);
    double totalSpending = perDaySum.values.toList().sum;
    return Card(
      // color: Theme.of(context).primaryColor,
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: perDaySum.keys.toList().reversed.map((e) {
            var amount = perDaySum[e];
            return Flexible(
                fit: FlexFit.tight,
                child: ChartBar(amount!, e,
                    totalSpending > 0 ? amount / totalSpending : 0.0));
          }).toList(),
        ),
      ),
    );
  }
}
