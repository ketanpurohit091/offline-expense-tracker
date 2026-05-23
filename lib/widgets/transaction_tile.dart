import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionTile extends StatelessWidget {
  final TransactionModel tx;
  final VoidCallback onDelete;

  TransactionTile({required this.tx, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        leading: CircleAvatar(
          child: Text(tx.type[0]),
          backgroundColor: tx.type == 'Income' ? Colors.green : Colors.red,
        ),
        title: Text(tx.title),
        subtitle: Text(DateFormat.yMMMd().format(tx.date)),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "${tx.type == 'Income' ? '+' : '-'}${tx.amount.toStringAsFixed(2)}",
              style: TextStyle(
                  color: tx.type == 'Income' ? Colors.green : Colors.red,
                  fontWeight: FontWeight.bold),
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}