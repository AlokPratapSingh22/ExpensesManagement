import 'package:flutter/cupertino.dart';

class Transaction {
  final String id;
  final String title;
  final String description;
  final double amount;
  final TransactionMode transactionMode;
  final DateTime dateTime;

  /// {@template of a [Transaction]}
  /// holds all information about a [Transaction]
  /// Takes the required details about [Transaction]

  Transaction({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.amount,
    @required this.transactionMode,
    @required this.dateTime,
  });
}

/// modes of [transaction]

enum TransactionMode {
  CreditCard,
  Cash,
}
