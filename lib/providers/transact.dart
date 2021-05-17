import 'package:flutter/material.dart';

import '../models/transaction.dart';
import '../helpers/db_helper.dart';

class Transact with ChangeNotifier {
  List<Transaction> _items = [];

  List<Transaction> get items {
    return [..._items];
  }

  Future<void> addTransaction({
    String pickedTitle,
    String description,
    double amount,
    DateTime pickedDate,
    TransactionMode mode,
  }) async {
    final newTransaction = Transaction(
      id: DateTime.now().toString(),
      title: pickedTitle,
      description: description,
      dateTime: pickedDate,
      transactionMode: mode,
      amount: amount,
    );
    print(items);
    _items.add(newTransaction);
    notifyListeners();
    await DBHelper.insert('user_transcions', {
      'id': newTransaction.id,
      'title': newTransaction.title.trim(),
      'description': newTransaction.description.trim(),
      'amount': newTransaction.amount,
      'date': newTransaction.dateTime.toIso8601String(),
      'mode': newTransaction.transactionMode.toString(),
    });
  }

  Future<void> fetchAndSetPlaces() async {
    final dataList = await DBHelper.getData('user_transcions');
    _items = dataList
        .map(
          (item) => Transaction(
            id: item['id'],
            title: item['title'],
            description: item['description'],
            amount: item['amount'],
            transactionMode: item['mode'],
            dateTime: item['date'],
          ),
        )
        .toList();
    print(_items.toString());
    notifyListeners();
  }
}
