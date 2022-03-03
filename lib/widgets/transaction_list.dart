import 'package:expense_manager/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  const TransactionList(this.transactions, this.deleteTx);

  final List<Transaction> transactions;
  final Function deleteTx;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemBuilder: (context, index) {
          Transaction tx = transactions[index];
          return Card(
            margin: EdgeInsets.all(5),
            elevation: 5,
            child: Padding(
              padding: EdgeInsets.all(10),
              child: ListTile(
                leading: CircleAvatar(
                  radius: 30,
                  child: FittedBox(
                    child: Text("\$${tx.amount.toStringAsFixed(0)}"),
                  ),
                ),
                title: Text(
                  tx.title,
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
                subtitle: Text(DateFormat.yMMMEd().format(tx.date)),
                trailing: MediaQuery.of(context).size.width > 400
                    ? TextButton.icon(
                        onPressed: () => deleteTx(transactions[index].id),
                        icon: Icon(Icons.delete),
                        label: Text("Delete"),
                        style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all(
                                Theme.of(context).errorColor)),
                      )
                    : IconButton(
                        onPressed: () {
                          deleteTx(transactions[index].id);
                        },
                        icon: Icon(Icons.delete),
                        color: Colors.red,
                      ),
              ),
            ),
          );
        },
        itemCount: transactions.length,
      ),
    );
  }
}
