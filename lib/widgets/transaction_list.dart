import 'package:flutter/material.dart';
import '../models/transaction.dart';
import './transaction_item.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;

  const TransactionList(this.transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: transactions.isEmpty
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'No transactions added yet.',
                  style: Theme.of(context).textTheme.headline6,
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 250,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            )
          : ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (ctx, index) {
                return TransactionItem(
                  transaction: transactions[index],
                  deleteTx: deleteTx,
                );
              },
            ),
    );
  }
}

