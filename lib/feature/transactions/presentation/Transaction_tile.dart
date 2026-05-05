import 'package:flutter/material.dart';
import 'transactions_model.dart';

class TransactionTile extends StatelessWidget {
  final TransactionModel transaction;

  const TransactionTile({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(transaction.icon),
      title: Text(transaction.category),
      subtitle: Text(transaction.date.toString()),
      trailing: Text('${transaction.amount} EGP'),
    );
  }
}
